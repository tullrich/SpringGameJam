package SpringGameJam {
	
	import starling.core.Starling;
	import starling.events.Event;
	import starling.display.Sprite;
    import flash.utils.Dictionary;
	import SpringGameJam.ActionOverlay;
	
	public class Grid extends Sprite {
		
		var xTiles:uint, yTiles:uint;
		var mapinfo:Array;
		var tileSize;uint;
		
		var Map:Dictionary = new Dictionary();
		var _targeter:ActionOverlay;

		public function Grid(x:uint, y:uint, info:Array) {
			xTiles = x;
			yTiles = y;
			
			mapinfo = info;
			tileSize = 48;
		}
		
		public function AddUnit(u:Unit, x:int, y:int):void
		{
			if( Map[x][y] != null && Map[x][y].IsOpen())
			{
				addChild(u);
				u.Place(Map[x][y])
			}
			else
			{
				trace("Could not place " + u + " at " + x + "x" + y);
			}
		}
		
		public function RemoveUnit(u:Actor):void
		{
			u._tile.RemoveResident();
			removeChild(u);
		}
		
		
		public function init():void
		{
			var dim_x:int = xTiles;
			var dim_y:int = yTiles;
			
			for(var i:int = 0; i < dim_x; i++)
			{
				var innerArray:Dictionary = new Dictionary();
				for(var j:int = 0; j < dim_y; j++)
				{
					innerArray[j] = CreateShapeAt(i, j);
				}
				
				Map[i] = innerArray;
			}
			
			CreateOverlays();
			
		}
		
		private function CreateOverlays():void
		{
			_targeter = new ActionOverlay();
			_targeter.HideOverlay();
			addChild(_targeter);
		}
		
		private function CreateShapeAt(x:int, y:int):Tile
		{
			var newtile:Tile = new Tile(x, y);
			newtile.x = x * tileSize;
			newtile.y = y * tileSize;
			newtile.bIsActive = mapinfo[y][x] != 0;
			addChild(newtile); 
			
			return newtile;
		}
		
		public function GetAdjacentTiles(tile:Tile, includeDiagonal:Boolean = false):Vector.<Tile>
		{
			var adjacent:Vector.<Tile> = new Vector.<Tile>();
			
			var leftOk = tile.xindex - 1 >= 0;
			var rightOk = tile.xindex + 1 < xTiles;
			var downOk = tile.yindex + 1 < yTiles;
			var upOk = tile.yindex - 1 >= 0;
			
			// right side 
			if (rightOk)
			{
				adjacent.push(Map[tile.xindex + 1][tile.yindex]);
			}
			
			// left side
			if (leftOk)
			{
				adjacent.push(Map[tile.xindex - 1][tile.yindex]);
			}
						
			// bottom side 
			if (downOk)
			{
				adjacent.push(Map[tile.xindex][tile.yindex + 1]);
			}
			
			// top side
			if (upOk)
			{
				adjacent.push(Map[tile.xindex][tile.yindex - 1]);
			}
			
			if (includeDiagonal)
			{
				// top left
				if (upOk && leftOk)
				{
					adjacent.push(Map[tile.xindex - 1][tile.yindex - 1]);
				}
				// bottom left
				if (downOk && leftOk)
				{
					adjacent.push(Map[tile.xindex + 1][tile.yindex - 1]);
				}
				// top right
				if (upOk && rightOk)
				{
					adjacent.push(Map[tile.xindex - 1][tile.yindex + 1]);
				}
				// bottom right
				if (downOk && rightOk)
				{
					adjacent.push(Map[tile.xindex + 1][tile.yindex + 1]);
				}
			}
			
			return adjacent;
		}
		
		public function GetFreeAdjacent(tile:Tile):Vector.<Tile>
		{
			var openAdjacent:Vector.<Tile> = new Vector.<Tile>();
			
			for each(var t:Tile in GetAdjacentTiles(tile))
			{
				if (t.IsOpen())
				{
					openAdjacent.push(t);
				}
			}
			
			return openAdjacent;
		}
		
		public function GetActionOverlay():ActionOverlay
		{
			return _targeter;
		}
		
		public function HandleClick(clicked:Tile):Boolean
		{
			if (_targeter.IsVisible())
			{
				_targeter.HandleClick(clicked);
			
				return true;
			}
			
			return false;
		}
		

	}
	
}
