package Lir
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextFormat;
	
	

	
	public class Jishiqi extends Sprite
	{
		public function Jishiqi()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE,onStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE,onRemove);
		}
		
		public function getFunIn():void{
			MyEnterTimer.instance.addFunc(this.onTimer);
		}
		
		protected function onRemove(event:Event):void
		{
			txt.txts.text = "00:00";
		}
		
		protected function onStage(event:Event):void
		{
			view();
		}		
		
		public var txt:Object;
		private var format:TextFormat;
		private function view():void
		{
			if(!txt){

				txt = Txcz.getLbyName("txt");
				this.addChild(txt as DisplayObject);
				
				
			}
			txt.txts.text = "00:00";
		}
		
		public function getStart():void{
			numHM = "0";
			numM = "0";
			num = 0;
			hm = 0;
		}
		
		
		private var numHM:String = "0";
		private var numM:String = "0";
		public var num:int = 0;
		private var hm:int = 0;
		private var isGo:Boolean = true;
		protected function onTimer():void
		{
			if(!isGo)return;
			num = MyEnterTimer.instance.getTotalTimer();
			num++;
			
			
			var s1:int = num%1000;
			var s2:int = s1/10;
			
//			HM = s2<10?"0"+s2:s2+"";
			
			
			hm = s2;
			var m:int = num/1000;
			numHM = hm<10?"0"+hm:hm+"";
			numM = m<10?"0"+m:m+"";
			txt.txts.text = numM+":"+numHM;
		}
		
		
		public function getStop():void{
			this.isGo = false;			
		}
		
		public function reset():void{
			this.isGo = true;
			numHM = "0";
			numM = "0";
			num = 0;
			hm = 0;
			txt.txts.text = "00:00";
		}
		
		
		
	}
}