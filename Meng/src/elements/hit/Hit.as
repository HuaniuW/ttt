package elements.hit
{
	import lzm.starling.swf.display.SwfSprite;
	
	public class Hit extends SwfSprite
	{
		public function Hit()
		{
			super();
		}
		
		public static function getInstance():Hit{
			return new Hit();
		}
	}
}