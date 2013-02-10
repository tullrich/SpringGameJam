package SpringGameJam {
	
	import starling.display.Sprite;
	import SpringGameJam.Unit;
    import flash.utils.Dictionary;
	import starling.display.Image;
	
	public class ActionOverlay extends Sprite {
	
		var target:Unit;
		var came_from:Dictionary = new Dictionary();
		var reachable:Vector.<Tile> = new Vector.<Tile>();
		var currentLevel:Grid;

		public function ActionOverlay() 
		{
			currentLevel = Game.GetInstance()._level
		}
		
	
		public function HideOverlay():void
		{
			
		}
		
		
		public function ShowOverlay(target:Unit):void
		{
			this.target = target;
			came_from =  new  Dictionary();
			
			ComputePaths();
			CreateOverlayTiles();
		}
		
		private function CreateOverlayTiles()
		{
			for each (var key:Tile in reachable)
			{
				var _mc:Image = new Image(Assets.getTexture("OverlayMove"));
				_mc.x = key.x;
				_mc.y = key.y;
				addChildAt(_mc, 0);
			}
				 
		}
		
		private function ComputePaths():void
		{
			var currentTile:Tile;
			var unitMove = target.GetMove();
			var depth:int = 0;
			var closedSet:Vector.<Tile> = new Vector.<Tile>();
			var openSet:Vector.<Tile> = new Vector.<Tile>();
			openSet.push(target.tile);
			var neighboringTiles:Vector.<Tile> = new Vector.<Tile>();

			while(openSet.length > 0)
			{
				if(unitMove < depth)
				{
					break;
				}
				
				var tempOpen:Vector.<Tile> = new Vector.<Tile>()
				for each (var curTile:Tile in openSet)
				{
					closedSet.push(curTile);
					neighboringTiles = currentLevel.GetAdjacentTiles(curTile);
					
					for each (var neighbor:Tile in neighboringTiles)
					{
						if(openSet.indexOf(neighbor,0) == -1)
						{
							if(closedSet.indexOf(neighbor,0) == -1)
							{
								if(tempOpen.indexOf(neighbor,0) == -1)
								{
									if(neighbor.GetActive())
									{
										tempOpen.push(neighbor);
										came_from[neighbor] = curTile;
									}
								}
							}
						}
					}
				
				}
				
				openSet = tempOpen;
				depth++;
			}
			
			reachable = closedSet;
		}
		
		public function ReturnPath(CameFrom:Tile, CurrentTile:Tile)
		{
			
		}

	}
	
}
