package elements.I
{
	import elements.jineng.JinengVO;
	
	import lzm.starling.swf.display.SwfImage;

	public interface IHit
	{
		function getHitMc():SwfImage;
		function getBeHitMc():SwfImage;
		function getScaleX():int;
		function getX():int;
		function getY():int;
		function getJNObj():JinengVO;
	}
}