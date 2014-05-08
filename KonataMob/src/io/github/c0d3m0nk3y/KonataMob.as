package io.github.c0d3m0nk3y {
	import flash.desktop.NativeApplication;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	
	import starling.core.Starling;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	import starling.utils.RectangleUtil;
	import starling.utils.ScaleMode;
	
	import utils.AudioManager;
	
	[SWF(frameRate = "30", width = "800", height = "600", backgroundColor = "0x0")]
	public class KonataMob extends Sprite {
		// Startup image for HD screens
		[Embed(source = "../../../../../libraries/Konata/system/startup.png")]
		private static var BackgroundHD:Class;
		
		public function KonataMob() {
			super();
			
			// This project requires the sources of the "demo" project. Add them either by 
			// referencing the "demo/src" directory as a "source path", or by copying the files.
			// The "media" folder of this project has to be added to its "source paths" as well, 
			// to make sure the icon and startup images are added to the compiled mobile app.
			
			// set general properties
			var iOS:Boolean = Capabilities.manufacturer.indexOf("iOS") != -1;
			if (iOS) {
				Support.platform = Constants.PLATFORM_IOS
			} else {
				Support.platform = Constants.PLATFORM_ANDROID;
			}
			
			Starling.multitouchEnabled = true; // useful on mobile devices
			Starling.handleLostContext = !iOS; // not necessary on iOS. Saves a lot of memory!
			
			// create a suitable viewport for the screen size
			// 
			// we develop the game in a *fixed* coordinate system of 320x480; the game might 
			// then run on a device with a different resolution; for that case, we zoom the 
			// viewPort to the optimal size for any display and load the optimal textures.
			var stageHeight:int = 600;
			var stageWidth:int = stageHeight * stage.fullScreenWidth / stage.fullScreenHeight;
			
			var viewPort:Rectangle = RectangleUtil.fit(new Rectangle(0, 0, stageWidth, stageHeight), new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight), ScaleMode.NO_BORDER, false);
			
			// create the AssetManager, which handles all required assets for this resolution
			
			var appDir:File = File.applicationDirectory;
			var assetManager:AssetManager = new AssetManager();
			
			assetManager.verbose = Capabilities.isDebugger && Constants.DEBUG_ASSETS;
			assetManager.enqueue(appDir.resolvePath("audio"), appDir.resolvePath("fonts"), appDir.resolvePath("textures"));
			
			// While Stage3D is initializing, the screen will be blank. To avoid any flickering, 
			// we display a startup image now and remove it below, when Starling is ready to go.
			// This is especially useful on iOS, where "Default.png" (or a variant) is displayed
			// during Startup. You can create an absolute seamless startup that way.
			// 
			// These are the only embedded graphics in this app. We can't load them from disk,
			// because that can only be done asynchronously - i.e. flickering would return.
			// 
			// Note that we cannot embed "Default.png" (or its siblings), because any embedded
			// files will vanish from the application package, and those are picked up by the OS!
			
			var background:Bitmap = new BackgroundHD();
			BackgroundHD = null; // no longer needed!
			
			//For the width, you need to multiply height by (image width in pixels / image height in pixels)
			background.height = viewPort.height;
			background.width = background.height * 1137 / 640;
			background.x = viewPort.width / 2 - background.width / 2;
			background.y = viewPort.y;
			background.smoothing = true;
			addChild(background);
			
			// launch Starling
			mStarling = new Starling(Konata, stage, viewPort);
			mStarling.stage.stageWidth = stageWidth; // <- !same size on all devices
			mStarling.stage.stageHeight = stageHeight; // <- same size on all devices
//			mStarling.simulateMultitouch = false;
			mStarling.enableErrorChecking = false;
			mStarling.showStats = true;
			mStarling.addEventListener(starling.events.Event.ROOT_CREATED, function():void {
				removeChild(background);
				
				var konata:Konata = mStarling.root as Konata;
				var bgTexture:Texture = Texture.fromBitmap(background);//, false, false, scaleFactor);
				
				konata.start(bgTexture, assetManager);
				mStarling.start();
			});
			
			// When the game becomes inactive, we pause Starling; otherwise, the enter frame event
			// would report a very long 'passedTime' when the app is reactivated. 
			NativeApplication.nativeApplication.addEventListener(flash.events.Event.ACTIVATE, onActivate);
			
			NativeApplication.nativeApplication.addEventListener(flash.events.Event.DEACTIVATE, onDeactivate);
		}
		
		private var mStarling:Starling;
		
		private function onActivate(e:flash.events.Event):void {
			mStarling.start();
		}
		
		private function onDeactivate(e:flash.events.Event):void {
			mStarling.stop();
		}
	}
}

