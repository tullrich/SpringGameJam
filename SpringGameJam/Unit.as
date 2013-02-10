package SpringGameJam {
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.animation.Tween;
	import starling.animation.Transitions;
	
	public class Unit extends Sprite 
	{
		var moveDistance:int;
		var _tile:Tile;
		
		public function Unit() 
		{
			moveDistance = 2;
			this.touchable = false;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(e:Event):void
		{		
			var _mc:MovieClip = new MovieClip(Assets.getTexturesFromAtlas("RobotIdle"), 4);		 
			addChild(_mc);
			Starling.juggler.add(_mc);
		}
		
		public function SetMove(m:int)
		{
			moveDistance = m;
		}
		
		public function GetMove():int
		{
			return moveDistance;
		}
		
		public function MoveTo(newTile:Tile):void
		{
			trace("moveto");
			
			 var tween:Tween = new Tween(this, 2.0, Transitions.EASE_IN_OUT);
			  tween.animate("x", newTile.x);
			  tween.animate("y", newTile.y);
			  Starling.juggler.add(tween);
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

	}
	
}
