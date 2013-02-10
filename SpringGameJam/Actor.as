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
		var awaitingInteract:Tile;
		
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
				Interact(awaitingInteract);
			}
			else
			{
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
		
		public function Interact(interact:Tile):void
		{
			
		}
		
		public function CanInteract(interact:Tile):Boolean
		{
			return false;
		}

	}
	
}
