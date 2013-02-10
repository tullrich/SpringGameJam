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
			moveDistance = 7;
			this.touchable = false;
			addEventListener(Event.ADDED_TO_STAGE, init);
			//this.pivotX = 32;
			//this.pivotY = 32;
		}
		
		public function init(e:Event):void
		{		
			var _mc:MovieClip = new MovieClip(Assets.getTexturesFromAtlas("RobotIdle"), 4);
			_mc.pivotX = _mc.x = _mc.height / 2;
			_mc.pivotY = _mc.y = _mc.width / 2;
			_mc.rotation = Math.PI + Math.PI / 2;
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
		
		public function SetDirection():void
		{
			this.rotation = 90;
		}
		
		public function MoveTo(newTile:Tile, path:Vector.<Tile>):void
		{
			trace("moveto");
			
			if(!visible)
			{
				Place(newTile);
				return;
			}
			
			Game.GetInstance().ToggleCinematic(true);
			
			var tween:Tween, prevTween:Tween;
			var i:int = 0;
			for each(var nextTile:Tile in path)
			{
				trace(i + ". " + nextTile);
				i++;
				
				tween = new Tween(this, .5, Transitions.LINEAR);
			 	tween.animate("x", nextTile.x);
			  	tween.animate("y", nextTile.y);
				
				if(prevTween == null)
				{
					// first tween
					Starling.juggler.add(tween);
				}
				else
				{
					// every other tween
					prevTween.nextTween = tween;
				}
				
				prevTween = tween;
			}
			
			tween.onComplete = MoveCompleted;
			  
			if (_tile != null)
			{
				_tile.RemoveResident();
			}
			
			newTile.SetResident(this);
		}
		
		public function MoveCompleted():void
		{
			Game.GetInstance().ToggleCinematic(false);
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
