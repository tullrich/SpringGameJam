package SpringGameJam {
	
	public class Fire extends Actor {

		public function Fire() {
			super();
			
			movementSpeed = 2;
			IdleAnimation = "Fire";
			movementAnimation = "Fire";
			bIsInteractable = true;
		}

	}
	
}
