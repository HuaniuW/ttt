package AI.actionAI
{
	import AI.AIBase;
	
	import elements.I.Ibiont;
	
	import game.engine.Engine;
	
	public class AIAddTili extends AIBase
	{
		public function AIAddTili(obj:Ibiont, targetObj:Ibiont, cbk:Function)
		{
			super(obj, targetObj, cbk);
		}
		
		public static function getInstance(obj:Ibiont,targetObj:Ibiont,cbk:Function):AIAddTili
		{
			return new AIAddTili(obj,targetObj,cbk);
		}
		
		private var _bi:Number = 0;
		public function getAddTili(bi:Number,stopNums:int = 60):void{
			_bi = bi;
			_stopNums = stopNums;
			Engine.createEngine().push(action);
		}
		
		private var _stopNums:int = 0;
		private var _nums:int = 0;
		private function action():void
		{
			// TODO Auto Generated method stub
			if(_obj.isDie()||_obj.getIsBeHiting()||_obj.getIsBeHitOuting()){
				reset();
				this._cbk();
				return;
			}
			
			
			_nums++;
			trace("addTiliing   "+_nums);
			if(_nums>=_stopNums){
				reset();
				
				_obj.getStop();
				_obj.getRoleTili().tiliAddBi(_bi);
				this._cbk();
			}
		}
		
		private function reset():void{
			_nums = 0;
			Engine.createEngine().pop(action);
		}
	}
}