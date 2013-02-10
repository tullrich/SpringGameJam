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
		public var resident:Unit;
		public var bIsActive:Boolean;
		public var currentMap:Grid;

		
		public var xindex:uint, yindex:uint;
		
		public function Tile(x:int, y:int)
		{
			super();
			
			xindex = x;
			yindex = y;
			bIsActive = true;
			currentMap = Game.GetInstance()._level;
			
			addEventListener(Event.ADDED_TO_STAGE, init);
        	addEventListener(TouchEvent.TOUCH, OnClick);
		}
		
		public function init(e:Event):void
		{
			
			var _mc:Image = new Image(Assets.getTexture("TileBorder"));
			_mc.scaleX = 0.375;
			_mc.scaleY = 0.375;
			addChildAt(_mc, 0);
		}
		
		public function OnClick(e:TouchEvent) {
			var touch:Touch = e.getTouch(this);  
            if (touch && touch.phase == TouchPhase.ENDED) {  
				//var _mc:Image = new Image(Assets.getTexture("TileInner"));
				//addChildAt(_mc, 0);
				
				if(currentMap.HandleClick(this))
				{
					return;
				}
				
				
				if(resident != null && resident is Actor)
				{
					//Game.GetInstance().ToggleCinematic(true);
					//resident.MoveTo(Game.GetInstance()._level.Map[2][1]);
					Game.GetInstance()._level._targeter.ShowOverlay(Actor(resident));
				}
            }
		}
		
		public function HasRoom():Boolean
		{
			return resident == null;
		}
		
		public function SetResident(u:Unit)
		{
			resident = u;
			resident.tile = this;
		}
		
		public function RemoveResident()
		{
			if(resident != null)
			{
				resident.tile = null;
				resident = null;
			}
		}
	
		public function SetActive(b:Boolean)
		{
			bIsActive = b;
		}
		
		public function IsOpen():Boolean
		{
			return bIsActive && HasRoom();
		}
		
		public function toString() : String
        {
            return "(" + xindex + ", " + yindex + ")";
        }

	}
	
}
