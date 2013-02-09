package  SpringGameJam {
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import starling.core.Starling;
	
	import SpringGameJam.*;
		
	public class SpringGameJam extends Sprite {
		
		
		private var myStarling:Starling;
		
		public function SpringGameJam() {
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			//Starling.handleLostContext = true;
			
			myStarling = new Starling(Game, stage);
			myStarling.start();
			
		}
		
	}
	
}
