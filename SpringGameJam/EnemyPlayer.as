﻿package SpringGameJam {
	
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
			}
		}
		
		private function DelayedClick(t:Tile)
		{
			Game.GetInstance()._level._targeter.HandleClick(t);
		}

	}
	
}
