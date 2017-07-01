package
{
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import lzm.starling.STLStarup;
	
	import starling.core.Starling;
	
	public class MengMeng extends STLStarup
	{
		public function MengMeng()
		{
			super();
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.frameRate = 60;
			stage.color =  0x555555;//0x9CD6D7;
			Starling.multitouchEnabled = true;
			initStarling(Main,2000,true);
		}
	}
}