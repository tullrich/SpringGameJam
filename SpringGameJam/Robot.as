package SpringGameJam {
	
	import SpringGameJam.Actor;
	
	public class Robot extends Actor {

		public function Robot() {
			super();
			
			movementSpeed = 2;
			bPlayerControlled = true;
			IdleAnimation = "RobotIdle";
			movementAnimation = "";
		}
		
		override public function Interact(unit:Unit):void
		{
			
		}
		
		override public function CanInteract(unit:Unit):Boolean
		{
			return false;
		}

	}
	
}
