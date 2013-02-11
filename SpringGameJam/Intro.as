package SpringGameJam {
	
	import starling.animation.Tween;
	import starling.animation.Transitions;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.display.MovieClip;
	import starling.utils.HAlign;
	import starling.text.TextField;
	
	public class Intro extends Sprite {
		
		static var _instance:Intro;
		var stage1:Image, stage2:Image, stage3:Image;
		var introstage:int;

		public function Intro() {
			_instance = this;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init():void
		{
			CreateBackground();
			
			
			stage1 = new Image(Assets.getTexture("TitleScreen"));
			stage2 = new Image(Assets.getTexture("HelpScreen"));
			stage3 = new Image(Assets.getTexture("AirplaneTop"));
			
			
			Stage1();
        	addEventListener(TouchEvent.TOUCH, Advance);
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
		}
		
		private function Advance(e:TouchEvent)
		{ 
			var touch:Touch = e.getTouch(this);  
            if (touch && touch.phase == TouchPhase.ENDED) 
			{  
				if(introstage == 1)
				{
					Stage2();
				}
				else if (introstage == 2)
				{
					Stage3();
				}
			}
		}

		
		private function Stage1():void
		{
			introstage = 1;
			stage1.alpha = 0;
			stage1.y = 0;
			addChild(stage1);
			var tween = new Tween(stage1, 1, Transitions.EASE_IN);
			tween.fadeTo(1);
			Starling.juggler.add(tween);
		}
		
		
		private function Stage2():void
		{
			introstage = 2;
			Starling.juggler.removeTweens(stage1);
			var tweenzz:Tween = new Tween(stage1, 1, Transitions.EASE_IN);
			tweenzz.fadeTo(0);
			
			
			stage2.alpha = 0;
			stage2.y = 0;
			addChild(stage2);
			var tween:Tween = new Tween(stage2, 1, Transitions.EASE_IN);
			tween.fadeTo(1);
			tweenzz.nextTween = tween;
			
			Starling.juggler.add(tweenzz);
		}
		
		private function Stage3():void
		{
			introstage = 3;
			Starling.juggler.removeTweens(stage2);
			
			var tweenzz:Tween = new Tween(stage2, 1, Transitions.EASE_IN);
			tweenzz.fadeTo(0);
			
			stage3.y = -1024;
			addChild(stage3);
			var tween:Tween = new Tween(stage3, 5, Transitions.EASE_OUT);
			tween.animate("y", 0);
			tween.onComplete = Launch;
			tweenzz.nextTween = tween;
			Starling.juggler.add(tweenzz);
		}
		
		private function Launch():void
		{
			while (numChildren > 0) {
				this.removeChildAt(0);
			}
			this.removeEventListeners();
			
			var g:Game = new Game();
			//g.alpha = 0;
			addChild(g);
			//var tween:Tween = new Tween(g, 1, Transitions.EASE_OUT);
			//tween.fadeTo(1);
			//Starling.juggler.add(tween);
		}
		
		public function GameOver(turn:int):void
		{
			while (numChildren > 0) {
				this.removeChildAt(0);
			}
			this.removeEventListeners();
			
			
			CreateBackground();
			
			var over:MovieClip = new MovieClip(Assets.getTexturesFromAtlas("BurningPlane"), 4);
			over.x = (width / 2) - over.width / 2;
			over.y = -500;
			addChild(over);
			Starling.juggler.add(over);
			
			
			var tween:Tween = new Tween(over, 25, Transitions.LINEAR);
			tween.animate("y", height);
			Starling.juggler.add(tween);
			
			
			
			var gotext:TextField = new TextField(1024,800,"","Verdana",60,0xFFFFFF,true);
			gotext.text = "Game Over\nYou reached Turn " + turn + "!";
			gotext.alpha = 0;
			addChild(gotext);
			
			var tween2:Tween = new Tween(gotext, 1.5, Transitions.EASE_IN);
			tween2.fadeTo(1);
			Starling.juggler.add(tween2);
			
		}
	}
	
}
