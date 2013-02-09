﻿package SpringGameJam {
	
	import starling.textures.TextureAtlas;
	import starling.textures.Texture;
	import flash.display.Bitmap;
    import flash.utils.Dictionary;
	
	public class Assets {
		
		[Embed(source="/assets/TestSpriteSheet.xml",mimeType="application/octet-stream")]
		private static const TestAnimXML:Class;
		
		[Embed(source="/assets/TestSpriteSheet.png")]
		private static const TestAnimAtlas:Class;
		
		[Embed(source="/assets/tile.png")]
		private static const TileBorder:Class;
		
		[Embed(source="/assets/tile_inner.png")]
		private static const TileInner:Class;
		
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