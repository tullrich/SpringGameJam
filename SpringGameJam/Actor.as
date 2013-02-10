package SpringGameJam 
{
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.animation.Tween;
	import starling.animation.Transitions
	
	public class Actor extends Unit
	{
		var movementSpeed:int;
		var bHasMoved:Boolean;
		var bHasAttacked:Boolean;
		var bPlayerControlled:Boolean;
		var awaitingInteract:Tile;
		var Victim:Unit;
		
		var AttackAnimation:String;
		var movementAnimation:String;
		
		public function Actor() 
		{
			super();
			awaitingInteract = null;
			movementSpeed = 3;
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
			
			if(awaitingInteract != null)
			{
				LookTowards(awaitingInteract);
				Interact(awaitingInteract.resident);
			}
			else
			{
				MarkDone();
				Game.GetInstance().ToggleCinematic(false);
			}
			
			awaitingInteract = null;
		}
		
		public function MoveToAndInteract(interactTile:Tile, newTile:Tile, path:Vector.<Tile>):void
		{
			awaitingInteract = interactTile;
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
			var anim:MovieClip = new MovieClip(Assets.getTexturesFromAtlas(AttackAnimation), 4);
			anim.pivotX = anim.x = (anim.height) / 2;
			anim.pivotY = anim.y = (anim.width) / 2;
			LookTowards(u._tile, anim);
			Victim = u;
			PlayAnimation(anim, AttackComplete);
		}
		
		public function AttackComplete():void
		{	
			if( Victim != null)
			{
				Victim.TakeDamage(1);
				Victim =  null;
				MarkDone();
			}
		}
		
		public function MarkDone():void
		{
			bHasMoved = true;
			disable();
		}
		
		public function HasAction():Boolean
		{
			return !bHasMoved;
		}
		
		public function IsPlayerControlled():Boolean
		{
			return bPlayerControlled;
		}

	}
	
}
