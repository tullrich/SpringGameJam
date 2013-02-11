﻿package SpringGameJam 
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
		
		public function Actor() 
		{
			super();
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
			Victim = u;
			PlayAnimation(anim, AttackComplete);
			LookTowards(u._tile);
		}
		
		public function AttackComplete():void
		{	
			var bIsSafe:Boolean;
			var tempSystems:Vector.<SystemUnit> = Game.GetInstance().systemUnits;
			var TheGame = Game.GetInstance();
			
			if( Victim != null)
			{
				Victim.TakeDamage(1);
				if(Victim is SystemUnit)
				{
					bIsSafe = true;
					for each (var unit:SystemUnit in tempSystems)
					{
						if(unit.currentHealth <= 0)
						{							
							TheGame._AltitudeImage.alpha = 0;
							bIsSafe = false;
							break;
						}
					}
					if(bIsSafe)
					{
							TheGame._AltitudeImage.alpha = 100;
					}
				}
				Victim =  null;
				EndTurn();
			}
			
			Game.GetInstance().ToggleCinematic(false);
		}
		
		public function EndTurn():void
		{
			bHasMoved = true;
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

	}
	
}
