package SpringGameJam {
	
	public class EnemyPlayer {
		
		var units:Vector.<Actor>;

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
			
			for each(var u:Actor in units)
			{
				if(u is Fire)
				{
					Fire(u).TryToSpread();
				}
			}
			
			Game.GetInstance().EndEnemyTurn();
		}

	}
	
}
