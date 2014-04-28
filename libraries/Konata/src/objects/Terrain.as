package objects
{
	import scenes.GamePage;
	
	import starling.display.BlendMode;
	import starling.display.Image;
	import starling.display.QuadBatch;
	import starling.textures.Texture;

	public class Terrain extends GameObject
	{
		public function Terrain(width:int, height:int)
		{
			super();
			
			solid = true;
			
			var terrainBatch:QuadBatch = new QuadBatch();
			
			var grassTexture:Texture = Assets.getTexture("grass_00");
			for(var grassIndex:int = 0; grassIndex < width; grassIndex++) {
				var grassImage:Image = new Image(grassTexture);
				grassImage.x = grassIndex * grassImage.width;
				terrainBatch.addImage(grassImage);
			}
			
			if(height > 1) {
				var dirtTexture:Texture = Assets.getTexture("dirt_00");
				for(var dirtX:int = 0; dirtX < width; dirtX++) {
					for(var dirtY:int = 0; dirtY < height; dirtY++) {
						var dirtImage:Image = new Image(dirtTexture);
						dirtImage.blendMode = BlendMode.NONE;
						dirtImage.x = dirtX * dirtImage.width;
						dirtImage.y = (dirtY + 1) * dirtImage.height;
						terrainBatch.addImage(dirtImage);
					}
				}
			}
			
			addChild(terrainBatch);
			
			flatten();
		}
		
		override protected function update(time:Number):void {
			super.update(time);
			
			x -= GamePage.scrollSpeed;
			
			if(x + width < 0) removeFromParent();
		}
	}
}