package SpringGameJam {
	
	public class MaceWindu extends Robot {

		public function MaceWindu() 
		{
			super();
			
			movementSpeed = 5;
			bPlayerControlled = true;
			AttackAnimation = "SamAttack";
			IdleAnimation = "SamIdle";
			WalkAnimation = "SamWalk";
		}
		
	}
	
}
