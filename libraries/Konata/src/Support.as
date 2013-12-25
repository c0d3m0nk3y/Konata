package {
	
	public class Support {
		public static var flashvars:Object;
		public static var platform:String;
		private static var date:Date;
		
		private static var logID:String = "";
		
		public static function getBaseURL(allowSecure:Boolean=true):String {
			var url:String = Constants.GAMEFOLDER;
			if (!allowSecure)
				url = url.replace("https:", "http:");
			return url;
		}
		
		public static function getCurrentTime():Number {
			date = new Date();
			return date.getTime();
		}
		
		public static function getSwfParam(name:String, defaultValue:String=""):String {
			try {
				var val:String;
				var paramObj:Object = flashvars[name];
				
				if (paramObj) {
					val = paramObj as String;
				} else {
					val = defaultValue;
				}
				
				
				return val;
			} catch (e:Error) {
				log('getSwfParam ', e);
			} finally {
				return val;
			}
		}
		
		public static function getVersion():String {
			return Constants.VERSION;
		}
		
		public static function isAndroid():Boolean {
			return (platform == Constants.PLATFORM_ANDROID);
		}
		
		public static function isCanvas():Boolean {
			return (platform == Constants.PLATFORM_CANVAS);
		}
		
		public static function isIOS():Boolean {
			return (platform == Constants.PLATFORM_IOS);
		}
		
		public static function isMobile():Boolean {
			return (platform == Constants.PLATFORM_ANDROID || platform == Constants.PLATFORM_IOS);
		}
		
		public static function joinIntsFromVector(sep:String, vect:Vector.<int>):String {
			if (!vect)
				return "";
			var str:String = "";
			for each (var i:int in vect) {
				if (str.length > 0)
					str += sep;
				str += "" + i;
			}
			return str;
		}
		
		/**
		 * Concatenate a list of variables into a string with the given separator<br/>
		 * e.g. String str = Support.joinVars(",", var1, var2, var3);
		 */
		public static function joinVars(sep:String, ... args):String {
			var s:String = "";
			for (var i:int = 0; i < args.length; i++) {
				if (i > 0)
					s += sep;
				s += args[i];
			}
			
			return s;
		}
		
		public static function log(message:String, e:Error=null):void {
			if (logID == "") {
				logID = (int(1 + Math.random() * 1000)).toString();
			}
			
			var date:Date = new Date();
			if (!message)
				message = '';
			if (e)
				message += " " + e.getStackTrace();
			message = "[" + logID + "] " + message;
			message = date.toTimeString().substr(0, 9) + message;
			
			trace(message);
			
			Konata.addDebug(message);
		
		}
		
		public static function setPlatform():void {
			platform = Constants.PLATFORM_CANVAS;
		}
	}
}
