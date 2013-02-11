package SpringGameJam {
		
	import starling.filters.ColorMatrixFilter;
	import starling.filters.FragmentFilter;
	
	public class BossSnake extends Snake {

		public function BossSnake() {
			movementSpeed = 4;
			bPlayerControlled = false;
			power = 2;
			IdleAnimation = "SnakeIdle";
			AttackAnimation = "SnakeAttack";
			WalkAnimation = "SnakeIdle";
		}
		
		override protected function CreateDefaultFilter():FragmentFilter
		{
			var f:ColorMatrixFilter = new ColorMatrixFilter();
		  	f.adjustHue(1);
			return f;
		}

	}
	
}
