package Lir
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getTimer;

	public class MyEnterTimer extends Sprite
	{
		public function MyEnterTimer()
		{
			
		}
		
		private var lastTime:Number=0;
		private var dTime:Number = 0;
		private var totalTimer:Number = 0;

		
		/**
		 *获取总消耗时间 
		 * @return 
		 * 
		 */		
		public function getTotalTimer():Number{
			var time:Number = getTimer();
			dTime = time - lastTime;
			totalTimer +=dTime;
			lastTime = time;
			return this.totalTimer;
		}
		
		private var funcArr:Array = [];
		protected function onEnter(event:Event):void
		{
			if(!this.funcArr.length)return;
			for(var i:int in funcArr){
				funcArr[i]();
			}
		}
		
		public function addFunc(func:Function):void{
			this.funcArr.push(func);
		}
		
		public function removeAllFunc():void{
			this.funcArr = [];
		}
		
		public function reSet():void{
			this.dis();
			this.removeAllFunc();
			this.stop();
		}
		
		private static var _instance:MyEnterTimer;
		public static function get instance():MyEnterTimer
		{
			if(!_instance)_instance = new MyEnterTimer();
			return _instance;
		}
		
		
		public function start():void{
			dis();
			lastTime = getTimer();
			this.addEventListener(Event.ENTER_FRAME,onEnter);
		}
		
		public function stop():void{
			removeAllFunc();
			this.removeEventListener(Event.ENTER_FRAME,onEnter);
		}
		
		public function dis():void{
			lastTime = 0;
			dTime = 0;
			totalTimer = 0;
		}
	}
}