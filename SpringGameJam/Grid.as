package SpringGameJam {
	
	import starling.core.Starling;
	import starling.events.Event;
	import starling.display.Sprite;
	
	public class Grid extends Sprite {
		
		var xTiles:uint, yTiles:uint;
		var Map:Object = new Object();

		public function Grid(x:uint, y:uint) {
			
			xTiles = x;
			yTiles = y;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		
		private function init():void
		{
			var dim_x:int = xTiles;
			var dim_y:int = yTiles;
			
			trace("height " + height + " width " + width);
			trace("dim_x " + dim_x + " dim_y " + dim_y);
			
			for(var i:int = 0; i < dim_x; i++)
			{
				for(var j:int = 0; j < dim_y; j++)
				{
					CreateShapeAt(i * 64, j * 64);
				}
			}
		}
		
		private function CreateShapeAt(x:int, y:int):void
		{
			var rectangle:Tile = new Tile(x, y);
			addChild(rectangle); 
		}

	}
	
}
