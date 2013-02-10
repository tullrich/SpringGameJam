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
		
		[Embed(source="/assets/RobotIdle.xml",mimeType="application/octet-stream")]
		private static const RobotIdleXML:Class;
		
		[Embed(source="/assets/RobotIdle.png")]
		private static const RobotIdleAtlas:Class;
		
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
		
		[Embed(source="/assets/overlay_interact.png")]
		private static const OverlayInteract:Class;
		
		[Embed(source="/assets/Airplane.png")]
		private static const BgAirplane:Class;
		
		[Embed(source="/assets/WaterBg2.png")]
		private static const BgWater:Class;
		
		[Embed(source="/assets/Fire.xml",mimeType="application/octet-stream")]
		private static const FireXML:Class;
		
		[Embed(source="/assets/Fire.png")]
		private static const FireAtlas:Class;
		
		
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
