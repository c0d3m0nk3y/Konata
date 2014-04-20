package objects
{
	import starling.display.Image;

	public class Terrain extends GameObject
	{
		private var _grass:Vector.<Image>;
		private var _dirt:Vector.<Image>;
		
		public function Terrain(width:int, height:int)
		{
			super();
			
			solid = true;
			
			_grass = new Vector.<Image>();
			for(var grassIndex:int = 0; grassIndex < width; grassIndex++) {
				var grass:Image = new Image(Assets.getTexture("grass"));
				grass.x = grassIndex * grass.width;
				addChild(grass);
				_grass.push(grass);
			}
			
			_dirt = new Vector.<Image>();
			if(height > 1) {
				for(var dirtX:int = 0; dirtX < width; dirtX++) {
					for(var dirtY:int = 0; dirtY < height; dirtY++) {
						var dirt:Image = new Image(Assets.getTexture("dirt"));
						dirt.x = dirtX * dirt.width;
						dirt.y = (dirtY + 1) * dirt.height;
						addChild(dirt);
						_dirt.push(dirt);
					}
				}
			}
		}
	}
}