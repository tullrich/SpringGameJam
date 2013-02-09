package SpringGameJam {
	
	import starling.display.Sprite;
	import SpringGameJam.Grid;
	
	public class Game extends Sprite {
		
		var level1:Grid;

		public function Game() {
			level1 = new Grid(10, 10);
			
			level1.x = 300;
			level1.y = 100;
			addChild(level1);
		}
		

	}
	
}
