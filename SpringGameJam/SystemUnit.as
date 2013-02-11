package SpringGameJam 
{
	import starling.events.Event;
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.utils.VAlign;
	import starling.utils.HAlign;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	public class SystemUnit extends Unit
	{
		var bIsSpecial:Boolean;

		public function SystemUnit() 
		{
			super();
			IdleAnimation = "NormalConsole";
		}
		
		override public function init(e:Event):void
		{	
			var temp:Vector.<Texture> = new Vector.<Texture>();
			temp.push(Assets.getTexture(IdleAnimation));
			// character model 
			_model = new MovieClip(temp, 6);
			
			_model.pivotX = _model.x = (_model.height) / 2;
			_model.pivotY = _model.y = (_model.width) / 2;
			addChild(_model);
			Starling.juggler.add(_model);

			// health text
			_hp = new TextField(64,64,"","Verdana",40,0xE9D400,true);
			_hp.x = -10;
			_hp.y = -10;
			_hp.vAlign = VAlign.TOP;
			_hp.hAlign = HAlign.LEFT;
			_hp.text = "" + currentHealth;
			addChild(_hp);
		}
		
		public function IsSpecial():Boolean
		{
			return bIsSpecial;
		}
		
		public function SetSpecial(b:Boolean)
		{
			bIsSpecial = b;
		}
		
		override public function TakeDamage(d:int)
		{
			super.TakeDamage(d);
			
			if (currentHealth == 0 && _animClip == null)
			{
				// we are not in the 0 health animation
				_hp.visible = false;
				var anim:MovieClip = new MovieClip(Assets.getTexturesFromAtlas("ConsoleBroken"), 4);
				anim.pivotX = anim.x = (anim.height) / 2;
				anim.pivotY = anim.y = (anim.width) / 2;
				PlayAnimation(anim, null, true);
			}
		}
		
		override public function GainHealth(h:int)
		{
			super.GainHealth(h);
			
			if(currentHealth > 0 && _animClip != null)
			{
				_hp.visible = true;
				_animClip.dispatchEventWith("AnimationReturn");
			}
		}

	}
	
}
