package SpringGameJam {
	
	public class MaceWindu extends Actor {

		public function MaceWindu() 
		{
			super();
			
			power = 2;
			movementSpeed = 5;
			bPlayerControlled = true;
			AttackAnimation = "SamAttack";
			IdleAnimation = "SamIdle";
			WalkAnimation = "SamWalk";
		}
		
		override public function Interact(unit:Unit):void
		{
			if (unit == null)
			{
				trace("Error: Interacting with a null unit");
				return;
			}
			
			if(unit is Snake)
			{
				Attack(unit);
			}
			
		}
		
		override public function CanInteract(unit:Unit):Boolean
		{
			return unit is Snake;
		}
	}
	
}
