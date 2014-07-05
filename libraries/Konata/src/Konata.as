package {
	import flash.utils.getDefinitionByName;
	
	import scenes.MainMenu;
	import scenes.Scene;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	import utils.ProgressBar;
	
	public class Konata extends Sprite {
		
		public static var instance:Konata;
		
		public static function addDebug(str:String):void {
			if (instance)
				instance.addDebug(str);
		}
		
		public static function closeScene():void {
			instance.closeScene();
		}
		
		public static function showScene(name:String):void {
			instance.showScene(name);
		}
		
		public static function switchScene(name:String):void {
			closeScene();
			instance.showScene(name);
		}
		
		public function Konata() {
			instance = this;
			
//			Starling.current.nativeStage.addEventListener(flash.events.KeyboardEvent.KEY_DOWN, checkKeyPress, false, 0, true);
		}
		
		private var backgroundImage:Image;
		private var debugBack:Quad;
		private var debugText:TextField;
		private var mCurrentScene:Scene;
		private var mLoadingProgress:ProgressBar;
		private var mMainMenu:MainMenu;
		
		public function showScene(name:String):void {
			if (mCurrentScene)
				return;
			
			try {
				var sceneClass:Class = getDefinitionByName(name) as Class;
				mCurrentScene = new sceneClass() as Scene;
				mMainMenu.removeFromParent();
				addChild(mCurrentScene);
			} catch (e:Error) {
				Support.log("Core.showScene error", e);
			}
		}
		
		public function start(background:Texture, assetManager:AssetManager):void {
			Assets.assetManager = assetManager;
			//			Support.setPlatform();
			
			// The background is passed into this method for two reasons:
			// 
			// 1) we need it right away, otherwise we have an empty frame
			// 2) the Startup class can decide on the right image, depending on the device.
			
			backgroundImage = new Image(background);
			backgroundImage.pivotX = background.width / 2;
			backgroundImage.x = stage.stageWidth / 2;
			addChild(backgroundImage);
			
			// The AssetManager contains all the raw asset data, but has not created the textures
			// yet. This takes some time (the assets might be loaded from disk or even via the
			// network), during which we display a progress indicator. 
			
			Constants.GameWidth = stage.stageWidth;
			Constants.GameHeight = stage.stageHeight;
			Constants.CenterX = stage.stageWidth / 2;
			Constants.CenterY = stage.stageHeight / 2;
			
			mLoadingProgress = new ProgressBar(175, 20);
			mLoadingProgress.x = (Constants.GameWidth - mLoadingProgress.width) / 2;
			mLoadingProgress.y = Constants.GameHeight * 0.7;
			addChild(mLoadingProgress);
			
			assetManager.loadQueue(function(ratio:Number):void {
				mLoadingProgress.ratio = ratio;
				// a progress bar should always show the 100% for a while,
				// so we show the main menu only after a short delay. 
				
				if (ratio == 1)
					Starling.juggler.delayCall(function():void {
						mLoadingProgress.removeFromParent(true);
						mLoadingProgress = null;
						onAssetsLoaded();
					}, 0.15);
			});
			
			addEventListener(Event.TRIGGERED, onButtonTriggered);
			
			initDebug();
		}
		
		private function addDebug(str:String):void {
			if (!Constants.DEBUG_ENABLED)
				return;
			
			try {
				addChild(debugBack);
				debugText.text = str + "\n" + debugText.text;
				addChild(debugText);
			} catch (e:Error) {
				
			}
		}
		
//		private function checkKeyPress(event:flash.events.KeyboardEvent=null):void {
//			switch (event.keyCode) {
//				case Keyboard.BACK:
//					
//					if (mCurrentScene) {
//						event.preventDefault();
//						closeScene();
//					}
//					break;
//			}
//		}
		
		private function closeScene():void {
			if (mCurrentScene) {
				mCurrentScene.destroy();
				mCurrentScene.removeFromParent(true);
			}
			mCurrentScene = null;
			showMainMenu();
		}
		
		private function initDebug():void {
			if (!Constants.DEBUG_ENABLED)
				return;
			
			if (debugBack) {
				removeChild(debugBack);
				debugBack = null;
			}
			debugBack = new Quad(Constants.GameWidth, Constants.GameHeight - 1, 0x333333);
			debugBack.alpha = 0.4;
			debugBack.touchable = false;
			
			if (debugText) {
				removeChild(debugText);
				debugText = null;
			}
			debugText = new starling.text.TextField(Constants.GameHeight, Constants.GameHeight, "*Debug\n", "Veranda", 12, 0xffffff);
			debugText.vAlign = VAlign.TOP;
			debugText.hAlign = HAlign.LEFT;
			debugText.touchable = false;
			
			addChild(debugText);
		}
		
		private function onAssetsLoaded():void {
			Assets.loaded = true;
			
			var background:Image = new Image(Assets.getTexture("background"));
			background.pivotX = background.width / 2;
			background.x = Constants.GameWidth / 2;
			addChild(background);
			
			showMainMenu();
		}
		
		private function onButtonTriggered(event:Event):void {
			var button:Button = event.target as Button;
			
			// don't handle buttons that handle themselves.
			if (button.hasEventListener(Event.TRIGGERED) || button.name == "" || !button.name)
				return;
			
			if (button.name == "backButton") {
				closeScene();
			} else
				showScene(button.name);
		}
		
		private function showMainMenu():void {
			if (mMainMenu == null)
				mMainMenu = new MainMenu();
			
			addChild(mMainMenu);
		}
	}
}
