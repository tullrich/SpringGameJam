package SpringGameJam {
	
	import starling.display.Sprite;
	import SpringGameJam.Robot;
	import SpringGameJam.Level1;
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class Game extends Sprite {
		
		static var _instance:Game;
		var _level:Grid;
		var _interceptor:Sprite;
		var bIntercepting;
		
		var units:Vector.<Unit>;

		public function Game() 
		{
			_instance = this;
			bIntercepting = false;
			
			CreateLevel();
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init():void
		{
			_level.init();
			CreateUnitAt(Robot, 1, 3);
			CreateUnitAt(Fireman, 1, 2);
		}
		
		public function CreateUnitAt(unitClass:Class, x:uint, y:uint):void
		{
			var u:Unit = new unitClass();
			_level.AddUnit(u, x, y);
		}
		
		private function CreateLevel():void
		{
			
			var _mc:Image = new Image(Assets.getTexture("BgWater"));
			addChild(_mc);
			
			
			_mc = new Image(Assets.getTexture("BgAirplane"));
			addChild(_mc);
			
			_level = new Grid(42, 33, Level1.Info);
			addChild(_level);
			
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
