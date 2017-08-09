package AI.actionAI
{
	import AI.AIBase;
	
	import elements.I.Ibiont;
	import elements.texiao.TXTiliHuifu;
	
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
		
		private var _TXTiliHuifu:TXTiliHuifu;
		private var _bi:Number = 0;
		public function getAddTili(bi:Number,stopNums:int = 60):void{
			_bi = bi;
			_stopNums = stopNums;
			if(!_TXTiliHuifu)_TXTiliHuifu = new TXTiliHuifu();
			
			Engine.createEngine().push(action);
			var s:Number = _obj.getRoleTili().maxTili*bi/_stopNums;
			_obj.getRoleTili().setZZSD(s);
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
			
			
			if(!_obj.getRoleTili().isGetRest()){
				if(_nums==0)showAddTiliTX();
				_nums++;
			}
//			trace(_obj.getRoleTili().curTili+"    "+_obj.getRoleTili().maxTili);
			if(_nums>=_stopNums){
				reset();
				_obj.getStop();
//				_obj.getRoleTili().tiliAddBi(_bi);
				this._cbk();
			}
		}
		
		/**
		 *显示加体力的动画 
		 * 
		 */		
		private function showAddTiliTX():void
		{
			trace(_obj.getWidth());
			_TXTiliHuifu.setCXSJ(_stopNums);
			_TXTiliHuifu.show("",_obj);
		}
		
		private function reset():void{
			_nums = 0;
			_TXTiliHuifu.stopAddTili();
			_obj.getRoleTili().HYZZSD();
			Engine.createEngine().pop(action);
		}
	}
}