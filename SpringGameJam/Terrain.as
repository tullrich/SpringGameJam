package SpringGameJam {
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.core.Starling;
	import starling.display.MovieClip;
	
	import SpringGameJam.*;
	
	public class Terrain extends Sprite {
		

		
		public function Terrain() 
		{
			super();	
			this.addEventListener(Event.ADDED_TO_STAGE, initialize);
		}
		protected function initialize(e:Event):void
		{
			var _mc:MovieClip = new MovieClip(Assets.getTexturesFromAtlas("TestAnim"), 1);		 
			addChild(_mc);
			Starling.juggler.add(_mc);
		}	
		
		

	}
	
}
