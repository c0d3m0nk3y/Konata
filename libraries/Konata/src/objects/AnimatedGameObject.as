package objects
{
	import starling.animation.IAnimatable;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class AnimatedGameObject extends Sprite implements IAnimatable
	{
		private var currentFrame:int;
		private var frames:int;
		private var images:Vector.<Image>;
		private var timeElapsed:Number = 0;
		protected var msBeforeUpdate:Number = 1/3;
		
		public function AnimatedGameObject(spriteSheetName:String, frames:int, frameWidth:Number=0, frameHeight:Number=0)
		{
			super();
			
			this.frames = frames;
			images = new Vector.<Image>();
			
			for(var imageIndex:int = 0; imageIndex < frames; imageIndex++)
			{
				var framesString:String = "000" + imageIndex;
				framesString = framesString.substr(framesString.length-3);
				
				var image:Image = new Image(Konata.assets.getTexture(spriteSheetName + "_" + framesString));
				if(frameWidth != 0) image.width = frameWidth;
				if(frameHeight != 0) image.height = frameHeight;
				
				Support.log("imgWidth " + image.width);
				images.push(image);
			}
			nextImage();
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		protected function onAddedToStage(event:Event=null):void
		{
			Starling.current.juggler.add(this);
		}
		
		protected function onRemovedFromStage(event:Event=null):void
		{
			Starling.current.juggler.remove(this);
		}
		
		private function nextImage():void
		{
			removeChild(images[currentFrame]);
			currentFrame++;
			if(currentFrame >= frames) currentFrame = 0;
			addChild(images[currentFrame]);
		}
		
		protected function update():void
		{
			nextImage();
		}
		
		public function advanceTime(timeDelta:Number):void
		{
			timeElapsed += timeDelta;
			if(timeElapsed > msBeforeUpdate)
			{
				update();
				timeElapsed -= msBeforeUpdate;
			}
		}
		
		public function destroy():void
		{
			Starling.current.juggler.remove(this);
			
			while(images.length > 0)
			{
				images.pop().removeFromParent(true);
			}
			images = null;
		}
	}
}