package SpringGameJam 
{
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.animation.Tween;
	import starling.animation.Transitions;
	import starling.display.Image;
	
	public class Actor extends Unit
	{
		var movementSpeed:int;
		var bHasMoved:Boolean;
		var bHasAttacked:Boolean;
		var bPlayerControlled:Boolean;
		var awaitingInteract:Tile;
		var Victim:Unit;
		
		var AttackAnimation:String;
		var WalkAnimation:String;
		var WalkClip:MovieClip;
		
		var power:int;
		var healpower:int;
		
		public function Actor() 
		{
			super();
			power = 1;
			healpower = 1;
			awaitingInteract = null;
			movementSpeed = 3;
		}
		
		override public function init(e:Event):void
		{
			super.init(e);
			_hp.color = (bPlayerControlled) ? 0x00FF00 : 0xFF0000;
		}
		
		public function MoveTo(newTile:Tile, path:Vector.<Tile>):void
		{
			if(!visible)
			{
				Place(newTile);
				return;
			}
			
			//path.pop();
			tweenPath = path;
			Game.GetInstance().ToggleCinematic(true);
			
			WalkClip = new MovieClip(Assets.getTexturesFromAtlas(WalkAnimation), 4);
			WalkClip.pivotX = WalkClip.x = (WalkClip.height) / 2;
			WalkClip.pivotY = WalkClip.y = (WalkClip.width) / 2;
			PlayAnimation(WalkClip, null, true);
			
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
			WalkClip.dispatchEventWith("AnimationReturn");
			WalkClip = null;
			
			if(awaitingInteract != null)
			{
				LookTowards(awaitingInteract);
				Interact(awaitingInteract.resident);
			}
			else
			{
				EndTurn();
				Game.GetInstance().ToggleCinematic(false);
			}
			
			awaitingInteract = null;
		}
		
		public function MoveToAndInteract(interactTile:Tile, newTile:Tile, path:Vector.<Tile>):void
		{
			awaitingInteract = interactTile;
			trace("interactTile " + interactTile);
			trace("mytile " + _tile);
			trace("path " + path);
			MoveTo(newTile, path);
		}
		
		public function ResetMoves()
		{
			bHasMoved = false;
			bHasAttacked = false;
		}
		
		public function Interact(unit:Unit):void
		{
			
		}
		
		public function CanInteract(unit:Unit):Boolean
		{
			return false;
		}
		
		public function Attack(u:Unit):void
		{
			var anim:MovieClip = new MovieClip(Assets.getTexturesFromAtlas(AttackAnimation), 5);
			anim.pivotX = anim.x = (anim.height) / 2;
			anim.pivotY = anim.y = (anim.width) / 2;
			Victim = u;
			PlayAnimation(anim, AttackComplete);
			LookTowards(u._tile);
		}
		
		public function AttackComplete():void
		{	
			if( Victim != null)
			{
				Victim.TakeDamage(power);
				Victim =  null;
				EndTurn();
			}
			
			Game.GetInstance().ToggleCinematic(false);
		}
		
		public function EndTurn():void
		{
			bHasMoved = true;
			if(Game.GetInstance().playersUnits.indexOf(this) != -1)
			{
				if(Game.GetInstance().CheckPlayerDone())
				{
					Game.GetInstance().FlashButton();
				}
			}
			disable();
		}
		
		public function NewTurn():void
		{
			bHasMoved = false;
			enable();
		}
		
		public function HasAction():Boolean
		{
			return !bHasMoved;
		}
		
		public function IsPlayerControlled():Boolean
		{
			return bPlayerControlled;
		}
		
		override public function TakeDamage(d:int)
		{
			currentHealth -= d;
			if(currentHealth > 0)
			{
				_hp.text = "" + currentHealth;
			}
			else
			{
				Game.GetInstance().RemoveUnit(this);
			}
		}
		
		public function Heal(u:Unit):void
		{
			var anim:MovieClip = new MovieClip(Assets.getTexturesFromAtlas(AttackAnimation), 4);
			anim.pivotX = anim.x = (anim.height) / 2;
			anim.pivotY = anim.y = (anim.width) / 2;
			Victim = u;
			PlayAnimation(anim, HealComplete);
			LookTowards(u._tile);
		}
		
		public function HealComplete():void
		{	
			if( Victim != null)
			{
				Victim.GainHealth(healpower);
				Victim =  null;
				EndTurn();
			}
			
			Game.GetInstance().ToggleCinematic(false);
		}

	}
	
}
