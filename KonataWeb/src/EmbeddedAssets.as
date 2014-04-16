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
		
		[Embed(source="/textures/background.png")]
		public static const background:Class;
		
		// Texture Atlas
		
		[Embed(source="/textures/sprites.xml", mimeType="application/octet-stream")]
		public static const sprites_xml:Class;
		
		[Embed(source="/textures/sprites.png")]
		public static const sprites:Class;
		
		[Embed(source="/textures/atlas.xml", mimeType="application/octet-stream")]
		public static const atlas_xml:Class;
		
		[Embed(source="/textures/atlas.png")]
		public static const atlas:Class;
		
		[Embed(source="/textures/templelane.xml", mimeType="application/octet-stream")]
		public static const templelane_xml:Class;
		
		[Embed(source="/textures/templelane.png")]
		public static const templelane:Class;
		
		[Embed(source="/textures/racingtrack.xml", mimeType="application/octet-stream")]
		public static const racingtrack_xml:Class;
		
		[Embed(source="/textures/racingtrack.png")]
		public static const racingtrack:Class;
		
		[Embed(source="/textures/grandtech.xml", mimeType="application/octet-stream")]
		public static const grandtech_xml:Class;
		
		[Embed(source="/textures/grandtech.png")]
		public static const grandtech:Class;
		
		[Embed(source="/textures/cherub.png")]
		public static const cherub:Class;
		
		[Embed(source="/textures/cherub.xml", mimeType="application/octet-stream")]
		public static const cherub_xml:Class;

		// Bitmap Fonts
		
		[Embed(source="/fonts/cooperblack.fnt", mimeType="application/octet-stream")]
		public static const cooperblack_fnt:Class;
		
		[Embed(source = "/fonts/cooperblack.png")]
		public static const cooperblack:Class;
		
		[Embed(source="/fonts/cooperblacklg.fnt", mimeType="application/octet-stream")]
		public static const cooperblacklg_fnt:Class;
		
		[Embed(source = "/fonts/cooperblacklg.png")]
		public static const cooperblacklg:Class;

		[Embed(source="/fonts/corbel.fnt", mimeType="application/octet-stream")]
		public static const corbel_fnt:Class;
		
		[Embed(source = "/fonts/corbel.png")]
		public static const corbel:Class;
		
		// Sounds
		
		[Embed(source="/audio/pop.mp3")]
		public static const pop:Class;
	}
}