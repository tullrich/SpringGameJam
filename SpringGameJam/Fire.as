package SpringGameJam {
	
	public class Fire extends Actor {

		public function Fire() 
		{
			super();
			
			movementSpeed = 2;
			IdleAnimation = "Fire";
		}
		
		public function TryToSpread()
		{
			var chance:int = Math.floor(Math.random() * 2);
			
			if (chance)
			{
				for each(var t:Tile in Game.GetInstance()._level.GetFreeAdjacent(_tile))
				{
					 Game.GetInstance().CreateUnitAt(Fire, t.xindex, t.yindex);
				}
			}
		}

	}
	
}
