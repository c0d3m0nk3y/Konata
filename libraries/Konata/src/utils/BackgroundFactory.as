package utils {
	import scenes.Background;
	
	public class BackgroundFactory {
		private static var _instance:BackgroundFactory;
		
		/**
		 * Use the names defined in background e.g.
		 * BackgroundFactory.get(Background.TEMPLE_LANE);
		 *
		 * @param name the name of the background.
		 */
		public static function get(name:String):Background {
			return instance.get(name);
		}
		
		private static function get instance():BackgroundFactory {
			return _instance ? _instance : new BackgroundFactory();
		}
		
		public function BackgroundFactory() {
			if (!_instance) {
				init();
				_instance = this;
			} else {
				throw Error("This is a singleton!  Do not call the constructor directly");
			}
		}
		
		private var background:Background;
		private var backgrounds:Object;
		
		private function get(name:String):Background {
			if (background) {
				background.destroy();
				background.removeFromParent(true);
				background = null;
			}
			
			background = new Background(name, backgrounds[name]);
			
			return background;
		}
		
		private function init():void {
			backgrounds = {"templelane":"4", "racingtrack":"8", "grandtech":"10"};
		}
	}
}
