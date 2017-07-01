package elements.I
{
	import lzm.starling.swf.display.SwfImage;

	public interface IHit
	{
		function getHitMc():SwfImage;
		function getBeHitMc():SwfImage;
		function getScaleX():int;
		function getX():int;
		function getY():int;
		function getGJSZ():Object;
	}
}