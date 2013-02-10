package SpringGameJam {
	
	public class Fire extends Actor {

		public function Fire() {
			super();
			
			maxHealth = 10;
			currentHealth = 10;
			movementSpeed = 2;
			damage = 10;
			IdleAnimation = "Fire";
			movementAnimation = "Fire";
			bIsInteractable = true;
		}

	}
	
}
