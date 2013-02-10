package SpringGameJam 
{
	
	public class SystemUnit extends Unit
	{
		var bIsSpecial:Boolean;

		public function SystemUnit() 
		{
			super();
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
