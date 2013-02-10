package SpringGameJam {
	
	import starling.display.Sprite;
	import SpringGameJam.Robot;
	import SpringGameJam.Level1;
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.display.Button;
	import starling.animation.Tween;
	import starling.animation.Transitions;
	import starling.core.Starling;
	
	public class Game extends Sprite {
		
		static var _instance:Game;
		var _level:Grid;
		var _interceptor:Sprite;
		var bIntercepting;
		var AllUnits:Vector.<Actor>
		
		var actors:Vector.<Unit>;

		public function Game() 
		{
			_instance = this;
			bIntercepting = false;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init():void
		{
			CreateBackground();
			CreateGameField();
			CreateUI();
			
			_level.init();
			
			for each (var u:Object in Level1.Units)
			{
				CreateUnitAt(u["class"], u["x"], u["y"]);
			}
		}
		
		public function CreateUnitAt(unitClass:Class, x:uint, y:uint):void
		{
			var u:Unit = new unitClass();
			_level.AddUnit(u, x, y);
			/*if(u is Actor)
			{
				actors.push(u);
			}*/
		}
		
		private function CreateBackground():void
		{
			var _mc:Image = new Image(Assets.getTexture("BgWater"));
			_mc.y = -1024;
			addChild(_mc);
			var tween:Tween = new Tween(_mc, 5, Transitions.LINEAR);
			tween.repeatCount = 0;
			tween.animate("y", -1024 - 2048);
			Starling.juggler.add(tween);
			
			var _mc2:Image = new Image(Assets.getTexture("BgWater"));
			_mc2.y = 1024;
			addChild(_mc2);
			var tween2:Tween = new Tween(_mc2, 5, Transitions.LINEAR);
			tween2.repeatCount = 0;
			tween2.animate("y", -1024);
			Starling.juggler.add(tween2);
			
			var _mc3:Image = new Image(Assets.getTexture("Clouds"));
			_mc3.y = -1024;
			addChild(_mc3);
			var tween3:Tween = new Tween(_mc3, 8, Transitions.LINEAR);
			tween3.repeatCount = 0;
			tween3.animate("y", -1024 - 2048);
			Starling.juggler.add(tween3);
			
			var _mc4:Image = new Image(Assets.getTexture("Clouds"));
			_mc4.y = 1024;
			addChild(_mc4);
			var tween4:Tween = new Tween(_mc4, 8, Transitions.LINEAR);
			tween4.repeatCount = 0;
			tween4.animate("y", -1024);
			Starling.juggler.add(tween4);
			
			
			
			
			_mc = new Image(Assets.getTexture("BgAirplane"));
			addChild(_mc);
		}
		
		private function CreateGameField():void
		{
			
			_level = new Grid(42, 33, Level1.Info);
			addChild(_level);
			
			_interceptor = new Sprite();
			_interceptor.height = height;
			_interceptor.width = width;
        	_interceptor.addEventListener(TouchEvent.TOUCH, InterceptorClicked);
			_interceptor.addChild( new Image(Assets.getTexture("Interceptor")) );
			
			//var _NextTurn:Button = new Button(NextTurnButtonUp,"NextTurn",NextTurnButtonDown);
			//_NextTurn.addEventListener(TouchEvent.TOUCH, NextTurn);
		}
		
		private function CreateUI():void
		{
			
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
		
		public function NextTurn()
		{
			for each(var item:Actor in actors)
			{
				item.ResetMoves();
			}
		}
		
		
	}
	
}
