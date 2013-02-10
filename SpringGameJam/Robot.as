package SpringGameJam {
	
	import SpringGameJam.Actor;
	
	public class Robot extends Actor {

		public function Robot() {
			super();
			
			movementSpeed = 2;
			IdleAnimation = "RobotIdle";
			movementAnimation = "";
		}
		
		override public function Interact(interact:Tile):void
		{
			
		}
		
		override public function CanInteract(interact:Tile):Boolean
		{
			return false;
		}

	}
	
}
