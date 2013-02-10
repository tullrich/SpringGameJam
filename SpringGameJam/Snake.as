package SpringGameJam {
	
	public class Snake extends Actor {

		public function Snake() {
			movementSpeed = 5;
			bPlayerControlled = false;
			IdleAnimation = "MedicIdle";
			AttackAnimation = "FiremanAttack";
			WalkAnimation = "MechanicWalk";
		}
		
		override public function Interact(unit:Unit):void
		{
			if (unit == null)
			{
				trace("Error: Interacting with a null unit");
				return;
			}
			
			if(unit is Actor)
			{
				Attack(unit);
			}
		}
		
		override public function CanInteract(unit:Unit):Boolean
		{
			return unit is Actor && Actor(unit).bPlayerControlled;
		}
	}
	
}
