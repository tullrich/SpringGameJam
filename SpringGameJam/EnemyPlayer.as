package SpringGameJam {
	
	import starling.core.Starling;
	
	public class EnemyPlayer {
		
		var units:Vector.<Actor>;
		var tempEnemies:Vector.<Actor>;

		public function EnemyPlayer() 
		{
			units = new Vector.<Actor>;
		}
		
		public function ControlUnit(u:Actor)
		{
			if (units.indexOf(u) == -1)
			{
				trace("I own " + u);
				units.push(u);
			}
		}
		
		public function RestartUnits()
		{
			for each(var u:Actor in units)
			{
				u.NewTurn();
			}
		}
		
		public function BeginTurn()
		{
			var goodLocation:Boolean = false;
			tempEnemies = units.slice();
			
			var chance:int = Math.floor(Math.random() * 4);
			if(chance == 0)
			{
				do
				{
					var randX:int = Math.floor(Math.random() * 21);
					var randY:int = Math.floor(Math.random() * 16);
					if(Game.GetInstance()._level.Map[randX][randY].IsOpen())
					{
						goodLocation = true;
					}
				}
				while(!goodLocation)
				
				Game.GetInstance().CreateUnitAt(Snake,randX,randY);
			}
			
			NextAction();
		}
		
		public function NextAction()
		{
			if (tempEnemies.length > 0)
			{
				var u:Actor = tempEnemies.pop();
				if(u is Fire && !u.bHasAttacked)
				{
					Fire(u).TryToSpread();
					NextAction();
				}
				else if( u is Actor)
				{
					Use(Actor(u));
				}
			}
			else
			{
				CompleteTurn();
			}
		}
		
		public function ActionComplete()
		{
			NextAction();
		}
		
		
		private function CompleteTurn()
		{
			var goodLocation:Boolean = false;
			var chance:int = Math.floor(Math.random() * 4);
			
			if(chance == 0)
			{
				do
				{
					var randX:int = Math.floor(Math.random() * 21);
					var randY:int = Math.floor(Math.random() * 16);
					if(Game.GetInstance()._level.Map[randX][randY].IsOpen())
					{
						goodLocation = true;
					}
				}
				while(!goodLocation)
				
				Game.GetInstance().CreateUnitAt(Fire,randX,randY);
			}
			Game.GetInstance().EndEnemyTurn();
		}
		
		private function Use(u:Actor):void
		{
			var _targeter:ActionOverlay = Game.GetInstance()._level._targeter;
			_targeter.ShowOverlay(u);
			
			var index:int;
			if (_targeter.interactable.length > 0)
			{
				index = Math.floor(Math.random() * _targeter.interactable.length);
				Starling.juggler.delayCall(DelayedClick, 1, _targeter.interactable[index]);
			}
			if (_targeter.reachable.length > 0)
			{
				index = Math.floor(Math.random() * _targeter.reachable.length);
				Starling.juggler.delayCall(DelayedClick, 1, _targeter.reachable[index]);
			}
			else
			{
				_targeter.HideOverlay();
				NextAction();
			}
		}
		
		private function DelayedClick(t:Tile)
		{
			Game.GetInstance()._level._targeter.HandleClick(t);
		}

	}
	
}
