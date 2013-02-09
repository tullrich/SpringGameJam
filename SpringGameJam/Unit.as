package SpringGameJam {
	
	import starling.display.Sprite;
	
	public class Unit extends Sprite 
	{
		var moveDistance:int;
		
		public function Unit() 
		{
			// constructor code
		}
		
		public function SetMove(m:int)
		{
			moveDistance = m;
		}
		
		public function int GetMove()
		{
			return moveDistance;
		}

	}
	
}
