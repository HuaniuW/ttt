package Lir
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class MyTimer
	{
		public function MyTimer()
		{
			if(!timer)timer = new Timer(1);
			timer.addEventListener(TimerEvent.TIMER,onTimer);
		}
		
		private var funArr:Array = [];
		protected function onTimer(event:TimerEvent):void
		{
			// TODO Auto-generated method stub
			if(!funArr.length)return;
			for(var i:int in funArr){
				funArr[i]();
			}
		}
		
		public function getFunIn(fun:Function):void{
			funArr.push(fun);		
		}
		
		public function start():void{
			timer.start();
		}
		
		public function stop():void{
			timer.stop();
			funArr = [];
			trace("ok all stop");
		}
		
		private static var instance:MyTimer;
		public static function getInstance():MyTimer{
			if(!instance)instance = new MyTimer();
			return instance;
		}
		
		private var timer:Timer;
		
		
	}
}