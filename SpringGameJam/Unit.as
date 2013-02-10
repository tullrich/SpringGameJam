﻿package SpringGameJam {
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.animation.Tween;
	import starling.animation.Transitions;;
	import starling.utils.VAlign;
	import starling.utils.HAlign;
	import starling.text.TextField;
	
	public class Unit extends Sprite 
	{
		var _tile:Tile;
		var tweenPath:Vector.<Tile>;
		var _model:MovieClip;
		var bIsInteractable:Boolean;
		var currentHealth:int;
		var _hp:TextField;
		
		var AttackAnimation:String;
		var IdleAnimation:String;
		
		public function Unit() 
		{
			this.touchable = false;
			addEventListener(Event.ADDED_TO_STAGE, init);
			scaleX = 0.375;
			scaleY = 0.375;
			currentHealth = 5;
		}
		
		public function init(e:Event):void
		{		
			// character model 
			_model = new MovieClip(Assets.getTexturesFromAtlas(IdleAnimation), 4);
			_model.pivotX = _model.x = (_model.height) / 2;
			_model.pivotY = _model.y = (_model.width) / 2;
			_model.rotation = Math.PI + Math.PI / 2;
			addChild(_model);
			Starling.juggler.add(_model);

			// health text
			_hp = new TextField(64,64,"","Verdana",40,0xFFFFFF,true);
			_hp.x = -10;
			_hp.y = -10;
			_hp.vAlign = VAlign.TOP;
			_hp.hAlign = HAlign.LEFT;
			_hp.text = "" + currentHealth;
			addChild(_hp);
		}
		
		public function PlayAnimation(anim:MovieClip):void
		{
			Game.GetInstance().ToggleCinematic(true);
			_model.visible = false;
			_model.stop();
			
			anim.loop = false;
			anim.addEventListener(Event.COMPLETE, AnimCompleted);
			addChild(anim);
			Starling.juggler.add(anim);
		}
		
		public function AnimCompleted(e:Event):void
		{
			MovieClip(e.target).removeEventListeners();
			MovieClip(e.target).removeFromParent(true);
			MovieClip(e.target).dispose();
			trace("testtttt");
			
			_model.play();
			_model.visible = true;
			Game.GetInstance().ToggleCinematic(false);
		}
		
		public function LookTowards(tile:Tile, clip:MovieClip = null):void
		{
			if (clip == null)
			{
				clip = _model;
			}
			
			if (x < tile.x)
			{
				// moving right
				clip.rotation = Math.PI / 2;
			}
			else if (x > tile.x)
			{
				// moving left
				clip.rotation = Math.PI + Math.PI / 2;
			}
			else if (y < tile.y)
			{
				// moving down
				clip.rotation = Math.PI;
			}
			else if (y > tile.y)
			{
				// moving up
				clip.rotation = 0;
			}
		}
		
		public function Place(newTile:Tile):void
		{
			if(newTile.resident != null)
			{
				trace("Error: tried to place in occupied tile!");
				return;
			}
			
			if (_tile != null)
			{
				_tile.RemoveResident();
			}
			
			newTile.SetResident(this);
			x = _tile.x;
			y = _tile.y;
		}
												
		
		public function get tile():Tile
		{
			return _tile;
		}
		
		public function set tile(newTile:Tile):void
		{
			_tile = newTile;
		}
		
		public function TakeDamage(d:int)
		{
			currentHealth -= d;
			if(currentHealth >= 0)
			{
				_hp.text = "" + currentHealth;
			}
			else
			{
				
			}
		}
		
		public function Attack(u:Unit):void
		{
			var anim:MovieClip = new MovieClip(Assets.getTexturesFromAtlas(AttackAnimation), 4);
			anim.pivotX = anim.x = (anim.height) / 2;
			anim.pivotY = anim.y = (anim.width) / 2;
			LookTowards(u._tile, anim);
			PlayAnimation(anim);
			u.TakeDamage(1);
		}

	}
	
}
