package SpringGameJam {
	
	public class Fire extends Actor {

		public function Fire() 
		{
			super();
			
			movementSpeed = 2;
			IdleAnimation = "Fire";
			AttackAnimation = "Fire";
		}
		
		public function TryToSpread()
		{
			trace("trying to spread");
			
			var chance:int;
			
			for each(var a:Tile in Game.GetInstance()._level.GetAdjacentTiles(_tile))
			{
				if(!a.IsOpen() && a.bIsActive && !(a.resident is Fire))
				{
					Attack(a.resident);
					if(a.resident.currentHealth <= 0)
					{
						Game.GetInstance().RemoveUnit(Actor(a.resident));
					}
				}
			}
			
			for each(var t:Tile in Game.GetInstance()._level.GetFreeAdjacent(_tile))
			{
				chance = Math.floor(Math.random() * 2);
				if(chance)
				{
					Game.GetInstance().CreateUnitAt(Fire, t.xindex, t.yindex);
					trace("spreading");
				}
			}
		}

	}
	
}
