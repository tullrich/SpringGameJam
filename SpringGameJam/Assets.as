package SpringGameJam {
	
	import starling.textures.TextureAtlas;
	import starling.textures.Texture;
	import flash.display.Bitmap;
    import flash.utils.Dictionary;
	
	public class Assets {
		
		[Embed(source="/assets/TestSpriteSheet.xml",mimeType="application/octet-stream")]
		private static const TestAnimXML:Class;
		
		[Embed(source="/assets/TestSpriteSheet.png")]
		private static const TestAnimAtlas:Class;
		
		[Embed(source="/assets/MedicWalk.xml",mimeType="application/octet-stream")]
		private static const MedicWalkXML:Class;
		
		[Embed(source="/assets/MedicWalk.png")]
		private static const MedicWalkAtlas:Class;
		
		[Embed(source="/assets/RobotIdle.xml",mimeType="application/octet-stream")]
		private static const RobotIdleXML:Class;
		
		[Embed(source="/assets/RobotIdle.png")]
		private static const RobotIdleAtlas:Class;
		
		[Embed(source="/assets/MedicIdle.xml",mimeType="application/octet-stream")]
		private static const MedicIdleXML:Class;
		
		[Embed(source="/assets/MedicIdle.png")]
		private static const MedicIdleAtlas:Class;
		
		[Embed(source="/assets/MechanicIdle.xml",mimeType="application/octet-stream")]
		private static const MechanicIdleXML:Class;
		
		[Embed(source="/assets/MechanicIdle.png")]
		private static const MechanicIdleAtlas:Class;
		
		[Embed(source="/assets/MechanicWalk.xml",mimeType="application/octet-stream")]
		private static const MechanicWalkXML:Class;
		
		[Embed(source="/assets/MechanicWalk.png")]
		private static const MechanicWalkAtlas:Class;
		
		[Embed(source="/assets/tile.png")]
		private static const TileBorder:Class;
		
		[Embed(source="/assets/tile_inner.png")]
		private static const TileInner:Class;
		
		[Embed(source="/assets/interceptor.png")]
		private static const Interceptor:Class;
		
		[Embed(source="/assets/overlay_move.png")]
		private static const OverlayMove:Class;
		
		[Embed(source="/assets/overlay_move.png")]
		private static const NextTurnButtonUp:Class;
		
		[Embed(source="/assets/overlay_interact.png")]
		private static const NextTurnButtonDown:Class;
		
		[Embed(source="/assets/overlay_interact.png")]
		private static const OverlayInteract:Class;
		
		[Embed(source="/assets/overlay_target.png")]
		private static const OverlayTarget:Class;
		
		[Embed(source="/assets/Airplane2.png")]
		private static const BgAirplane:Class;
		
		[Embed(source="/assets/WaterBg2.png")]
		private static const BgWater:Class;
		
		[Embed(source="/assets/Fire.xml",mimeType="application/octet-stream")]
		private static const FireXML:Class;
		
		[Embed(source="/assets/Fire.png")]
		private static const FireAtlas:Class;
		
		[Embed(source="/assets/CloudScroll.png")]
		private static const Clouds:Class;
		
		[Embed(source="/assets/FiremanIdle.xml",mimeType="application/octet-stream")]
		private static const FiremanIdleXML:Class;
		
		[Embed(source="/assets/FiremanIdle.png")]
		private static const FiremanIdleAtlas:Class;
		
		[Embed(source="/assets/FiremanAttack.xml",mimeType="application/octet-stream")]
		private static const FiremanAttackXML:Class;
		
		[Embed(source="/assets/FiremanAttack.png")]
		private static const FiremanAttackAtlas:Class;
		
		[Embed(source="/assets/SnakeIdle.xml",mimeType="application/octet-stream")]
		private static const SnakeIdleXML:Class;
		
		[Embed(source="/assets/SnakeIdle.png")]
		private static const SnakeIdleAtlas:Class;
		
		[Embed(source="/assets/SnakeAttack.xml",mimeType="application/octet-stream")]
		private static const SnakeAttackXML:Class;
		
		[Embed(source="/assets/SnakeAttack.png")]
		private static const SnakeAttackAtlas:Class;
		
		[Embed(source="/assets/RobotAttack.xml",mimeType="application/octet-stream")]
		private static const RobotAttackXML:Class;
		
		[Embed(source="/assets/RobotAttack.png")]
		private static const RobotAttackAtlas:Class;
		
		[Embed(source="/assets/RobotWalk.xml",mimeType="application/octet-stream")]
		private static const RobotWalkXML:Class;
		
		[Embed(source="/assets/RobotWalk.png")]
		private static const RobotWalkAtlas:Class;
		
		[Embed(source="/assets/NormalConsole.png")]
		private static const NormalConsole:Class;
		
		[Embed(source="/assets/ConsoleBroken.xml",mimeType="application/octet-stream")]
		private static const ConsoleBrokenXML:Class;
		
		[Embed(source="/assets/ConsoleBroken.png")]
		private static const ConsoleBrokenAtlas:Class;
		
		[Embed(source="/assets/MedicAttack.xml",mimeType="application/octet-stream")]
		private static const MedicAttackXML:Class;
		
		[Embed(source="/assets/MedicAttack.png")]
		private static const MedicAttackAtlas:Class;
		
		[Embed(source="/assets/SamIdle.xml",mimeType="application/octet-stream")]
		private static const SamIdleXML:Class;
		
		[Embed(source="/assets/SamIdle.png")]
		private static const SamIdleAtlas:Class;
		
		[Embed(source="/assets/SamAttack.xml",mimeType="application/octet-stream")]
		private static const SamAttackXML:Class;
		
		[Embed(source="/assets/SamAttack.png")]
		private static const SamAttackAtlas:Class;
		
		[Embed(source="/assets/SamWalk.xml",mimeType="application/octet-stream")]
		private static const SamWalkXML:Class;
		
		[Embed(source="/assets/SamWalk.png")]
		private static const SamWalkAtlas:Class;
		
		[Embed(source="/assets/MechanicAttack.xml",mimeType="application/octet-stream")]
		private static const MechanicAttackXML:Class;
		
		[Embed(source="/assets/MechanicAttack.png")]
		private static const MechanicAttackAtlas:Class;
		
		[Embed(source="/assets/FiremanWalk.xml",mimeType="application/octet-stream")]
		private static const FiremanWalkXML:Class;
		
		[Embed(source="/assets/FiremanWalk.png")]
		private static const FiremanWalkAtlas:Class;
		
		private static var _textureAssets:Dictionary = new Dictionary();
		private static var _xmlAssets:Dictionary = new Dictionary();
		private static var _atlasAssets:Dictionary = new Dictionary();
		private static var _soundAssets:Dictionary = new Dictionary();

		public function Assets() {
		}
		
		public static function getTexture(name:String):Texture
		{	
			if (_textureAssets[name] == undefined) {
				var bitmap:Bitmap = Bitmap(new Assets[name]());
				_textureAssets[name] = Texture.fromBitmap(bitmap);
			}

			return _textureAssets[name];
		}
		
		public static function getXML(name:String):XML
		{
			if (_xmlAssets[name] == undefined) {
				_xmlAssets[name] = XML(new Assets[name]());
			}

			return _xmlAssets[name];
		}
		
		public static function getTexturesFromAtlas(atlasname:String, prefix:String=""): Vector.<Texture>
		{	
			var fullTextureName:String = atlasname + ((prefix == "") ? "": "_" + prefix);

			if(_atlasAssets[atlasname] == undefined)
			{	
				var texture = getTexture(atlasname + "Atlas");
				var xml:XML = getXML(atlasname + "XML")
				_atlasAssets[atlasname] = new TextureAtlas(texture, xml);
				
			}
				
			return _atlasAssets[atlasname].getTextures(prefix);
		}

	}
	
}
