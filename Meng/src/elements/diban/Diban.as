package elements.diban
{
	import controls.HitManager;
	
	import elements.base.StaticElementBase;
	
	import nape.space.Space;
	
	import starling.display.Image;
	
	public class Diban extends StaticElementBase
	{
		public function Diban(_x:Number, _y:Number, _w:Number, _h:Number, img:Image, space:Space, type:String="STATIC")
		{
			super(_x, _y, _w, _h, img, space, type);
			body.cbTypes.add(HitManager.diban);
		}
	}
}