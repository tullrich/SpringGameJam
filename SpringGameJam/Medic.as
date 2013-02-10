package SpringGameJam {
	
	public class Medic extends Actor {

		public function Medic() {
			
			movementSpeed = 5;
			bPlayerControlled = true;
			IdleAnimation = "MedicIdle";
			AttackAnimation = "FiremanAttack";
			WalkAnimation = "MedicWalk";
		}

	}
	
}
