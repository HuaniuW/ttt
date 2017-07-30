package elements.role
{
	import game.engine.Engine;
	
	import lzm.starling.swf.display.SwfMovieClip;

	public class AcPlayer
	{
		public function AcPlayer()
		{
			Engine.createEngine().push(action);
		}
		
		private function action():void
		{
			// TODO Auto Generated method stub
//			trace("_acName   "+_acName);
			if(_mc&&_mc.currentFrame == _mc.totalFrames-_endCbkFrame){
				
				_cbk1();
			}
			
			if(_mc&&_mc.currentFrame == _acCbkframe){
				_cbk2();
			}
		}		
		
		
		private var _mc:SwfMovieClip;
		private var _acName:String;
		private var _endCbkFrame:int;
		private var _cbk1:Function;
		private var _acCbkframe:int;
		private var _cbk2:Function;
		
		
		public function getAc(mc:SwfMovieClip,acName:String,endCbkFrame:int,cbk1:Function,acCbkframe:int=0,cbk2:Function=null):void{
			trace("------------------------>>   "+acName);
			
			_mc = mc;
			_acName = acName;
			_endCbkFrame = endCbkFrame;
			_cbk1 = cbk1;
			_acCbkframe = acCbkframe;
			_cbk2 = cbk2;
			
			_mc.gotoAndPlay(_acName);
			
		}
		
	}
}