package
{
	

	public class EmbeddedAssets
	{
		/** ATTENTION: Naming conventions!
		 *  
		 *  - Classes for embedded IMAGES should have the exact same name as the file,
		 *    without extension. This is required so that references from XMLs (atlas, bitmap font)
		 *    won't break.
		 *    
		 *  - Atlas and Font XML files can have an arbitrary name, since they are never
		 *    referenced by file name.
		 * 
		 */
		// Texture Atlas
		
		[Embed(source="/textures/sprites.xml", mimeType="application/octet-stream")]
		public static const sprites_xml:Class;
		
		[Embed(source="/textures/sprites.png")]
		public static const sprites:Class;
		
		// Bitmap Fonts

		[Embed(source="/fonts/corbel.fnt", mimeType="application/octet-stream")]
		public static const corbel_fnt:Class;
		
		[Embed(source = "/fonts/corbel.png")]
		public static const corbel:Class;
		
		// Sounds
		
		[Embed(source="/audio/pew.mp3")]
		public static const pew:Class;
		
		[Embed(source="/audio/spacemusic.mp3")]
		public static const spacemusic:Class;
		
		[Embed(source="/audio/small_explosion.mp3")]
		public static const small_explosion:Class;
	}
}