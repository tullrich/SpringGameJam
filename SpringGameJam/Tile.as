package SpringGameJam {
	
	import starling.display.Sprite;
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import SpringGameJam.*;

	
	public class Tile extends Sprite 
	{
		
		public var terrain:Terrain;
		public var bIsActive:Boolean

		public function Tile(x:int, y:int)
		{
			super();
			
			this.x = x;
			this.y = y;
			
			addEventListener(Event.ADDED_TO_STAGE, init);
        	addEventListener(TouchEvent.TOUCH, OnClick);
		}
		
		public function init(e:Event):void
		{
			
			var _mc:Image = new Image(Assets.getTexture("TileBorder"));
			addChildAt(_mc, 0);
		}
		
		public function OnClick(e:TouchEvent) {
			var touch:Touch = e.getTouch(this);  
            if (touch && touch.phase == TouchPhase.ENDED) {  
				var _mc:Image = new Image(Assets.getTexture("TileInner"));
				addChildAt(_mc, 0);
				
				if(residentUnit != undefined)
				{
					Game.GetActionOverlay().Show(residentUnit);
				}
            }
		}
		
		public function SetActive(b:Boolean)
		{
			bIsActive = b;
		}
		
		public function Boolean GetActive()
		{
			return bIsActive;
		}
	

	}
	
}
