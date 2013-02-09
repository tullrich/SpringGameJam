package SpringGameJam {
	
	import starling.display.Sprite;
	import SpringGameJam.Unit;
	
	public class ActionOverlay extends Sprite {
	
		var target:Unit;

		public function ActionOverlay() {
		}
		
	
		public function HideOverlay():void
		{
			
		}
		
		
		public function ShowOverlay(target:Unit):void
		{
			this.target = target;
		}

	}
	
}
