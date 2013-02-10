package SpringGameJam {
	
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
		
		public function TakeTurn()
		{
			trace("enemy turn");
			tempEnemies = units.slice();
			
			for each(var u:Actor in tempEnemies)
			{
				if(u is Fire && !u.bHasAttacked)
				{
					Fire(u).TryToSpread();
				}
			}
			
			Game.GetInstance().EndEnemyTurn();
		}

	}
	
}
