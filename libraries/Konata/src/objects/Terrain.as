package objects
{
	import flash.geom.Point;
	
	import starling.display.BlendMode;
	import starling.display.Image;
	import starling.display.QuadBatch;
	import starling.textures.Texture;

	public class Terrain extends GameObject
	{
		private var _grass:Vector.<Image>;
		private var _dirt:Vector.<Image>;
		
		public function Terrain(width:int, height:int)
		{
			super();
			
			solid = true;
			
//			var grassTexture:Texture = Assets.getTexture("grass_00");
//			grassTexture.repeat = true;
//			var grassImage:Image = new Image(grassTexture);
//			addChild(grassImage);
//			grassImage.setTexCoords(1, new Point(width, 0));
//			grassImage.setTexCoords(3, new Point(width, 1));
//			grassImage.width *= width;
			
			_grass = new Vector.<Image>();
			var grassBatch:QuadBatch = new QuadBatch();
			var grassTexture:Texture = Assets.getTexture("grass");
			for(var grassIndex:int = 0; grassIndex < width; grassIndex++) {
				var grassImage:Image = new Image(grassTexture);
				grassImage.blendMode = BlendMode.NONE;
				grassImage.x = grassIndex * grassImage.width;
//				addChild(grassImage);
				grassBatch.addImage(grassImage);
				_grass.push(grassImage);
			}
			addChild(grassBatch);
			
			if(height > 1) {
				_dirt = new Vector.<Image>();
				var dirtBatch:QuadBatch = new QuadBatch();
				var dirtTexture:Texture = Assets.getTexture("dirt2");
				for(var dirtX:int = 0; dirtX < width; dirtX++) {
					for(var dirtY:int = 0; dirtY < height; dirtY++) {
						var dirtImage:Image = new Image(dirtTexture);
						dirtImage.blendMode = BlendMode.NONE;
						dirtImage.x = dirtX * dirtImage.width;
						dirtImage.y = (dirtY + 1) * dirtImage.height;
//						addChild(dirt);
						dirtBatch.addImage(dirtImage);
						_dirt.push(dirtImage);
					}
				}
			}
			addChild(dirtBatch);
			
			flatten();
		}
	}
}