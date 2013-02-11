package SpringGameJam {
	
	public class Mechanic extends Medic {

		public function Mechanic() {
			
			movementSpeed = 4;
			bPlayerControlled = true;
			IdleAnimation = "MechanicIdle";
			AttackAnimation = "MechanicAttack";
			WalkAnimation = "MechanicWalk";
		}
		
		override public function Interact(unit:Unit):void
		{
			if (unit == null)
			{
				trace("Error: Interacting with a null unit");
				return;
			}
			
			if (unit is Fire)
			{
				Attack(unit);
			}
			else {
				Heal(unit);
			}
		}
		
		override public function CanInteract(unit:Unit):Boolean
		{
			if (unit is Fire)
			{
				return true;
			}
			
			return (unit is SystemUnit || unit is Robot) && unit.currentHealth < 5;
		}

	}
	
}
