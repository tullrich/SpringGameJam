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
			_hp = new TextField(64,64,"","Verdana",40,0xFFFFFF,true);
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

	}
	
}
