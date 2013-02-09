package SpringGameJam {
	
	import starling.display.Sprite;
	import SpringGameJam.Unit;
	
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
		
		public function Vector FindPath(startPosition:Tile,endPosition:Tile)
		{
			var closedSet:Vector.<Tile> = new Vector.<Tile>();
			var openSet:Vector.<Tile> = new Vector.<Tile>();
				openSet.push(startPosition);
			var visitedTiles:Vector.<Tile> = new Vector.<Tile>();

			while(openSet.length > 0)
		}

	}
	
}
