package SpringGameJam {
	
	import starling.display.Sprite;
	import SpringGameJam.Unit;
	
	public class ActionOverlay extends Sprite {
	
		var target:Unit;
		var currentLevel:Grid;

		public function ActionOverlay() 
		{
			currentLevel = Game.GetInstance()._Level
		}
		
	
		public function HideOverlay():void
		{
			
		}
		
		
		public function ShowOverlay(target:Unit):Dictionary
		{
			this.target = target;
			var currentTile:Tile;
			var moveDistance = target.GetMove();
			var moveCost:int = 0;
			var closedSet:Vector.<Tile> = new Vector.<Tile>();
			var openSet:Vector.<Tile> = new Vector.<Tile>();
				openSet.push(target.getTile());
			var visitedTiles:Dictionary = new Dictionary();
			var neighboringTiles:Vector.<Tile> = new Vector.<Tile>();
			var aNeighbor:Tile;

			while(openSet[0] != Null)
			{
				if(moveDistance <= moveCost)
				{
					currentTile = openSet.shift();
					closedSet.push(currentTile);
					neighboringTiles = currentLevel.GetAdjacentTiles(currentTiles);
					while(neighboringTiles[0] != null)
					{
						aNeighbor = neighboringTiles.shift();
						if(openSet.indexOf(aNeighbor,0) == -1)
						{
							if(closedSet.indexOf(aNeighbor,0) == -1)
							{
								if(aNeighbor.GetActive())
								{
									openSet.push(aNeighbor);
									visitedTiles[aNeighbor] = currentTile;
								}
							}
						}
					}
				}
				else
					break;
				moveCost++;
				
			}
			
			return visitedTiles;
		}

	}
	
}
