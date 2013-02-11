package SpringGameJam {
	
	import starling.display.MovieClip;
	
	public class Medic extends Actor {

		public function Medic() {
			
			movementSpeed = 5;
			healpower = 1;
			bPlayerControlled = true;
			IdleAnimation = "MedicIdle";
			AttackAnimation = "MedicAttack";
			WalkAnimation = "MedicWalk";
		}
		
		
		override public function Interact(unit:Unit):void
		{
			if (unit == null)
			{
				trace("Error: Interacting with a null unit");
				return;
			}
			
			Heal(unit);
		}
		
		override public function CanInteract(unit:Unit):Boolean
		{
			if (unit == this)
			{
				return false;
			}
			return unit is Actor && Actor(unit).bPlayerControlled && unit.currentHealth < unit.maxHealth;
		}

	}
	
}
