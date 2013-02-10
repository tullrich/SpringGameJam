package SpringGameJam {
	
	public class Fireman extends Actor
	{

		public function Fireman() 
		{
			maxHealth = 50;
			currentHealth = 50;
			movementSpeed = 3;
			damage = 10;
			bHasMoved = false;
			bHasAttacked = false;
		}

	}
	
}
