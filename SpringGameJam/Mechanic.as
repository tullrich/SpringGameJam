package SpringGameJam {
	
	public class Mechanic extends Actor {

		public function Mechanic() {
			
			movementSpeed = 4;
			bPlayerControlled = true;
			IdleAnimation = "MechanicIdle";
			AttackAnimation = "FiremanAttack";
			WalkAnimation = "MedicWalk";
		}

	}
	
}
