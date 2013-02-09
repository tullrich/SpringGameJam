package SpringGameJam {
	
	import starling.display.Sprite;
	import SpringGameJam.Grid;
	import starling.display.Image;
	import SpringGameJam.ActionOverlay;
	import starling.events.Touch;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class Game extends Sprite {
		
		static var _instance:Game;
		var _level:Grid;
		var _targeter:ActionOverlay;
		var _interceptor:Sprite;
		var bIntercepting;
		
		var units:Vector.<Unit>;

		public function Game() 
		{
			_instance = this;
			bIntercepting = false;
			
			CreateLevel();
			CreateOverlays();
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init():void
		{
			_level.init();
			CreateUnitAt(Unit, 5, 4);
		}
		
		public function CreateUnitAt(unitClass:Class, x:uint, y:uint):void
		{
			var u:Unit = new unitClass();
			_level.AddUnit(u, x, y);
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
			
			_interceptor = new Sprite();
			_interceptor.height = height;
			_interceptor.width = width;
        	_interceptor.addEventListener(TouchEvent.TOUCH, InterceptorClicked);
			_interceptor.addChild( new Image(Assets.getTexture("Interceptor")) );
		}
		
		private function InterceptorClicked(e:TouchEvent)
		{ 
			var touch:Touch = e.getTouch(this);  
            if (touch && touch.phase == TouchPhase.ENDED) 
			{  
				e.stopPropagation();
			}
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
		
		public function ToggleCinematic(toggle:Boolean):void
		{
			if(toggle && !bIntercepting)
			{
				bIntercepting = true;
				addChild(_interceptor);
			}
			else if (!toggle && bIntercepting)
			{
				bIntercepting = false;
				removeChild(_interceptor);
			}
		}
		
	}
	
}
