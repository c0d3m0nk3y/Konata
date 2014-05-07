package scenes {
	import objects.GameObject;
	
	import starling.display.Image;
	import starling.events.Event;
	
	public class Background extends GameObject {
		private var _farbgl:Image;
		private var _farbgr:Image;
		private var _midbgl_1:Image;
		private var _midbgr_1:Image;
		private var _midbgl_2:Image;
		private var _midbgr_2:Image;
		private var _nearbgl_1:Image;
		private var _nearbgr_1:Image;
		private var _nearbgl_2:Image;
		private var _nearbgr_2:Image;
		
		public function Background() {
			super();
			
			solid = false;
			
			_farbgl = new Image(Assets.getTexture("farground"));
			_farbgl.scaleX = _farbgl.scaleY = 4;
			_farbgr = new Image(Assets.getTexture("farground"));
			_farbgr.scaleX = _farbgr.scaleY = 4;
			_farbgr.x = Constants.GameWidth;
			
			_midbgl_1 = new Image(Assets.getTexture("midground_001"));
			_midbgl_1.scaleX = _midbgl_1.scaleY = 4;
			_midbgr_1 = new Image(Assets.getTexture("midground_001"));
			_midbgr_1.scaleX = _midbgr_1.scaleY = 4;
			_midbgr_1.x = Constants.GameWidth;
			
			_midbgl_2 = new Image(Assets.getTexture("midground_002"));
			_midbgl_2.scaleX = _midbgl_2.scaleY = 4;
			_midbgr_2 = new Image(Assets.getTexture("midground_002"));
			_midbgr_2.scaleX = _midbgr_2.scaleY = 4;
			_midbgr_2.x = Constants.GameWidth;
			
			_nearbgl_1 = new Image(Assets.getTexture("nearground_001"));
			_nearbgl_1.scaleX = _nearbgl_1.scaleY = 4;
			_nearbgr_1 = new Image(Assets.getTexture("nearground_001"));
			_nearbgr_1.scaleX = _nearbgr_1.scaleY = 4;
			_nearbgr_1.x = Constants.GameWidth;
			
			_nearbgl_2 = new Image(Assets.getTexture("nearground_002"));
			_nearbgl_2.scaleX = _nearbgl_2.scaleY = 4;
			_nearbgr_2 = new Image(Assets.getTexture("nearground_002"));
			_nearbgr_2.scaleX = _nearbgr_2.scaleY = 4;
			_nearbgr_2.x = Constants.GameWidth;
		}
		override protected function onAddedToStage(event:Event=null):void {
			super.onAddedToStage(event);
			
			addChild(_farbgl);
			addChild(_farbgr);
			addChild(_midbgl_1);
			addChild(_midbgr_1);
			addChild(_midbgl_2);
			addChild(_midbgr_2);
			addChild(_nearbgl_1);
			addChild(_nearbgr_1);
			addChild(_nearbgl_2);
			addChild(_nearbgr_2);
		}
		
		private var _farSpeed:int = 50;
		private var _midSpeed:int = 250;
		private var _nearSpeed:int = 500;
		
		override public function advanceTime(time:Number):void {
			super.advanceTime(time);
			
			_farbgl.x -= time * _farSpeed;
			_farbgr.x -= time * _farSpeed;
			if(_farbgr.x <= 0) {
				_farbgl.x = 0;
				_farbgr.x = Constants.GameWidth;
			}
			
			_midbgl_1.x -= time * _midSpeed;
			_midbgr_1.x -= time * _midSpeed;
			if(_midbgr_1.x <= 0) {
				_midbgl_1.x = 0;
				_midbgr_1.x = Constants.GameWidth;
			}
			
			_midbgl_2.x -= time * (_midSpeed * 1.1);
			_midbgr_2.x -= time * (_midSpeed * 1.1);
			if(_midbgr_2.x <= 0) {
				_midbgl_2.x = 0;
				_midbgr_2.x = Constants.GameWidth;
			}
			
			_nearbgl_1.x -= time * _nearSpeed;
			_nearbgr_1.x -= time * _nearSpeed; 
			if(_nearbgr_1.x <= 0) {
				_nearbgl_1.x = 0;
				_nearbgr_1.x = Constants.GameWidth;
			}
			
			_nearbgl_2.x -= time * (_nearSpeed * 1.1);
			_nearbgr_2.x -= time * (_nearSpeed * 1.1);
			if(_nearbgr_2.x <= 0) {
				_nearbgl_2.x = 0;
				_nearbgr_2.x = Constants.GameWidth;
			}
		}
	}
}
