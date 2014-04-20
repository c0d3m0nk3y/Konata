package objects
{
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
			
			var terrainBatch:QuadBatch = new QuadBatch();
			
			_grass = new Vector.<Image>();
			var grassTexture:Texture = Assets.getTexture("grass_00");
			for(var grassIndex:int = 0; grassIndex < width; grassIndex++) {
				var grassImage:Image = new Image(grassTexture);
				grassImage.x = grassIndex * grassImage.width;
				terrainBatch.addImage(grassImage);
				_grass.push(grassImage);
			}
			
			if(height > 1) {
				_dirt = new Vector.<Image>();
				var dirtTexture:Texture = Assets.getTexture("dirt_00");
				for(var dirtX:int = 0; dirtX < width; dirtX++) {
					for(var dirtY:int = 0; dirtY < height; dirtY++) {
						var dirtImage:Image = new Image(dirtTexture);
						dirtImage.blendMode = BlendMode.NONE;
						dirtImage.x = dirtX * dirtImage.width;
						dirtImage.y = (dirtY + 1) * dirtImage.height;
						terrainBatch.addImage(dirtImage);
						_dirt.push(dirtImage);
					}
				}
			}
			
			addChild(terrainBatch);
			
			flatten();
		}
	}
}