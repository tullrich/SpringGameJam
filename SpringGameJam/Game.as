package SpringGameJam {
	
	import starling.core.Starling;
	import starling.display.Sprite;
	
	public class Game extends Sprite {
		
		var Map:Object = new Object();

		public function Game() {
			InitGrid();
		}
		
		
		private function InitGrid():void
		{
			var dim_x:int = Starling.current.stage.stageWidth / 64;
			var dim_y:int = Starling.current.stage.stageHeight / 64;
			
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
