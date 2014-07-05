package {
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.system.Capabilities;
	
	import starling.core.Starling;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	
	[SWF(frameRate = "60", width = "800", height = "600", backgroundColor = "0x333333")]
	public class KonataWeb extends Sprite {
		private static var _instance:KonataWeb;
		
		public static function get instance():KonataWeb {
			return _instance;
		}
		
		public function KonataWeb() {
			_instance = this;
			if (stage) {
				start();
			} else {
				addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			}
		}
		
		[Embed(source = "/startup.png")]
		private var Background:Class;
		
		private var mStarling:Starling;
		
		protected function onMouseWheel(event:MouseEvent):void {
			Starling.current.nativeOverlay.dispatchEvent(event);
		}
		
		private function onAddedToStage(event:Object):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			start();
		}
		
		private function onRootCreated(event:Event, konata:Konata):void {
			// set framerate to 30 in software mode
			if (mStarling.context.driverInfo.toLowerCase().indexOf("software") != -1)
				mStarling.nativeStage.frameRate = 30;
			
			// define which resources to load
			var assets:AssetManager = new AssetManager();
			assets.verbose = Capabilities.isDebugger && Constants.DEBUG_ASSETS;
			assets.enqueue(EmbeddedAssets);
			
			// background texture is embedded, because we need it right away!
			var bgTexture:Texture = Texture.fromBitmap(new Background());
			
			// game will first load resources, then start menu
			konata.start(bgTexture, assets);
		}
		
		private function start():void {
			Support.platform = Constants.PLATFORM_CANVAS;
			
			Starling.multitouchEnabled = true; // for Multitouch Scene
			Starling.handleLostContext = true; // required on Windows, needs more memory
			
			var o:Object = LoaderInfo(this.loaderInfo);
			Support.flashvars = LoaderInfo(this.loaderInfo).parameters;
			
			Support.log("KonataWeb.start " + JSON.stringify(Support.flashvars));
			
			mStarling = new Starling(Konata, stage);
			mStarling.simulateMultitouch = true;
			mStarling.enableErrorChecking = Capabilities.isDebugger;
			mStarling.start();
			
			// this event is dispatched when stage3D is set up
			mStarling.addEventListener(Event.ROOT_CREATED, onRootCreated);
//			stage.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel, false, 0, true);
		}
	}
}
