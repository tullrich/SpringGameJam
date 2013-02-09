package SpringGameJam {
	
	import starling.display.Sprite;
	import flash.events.MouseEvent;
	import SpringGameJam.*;

	
	public class Tile extends Sprite {
		
		public var terrain:Terrain;

		public function Tile(x:int, y:int) {
/*			graphics.beginFill(Math.floor(Math.random() * 0xFFFFFF));
			graphics.drawRect(0, 0, 64, 64); 
			graphics.endFill();*/
			this.x = x;
			this.y = y;
        	this.addEventListener(MouseEvent.CLICK, OnClick);
			terrain = new Terrain();
			addChild(terrain);
		}
		
		public function OnClick(e:MouseEvent) {
			trace("clicked on " + this);
		}

	}
	
}
