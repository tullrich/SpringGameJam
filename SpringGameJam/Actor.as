package SpringGameJam 
{
	import starling.text.TextField;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.animation.Tween;
	import starling.animation.Transitions;
	
	public class Actor extends Unit
	{
		var currentHealth:int;
		var maxHealth:int;
		var hpString:String;
		var movementSpeed:int;
		var damage:int;
		var bHasMoved:Boolean;
		var bHasAttacked:Boolean;
		var _hp:TextField;
		
		var movementAnimation:String;
		
		public function Actor() 
		{
			super();
			maxHealth = 50;
			currentHealth = 50;
			hpString = "HP:" + currentHealth +"/"+ maxHealth;
			movementSpeed = 3;
			damage = 10;
			bHasMoved = false;
			bHasAttacked = false;
			_hp = new TextField(64,16,"","Verdana",12,0x000000,false);
		}
		
		override public function init(e:Event):void
		{	 
			super.init(e);
			_hp.text = hpString;
			addChild(_hp);
		}
		
		public function takeDamage(d:int)
		{
			currentHealth -= d;
			if(currentHealth >= 0)
			{
				_hp.text = currentHealth +"/"+ maxHealth;
			}
			else
			{
				
			}
		}
		
		public function MoveTo(newTile:Tile, path:Vector.<Tile>):void
		{
			trace("moveto");
			
			if(!visible)
			{
				Place(newTile);
				return;
			}
			
			tweenPath = path;
			Game.GetInstance().ToggleCinematic(true);
			
			if (_tile != null)
			{
				_tile.RemoveResident();
			}
			newTile.SetResident(this);
			
			TickPath()
		}
		
		public function TickPath()
		{
			if(tweenPath.length > 0)
			{
				var nextTile:Tile = tweenPath.shift();
				var tween:Tween = new Tween(this, .1, Transitions.LINEAR);
				tween.animate("x", nextTile.x);
				tween.animate("y", nextTile.y);
				tween.onComplete = TickPath;
				Starling.juggler.add(tween);
				
				LookTowards(nextTile);
			}
			else
			{
				MoveCompleted();
			}
		}
		
		public function MoveCompleted():void
		{
			Game.GetInstance().ToggleCinematic(false);
		}

	}
	
}
