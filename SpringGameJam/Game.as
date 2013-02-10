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
	import starling.utils.HAlign;
	import starling.text.TextField;
	
	public class Game extends Sprite {
		
		static var _instance:Game;
		var _level:Grid;
		var _interceptor:Sprite;
		var bIntercepting;
		var AllUnits:Vector.<Actor>
		var enemy:EnemyPlayer;
		var playersUnits:Vector.<Actor>;
		var _TurnCount:TextField, _announceText:TextField;
		var turnNum:uint;

		public function Game() 
		{
			_instance = this;
			turnNum = 1;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init():void
		{
			CreateBackground();
			CreateGameField();
			CreateUI();
			
			BeginPlayerTurn();
		}
		
		private function StartGame()
		{
		}
		
		
		public function CreateUnitAt(unitClass:Class, x:uint, y:uint):void
		{
			var u:Unit = new unitClass();
			
			if(u is Actor && Actor(u).IsPlayerControlled())
			{
				playersUnits.push(u);
			}
			else if(u is Actor)
			{
				enemy.ControlUnit(Actor(u));
			}
			
			_level.AddUnit(u, x, y);
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
        	_interceptor.addEventListener(TouchEvent.TOUCH, InterceptorClicked);
			_interceptor.addChild( new Image(Assets.getTexture("Interceptor")) );
			addChild(_interceptor);
			bIntercepting = true;
			
			playersUnits = new Vector.<Actor>;
			enemy = new EnemyPlayer();
			_level.init();
			
			for each (var u:Object in Level1.Units)
			{
				CreateUnitAt(u["class"], u["x"], u["y"]);
			}
		}
		
		private function CreateUI():void
		{
			var _NextTurn:Button = new Button(Assets.getTexture("NextTurnButtonUp"), "Next Turn" , Assets.getTexture("NextTurnButtonDown"));
			_NextTurn.addEventListener(Event.TRIGGERED, EndPlayerTurn);
			_NextTurn.x = 1024 - _NextTurn.height;
			_NextTurn.y = 800 - _NextTurn.height;
			addChild(_NextTurn);
			
			_announceText = new TextField(1024,800,"","Verdana",40,0x000000,true);
			_announceText.visible = false;
			_announceText.alpha = 0;
			addChild(_announceText);
			
			_TurnCount = new TextField(256,64,"","Verdana",40,0xFFFFFF,true);
			_TurnCount.underline = true;
			_TurnCount.x = 20;
			_TurnCount.y = 800 - 64;
			_TurnCount.hAlign = HAlign.LEFT;
			_TurnCount.text = "Turn " + turnNum;
			addChild(_TurnCount);
		}
		
		private function UpdateUI():void
		{
			_TurnCount.text = "Turn " + turnNum;
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
		
		public function DisableCinematic():void
		{
			ToggleCinematic(false);
			StartGame();
		}
		
		public function EnableCinematic():void
		{
			ToggleCinematic(true);
		}
		
		public function Announce(text:String, callBack:Function = null)
		{
			_announceText.text = text;
			_announceText.visible = true;
			
			var tween:Tween = new Tween(_announceText, 1, Transitions.LINEAR);
			tween.fadeTo(1);
			tween.animate("visible", 1);
			tween.repeatCount = 2;
			tween.reverse = true;
			
			if (callBack != null)
			{
				tween.onComplete = callBack;
			}
			
			Starling.juggler.add(tween);
		}
		
		public function BeginPlayerTurn():void
		{
			ToggleCinematic(true);
			Announce("Your Turn!", DisableCinematic);
		}
		
		public function EndPlayerTurn(e:Event):void
		{	
			ToggleCinematic(true);
			
			for each(var item:Actor in playersUnits)
			{
				item.NewTurn();
			}
			
			BeginEnemyTurn();
		}
		
		public function BeginEnemyTurn():void
		{
			Announce("Enemy Turn!", enemy.TakeTurn);
		}
		
		public function EndEnemyTurn():void
		{	
			enemy.RestartUnits();
			
			turnNum++;
			UpdateUI();
			BeginPlayerTurn();
		}
		
		
	}
	
}
