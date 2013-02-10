package SpringGameJam {
	
	import starling.display.Sprite;
	import SpringGameJam.Unit;
    import flash.utils.Dictionary;
	import starling.display.Image;
	
	public class ActionOverlay extends Sprite {
	
		var target:Actor;
		var originTile:Tile;
		
		var came_from:Dictionary = new Dictionary();
		var reachable:Vector.<Tile> = new Vector.<Tile>();
		var interactable:Vector.<Tile> = new Vector.<Tile>();
		var currentLevel:Grid;

		public function ActionOverlay() 
		{
			visible = false;
			currentLevel = Game.GetInstance()._level
		}
		
	
		public function HideOverlay():void
		{
			visible = false;
			while (numChildren > 0) {
				this.removeChildAt(0);
			}
		}
		
		
		public function ShowOverlay(target:Actor):void
		{
			this.target = target;
			this.originTile = target._tile;
			came_from =  new  Dictionary();
			interactable = new Vector.<Tile>();
			ComputePaths();
			CreateOverlayTiles();
			visible = true;
		}
		
		private function CreateOverlayTiles()
		{
			for each (var akey:Tile in reachable)
			{
				var _mc:Image = new Image(Assets.getTexture("OverlayMove"));
				_mc.touchable = false;
				_mc.scaleX = 0.375;
				_mc.scaleY = 0.375;
				_mc.x = akey.x;
				_mc.y = akey.y;
				addChildAt(_mc, 0);
			}
			
			for each (var bkey:Tile in interactable)
			{
				var _mc2:Image = new Image(Assets.getTexture("OverlayInteract"));
				_mc2.touchable = false;
				_mc2.scaleX = 0.375;
				_mc2.scaleY = 0.375;
				_mc2.x = bkey.x;
				_mc2.y = bkey.y;
				addChildAt(_mc2, 0);
			}
			
				 
		}
		
		private function ComputePaths():void
		{
			var currentTile:Tile;
			var unitMove = target.movementSpeed;
			var depth:int = 0;
			var closedSet:Vector.<Tile> = new Vector.<Tile>();
			var openSet:Vector.<Tile> = new Vector.<Tile>();
			openSet.push(target.tile);
			var neighboringTiles:Vector.<Tile> = new Vector.<Tile>();

			while(openSet.length > 0)
			{
				if(unitMove < depth)
				{
					break;
				}
				
				var tempOpen:Vector.<Tile> = new Vector.<Tile>()
				for each (var curTile:Tile in openSet)
				{
					if(curTile != originTile)
					{
						closedSet.push(curTile);
					}
					
					neighboringTiles = currentLevel.GetAdjacentTiles(curTile);
					
					for each (var neighbor:Tile in neighboringTiles)
					{
						if(openSet.indexOf(neighbor,0) == -1)
						{
							if(closedSet.indexOf(neighbor,0) == -1)
							{
								if(neighbor.IsOpen())
								{
									if(tempOpen.indexOf(neighbor,0) == -1)
									{
										tempOpen.push(neighbor);
										came_from[neighbor] = curTile;
									}
								}
								else if (target.CanInteract(neighbor.resident))
								{
									if(interactable.indexOf(neighbor,0) == -1)
									{
										interactable.push(neighbor);
										came_from[neighbor] = curTile;
									}
								}
							}
						}
					}
				
				}
				
				openSet = tempOpen;
				depth++;
			}
			
			reachable = closedSet;
		}
		
		public function ReturnPath(CameFrom:Tile, CurrentTile:Tile)
		{
			
		}
		
		public function IsVisible():Boolean
		{
			return visible;
		}
		
		public function BuildPath(dest:Tile):Vector.<Tile>
		{
			var path:Vector.<Tile> = new Vector.<Tile>();
			path.push(dest);
			
			var cur:Tile = dest;
			while (cur != originTile)
			{
				cur = came_from[cur];
				path.unshift(cur);
				
			}
			
			return path;
		}
		
		public function HandleClick(clicked:Tile):void
		{
			if(!IsVisible())
			{
				return;
			}
			
			if (reachable.indexOf(clicked) != -1)
			{
				target.MoveTo(clicked, BuildPath(clicked));
			}
			else if(interactable.indexOf(clicked) != -1)
			{
				target.MoveToAndInteract(clicked, came_from[clicked], BuildPath(came_from[clicked]));
			}
			
			HideOverlay();
		}

	}
	
}
