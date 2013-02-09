package SpringGameJam {
	
	import starling.display.Sprite;
	import SpringGameJam.Grid;
	
	public class Game extends Sprite {
		
		static var _level:Grid;

		public function Game() {
			
			CreateLevel();
		}
		
		private function CreateLevel():void
		{
			_level = new Grid(10, 10);
			
			_level.x = 300;
			_level.y = 100;
			addChild(_level);
		}
		
		public static function GetGrid():Grid
		{
			return _level;
		}
	}
	
}
