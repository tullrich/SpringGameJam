package SpringGameJam {
	
	import starling.display.Sprite;
	import SpringGameJam.Grid;
	import SpringGameJam.ActionOverlay;
	
	public class Game extends Sprite {
		
		static var _instance:Game;
		var _level:Grid;
		var _targeter:ActionOverlay;

		public function Game() 
		{
			_instance = this;
			
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
			_targeter.HideOverlay();
			addChild(_targeter);
		}
		
		static function GetInstance():Game
		{
			return _instance;
		}
		
		public function GetGrid():Grid
		{
			return _level;
		}
		
		public function GetActionOverlay():ActionOverlay
		{
			return _targeter;
		}
		
	}
	
}
