package SpringGameJam {
	
	import starling.core.Starling;
	import starling.events.Event;
	import starling.display.Sprite;
    import flash.utils.Dictionary;
	import SpringGameJam.ActionOverlay;
	
	public class Grid extends Sprite {
		
		var xTiles:uint, yTiles:uint;
		var Map:Dictionary = new Dictionary();

		public function Grid(x:uint, y:uint) {
			xTiles = x;
			yTiles = y;
		}
		
		public function AddUnit(u:Unit, x:int, y:int):void
		{
			if( Map[x][y] != null && Map[x][y].HasRoom())
			{
				Map[x][y].SetResident(u);
				addChild(u);
			}
		}
		
		
		public function init():void
		{
			var dim_x:int = xTiles;
			var dim_y:int = yTiles;
			
			trace("height " + height + " width " + width);
			trace("dim_x " + dim_x + " dim_y " + dim_y);
			
			for(var i:int = 0; i < dim_x; i++)
			{
				var innerArray:Dictionary = new Dictionary();
				for(var j:int = 0; j < dim_y; j++)
				{
					innerArray[j] = CreateShapeAt(i * 64, j * 64);
				}
				
				Map[i] = innerArray;
			}
			
		}
		
		private function CreateShapeAt(x:int, y:int):Tile
		{
			var newtile:Tile = new Tile(x, y);
			addChild(newtile); 
			
			return newtile;
		}
		
		public function GetAdjacentTiles(tile:Tile):Vector.<Tile>
		{
			return null;
		}

	}
	
}
