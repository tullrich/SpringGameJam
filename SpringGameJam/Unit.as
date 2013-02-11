package SpringGameJam {
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.animation.Tween;
	import starling.animation.Transitions;;
	import starling.utils.VAlign;
	import starling.utils.HAlign;
	import starling.text.TextField;
	import starling.filters.ColorMatrixFilter;
	
	public class Unit extends Sprite 
	{
		var _tile:Tile;
		var tweenPath:Vector.<Tile>;
		var _model:MovieClip;
		var _animClip:MovieClip;
		var currentHealth:int;
		var _hp:TextField;
		var AnimCallback:Function;
		
		var IdleAnimation:String;
		
		static var GrayScaleFilter:ColorMatrixFilter = new ColorMatrixFilter();
		GrayScaleFilter.adjustSaturation(-1);
		
		public function Unit() 
		{
			this.touchable = false;
			addEventListener(Event.ADDED_TO_STAGE, init);
			scaleX = 0.75;
			scaleY = 0.75;
			currentHealth = 5;
		}
		
		public function init(e:Event):void
		{		
			// character model 
			_model = new MovieClip(Assets.getTexturesFromAtlas(IdleAnimation), 6);
			
			_model.pivotX = _model.x = (_model.height) / 2;
			_model.pivotY = _model.y = (_model.width) / 2;
			_model.rotation = Math.PI + Math.PI / 2;
			addChild(_model);
			Starling.juggler.add(_model);

			// health text
			_hp = new TextField(64,64,"","Verdana",40,0xB4B4B4,true);
			_hp.x = -10;
			_hp.y = -10;
			_hp.vAlign = VAlign.TOP;
			_hp.hAlign = HAlign.LEFT;
			_hp.text = "" + currentHealth;
			addChild(_hp);
		}
		
		public function PlayAnimation(anim:MovieClip, callBack:Function = null, customStop:Boolean = false):void
		{
			AnimCallback = callBack;
			
			//Game.GetInstance().ToggleCinematic(true);
			_model.visible = false;
			_model.stop();
			
			_animClip = anim;
			_animClip.loop = customStop;
			if (customStop)
			{
				_animClip.addEventListener("AnimationReturn", AnimCompleted);
			}
			else
			{
				_animClip.addEventListener(Event.COMPLETE, AnimCompleted);
			}
			
			addChild(_animClip);
			Starling.juggler.add(_animClip);
		}
		
		public function AnimCompleted(e:Event):void
		{
			_animClip.removeEventListeners();
			_animClip.removeFromParent(true);
			_animClip.dispose();
			_animClip = null;
			
			_model.play();
			_model.visible = true;
			//Game.GetInstance().ToggleCinematic(false);
			
			if (AnimCallback != null)
			{
				//  clear the callback before in case AnimCallback calls PlayAnimation again
				var temp:Function = AnimCallback;
				AnimCallback = null;
				temp();
			}
		}
		
		public function LookTowards(tile:Tile, clip:MovieClip = null):void
		{
			
			if (x < tile.x)
			{
				// moving right
				_model.rotation = Math.PI / 2;
			}
			else if (x > tile.x)
			{
				// moving left
				_model.rotation = Math.PI + Math.PI / 2;
			}
			else if (y < tile.y)
			{
				// moving down
				_model.rotation = Math.PI;
			}
			else if (y > tile.y)
			{
				// moving up
				_model.rotation = 0;
			}
			
			
			if(_animClip != null)
			{
				_animClip.rotation = _model.rotation;
			}
			if(clip != null)
			{
				clip.rotation = _model.rotation;
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
			if(currentHealth > 0)
			{
				if (currentHealth - d < 0)
				{
					currentHealth = 0;
				}
				else
				{
					currentHealth -= d;
				}
				_hp.text = "" + currentHealth;
			}
		}
		
		public function GainHealth(h:int)
		{
			if (currentHealth < 5)
			{
				if( currentHealth + h > 5)
				{
					currentHealth = 5;
				}
				else
				{
					currentHealth += h;
				}
				_hp.text = "" + currentHealth;
			}
		}
		
		public function disable():void
		{
			_model.filter = GrayScaleFilter;
		}
		
		
		public function enable():void
		{
			_model.filter = null;
		}
		

	}
	
}
