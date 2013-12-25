package {
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	
	public class Assets {
		private static var _assetManager:AssetManager;
		private static var _loaded:Boolean;
		
		public static function set assetManager(value:AssetManager):void {
			_assetManager = value;
		}
		
		public static function getSound(name:String):Sound {
			return _assetManager.getSound(name);
		}
		
		public static function getTexture(name:String):Texture {
			return _assetManager.getTexture(name);
		}
		
		public static function get loaded():Boolean {
			return _loaded;
		}
		
		public static function set loaded(value:Boolean):void {
			_loaded = value;
		}
		
		public static function playSound(name:String, startTime:Number=0, loops:int=0, transform:SoundTransform=null):SoundChannel {
			return _assetManager.playSound(name, startTime, loops, transform);
		}
		
		public function Assets() {
			throw new Error("No need to instantiate an Asset object, do not call the constructor directly.");
		}
	}
}
