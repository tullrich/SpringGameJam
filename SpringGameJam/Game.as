package SpringGameJam {
	
	import starling.display.Sprite;
	import SpringGameJam.Grid;
	import SpringGameJam.ActionOverlay;
	
	public class Game extends Sprite {
		
		static var _level:Grid;
		static var _targeter:ActionOverlay;

		public function Game() {
			
			CreateLevel();
			CreateOverlays();
		}
		
		private function CreateLevel():void
		{
			_level = new Grid(10, 10);
			
			_level.x = 300;
			_level.y = 100;
			addChild(_level);
		}
		
		private function CreateOverlays():void
		{
			_targeter = new ActionOverlay();
			_targeter.hide();
			addChild(_targeter);
		}
		
		public static function GetGrid():Grid
		{
			return _level;
		}
		
		public static function GetActionOverlay():ActionOverlay
		{
			return _targeter;
		}
		
	}
	
}
