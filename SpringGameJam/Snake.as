package SpringGameJam {
	
	public class Snake extends Actor {

		public function Snake() {
			movementSpeed = 5;
			bPlayerControlled = false;
			IdleAnimation = "SnakeIdle";
			AttackAnimation = "SnakeAttack";
			WalkAnimation = "SnakeIdle";
		}
		
		override public function Interact(unit:Unit):void
		{
			if (unit == null)
			{
				trace("Error: Interacting with a null unit");
				return;
			}
			
			if(unit is Actor || unit is SystemUnit)
			{
				Attack(unit);
			}
		}
		
		override public function CanInteract(unit:Unit):Boolean
		{
			if( unit is Actor && Actor(unit).bPlayerControlled)
			{
				return true;
			}
			else if (unit is SystemUnit && unit.currentHealth > 0)
			{
				return true;
			}
			return false;
		}
	}
	
}
