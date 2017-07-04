package
{
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import lzm.starling.STLStarup;
	
	import starling.core.Starling;
	
	public class Meng extends STLStarup
	{
		public function Meng()
		{
			super();
			// 支持 autoOrient
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.frameRate = 60;
			Starling.multitouchEnabled = true;
			initStarling(Main,1500,true);
		}
	}
}