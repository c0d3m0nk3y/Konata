package
{
	import flash.media.Sound;
	
	import starling.textures.Texture;
	import starling.utils.AssetManager;

	public class Assets
	{
		private static var _assetManager:AssetManager;
		
		public function Assets() {
		}

		public static function set assetManager(value:AssetManager):void {
			_assetManager = value;
		}

		public static function getTexture(name:String):Texture {
			return _assetManager.getTexture(name);
		}
		
		public static function getSound(name:String):Sound {
			return _assetManager.getSound(name);
		}
	}
}