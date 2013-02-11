package SpringGameJam {
	
	public class Fireman extends Actor
	{

		public function Fireman() 
		{
			movementSpeed = 3;
			bPlayerControlled = true;
			IdleAnimation = "FiremanIdle";
			AttackAnimation = "FiremanAttack";
			WalkAnimation = "FiremanWalk";
		}
		
		override public function Interact(unit:Unit):void
		{
			if (unit == null)
			{
				trace("Error: Interacting with a null unit");
				return;
			}
			
			if(unit is Fire)
			{
				power = 2;
				Attack(unit);
			}
			else
			{
				power = 1;
				Attack(unit);
			}
		}
		
		override public function CanInteract(unit:Unit):Boolean
		{
			return unit is Fire || unit is Snake;
		}

	}
	
}
