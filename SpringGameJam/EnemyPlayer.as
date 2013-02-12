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
			tempEnemies = units.slice();
			
			MaybeSpawnSnake();
			
			NextAction();
		}
		
		// Spawns snake if there is no snakes, else 1/4 chance of spawning one
		public function MaybeSpawnSnake():void
		{
			var chance:int = Math.floor(Math.random() * 4);
			if(chance == 0 || !OwnsClass(Snake))
			{
				Game.GetInstance().SpawnRandom(Snake, 1, true);
			}
		}
		
		public function NextAction()
		{
			if (tempEnemies.length > 0)
			{
				var u:Actor = tempEnemies.pop();
				if(u is Fire)
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
				Game.GetInstance().SpawnRandom(Fire);
			}
			
			// spawn boss snake every 10th turn
			if(Game.GetInstance().turnNum % 10 == 0)
			{
				Game.GetInstance().SpawnRandom(BossSnake);
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
				trace("_targeter.interactable.length " + _targeter.interactable.length);
				index = Math.floor(Math.random() * _targeter.interactable.length);
				Starling.juggler.delayCall(DelayedClick, 1, _targeter.interactable[index]);
			}
			else if (_targeter.reachable.length > 0)
			{
				trace("_targeter.reachable.length " + _targeter.reachable.length);
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
		
		public function OwnsClass(c:Class):Boolean
		{
			for each(var u:Actor in units)
			{
				if (u is c)
				{
					return true;
				}
			}
			
			return false;
		}

	}
	
}
