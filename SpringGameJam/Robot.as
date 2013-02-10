package SpringGameJam {
	
	import SpringGameJam.Actor;
	
	public class Robot extends Actor {

		public function Robot() {
			super();
			
			maxHealth = 10;
			currentHealth = 10;
			movementSpeed = 2;
			damage = 10;
			IdleAnimation = "RobotIdle";
			movementAnimation = "";
		}

	}
	
}
