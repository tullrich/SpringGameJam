package SpringGameJam {
	
	public class Fire extends Actor {

		public function Fire() 
		{
			super();
			currentHealth = 1;
			movementSpeed = 2;
			IdleAnimation = "Fire";
			AttackAnimation = null;
		}
		
		public function TryToSpread()
		{
			
			var chance:int;
			
			// damage surroundings
			for each(var a:Tile in Game.GetInstance()._level.GetAdjacentTiles(_tile))
			{
				if(!a.IsOpen() && a.bIsActive && !(a.resident is Fire))
				{
					if(a.resident is Fireman)
						continue;
					a.resident.TakeDamage(power);
				}
			}
			
			// spawn more fire
			for each(var t:Tile in Game.GetInstance()._level.GetFreeAdjacent(_tile))
			{
				chance = Math.floor(Math.random() * 2);
				if(chance)
				{
					Game.GetInstance().CreateUnitAt(Fire, t.xindex, t.yindex);
				}
			}
		}

	}
	
}
