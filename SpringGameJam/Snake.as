package SpringGameJam {
	
	public class Snake extends Actor {

		public function Snake() {
			movementSpeed = 5;
			bPlayerControlled = false;
			IdleAnimation = "MedicIdle";
			AttackAnimation = "FiremanAttack";
			WalkAnimation = "MechanicWalk";
		}

	}
	
}
