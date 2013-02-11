package SpringGameJam {
	
	import SpringGameJam.Actor;
	
	public class Robot extends Actor {

		public function Robot() {
			super();
			
			movementSpeed = 4;
			bPlayerControlled = true;
			AttackAnimation = "RobotAttack";
			IdleAnimation = "RobotIdle";
			WalkAnimation = "RobotWalk";
		}
		
		override public function Interact(unit:Unit):void
		{
			if (unit == null)
			{
				trace("Error: Interacting with a null unit");
				return;
			}
			
			if(unit is Snake || unit is Fire)
			{
				Attack(unit);
			}
			else if (unit is SystemUnit)
			{
				Heal(unit);
			}
			
		}
		
		override public function CanInteract(unit:Unit):Boolean
		{
			return unit is Snake || unit is Fire || (unit is SystemUnit && unit.currentHealth < unit.maxHealth);
		}

	}
	
}
