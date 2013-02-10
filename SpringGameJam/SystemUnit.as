package SpringGameJam 
{
	
	public class SystemUnit extends Unit
	{
		var bIsSpecial:Boolean;
		var AttackAnimation:String;
		var WalkAnimation:String;

		public function SystemUnit() 
		{
			super();
			IdleAnimation = "FiremanIdle";
			AttackAnimation = "FiremanAttack";
			WalkAnimation = "MedicWalk";
			//_hp.color = 0xFFFF00;
		}
		
		public function IsSpecial():Boolean
		{
			return bIsSpecial;
		}
		
		public function SetSpecial(b:Boolean)
		{
			bIsSpecial = b;
		}

	}
	
}
