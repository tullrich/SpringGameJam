package SpringGameJam {
	
	import starling.display.Sprite;
	import SpringGameJam.Unit;
	import SpringGameJam.Tile;
	
	public class ActionOverlay extends Sprite {
	
		var target:Unit;

		public function ActionOverlay() {
		}
		
	
		public function HideOverlay():void
		{
			
		}
		
		
		public function ShowOverlay(target:Unit):void
		{
			this.target = target;
			var moveDistance = target.GetMove();
		}
		
		public function FindPath(startPosition:Tile,endPosition:Tile):Vector
		{
/*			var closedSet:Vector.<Tile> = new Vector.<Tile>();
			var openSet:Vector.<Tile> = new Vector.<Tile>();
				openSet.push(startPosition);
			var visitedTiles:Vector.<Tile> = new Vector.<Tile>();

			while(openSet.length > 0)*/
			
			return null;
		}

	}
	
}
