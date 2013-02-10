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
		var tweenPath:Vector.<Tile>;
		var model:MovieClip;
		var bIsInteractable:Boolean;
		
		var IdleAnimation:String;
		
		public function Unit() 
		{
			moveDistance = 7;
			this.touchable = false;
			addEventListener(Event.ADDED_TO_STAGE, init);
			//this.pivotX = 32;
			//this.pivotY = 32;
		}
		
		public function init(e:Event):void
		{		
			model = new MovieClip(Assets.getTexturesFromAtlas(IdleAnimation), 4);
			scaleX = 0.375;
			scaleY = 0.375;
			model.pivotX = model.x = (model.height) / 2;
			model.pivotY = model.y = (model.width) / 2;
			model.rotation = Math.PI + Math.PI / 2;
			addChild(model);
			Starling.juggler.add(model);
		}
		
		public function SetMove(m:int)
		{
			moveDistance = m;
		}
		
		public function GetMove():int
		{
			return moveDistance;
		}
		
		public function LookTowards(tile:Tile):void
		{
			if (x < tile.x)
			{
				// moving right
				model.rotation = Math.PI / 2;
			}
			else if (x > tile.x)
			{
				// moving left
				model.rotation = Math.PI + Math.PI / 2;
			}
			else if (y < tile.y)
			{
				// moving down
				model.rotation = Math.PI;
			}
			else if (y > tile.y)
			{
				// moving up
				model.rotation = 0;
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

	}
	
}
