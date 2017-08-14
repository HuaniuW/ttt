package AI.actionAI
{
	import AI.baseAI.AIAtk;
	
	import elements.I.Ibiont;
	
	import game.engine.Engine;
	import AI.baseAI.AIMoveNear;
	import AI.AIBase;
	
	public class AIAcPlay extends AIBase
	{
		private var _acArr:Array = [];
		protected var _isAction:Boolean = false;
		private var _isQishouGJ:Boolean = false;
		private var atkDistance:int = 180;
		protected var isDiyizhao:Boolean = true;
		
		
		public function AIAcPlay(obj:Ibiont, targetObj:Ibiont, cbk:Function)
		{
			super(obj, targetObj, cbk);
		}
		
		
		
		
		private static var _instance:AIAcPlay;
		public static function getInstance(obj:Ibiont, targetObj:Ibiont, cbk:Function):AIAcPlay{
			return new AIAcPlay(obj,targetObj,cbk);
		}
		
		
		protected var _czhaoshi:String = "";
		/**
		 *取到攻击招式列表数组 
		 * @param arr
		 * 
		 */		
		public function getAcArr(arr:Array):void{
			_acArr = arr;
			
//			_acArr = ["atkg1_1","atkg1_2","atkg1_1","atkg1_2","atkg1_1","atkg1_2"];
			//取第一招 攻击对象
			_isQishouGJ = true;
			isDiyizhao = true;
			/**当前招式*/
			_czhaoshi = _acArr.shift();
			if(_czhaoshi){
				AIAtk.getInstance().getObj(this._obj,this._targetObj,_czhaoshi.split("_")[1]*1);	
				this.atkDistance = 	AIAtk.getInstance().getGJDastance();
			}
			
			
			
			Engine.createEngine().push(this.action);
		}
		
		override protected function cbk(obj:Object=null):void
		{
			// TODO Auto Generated method stub
			super.cbk(obj);
		}
		
		override public function getAiObj(obj:Ibiont, targetObj:Ibiont):void
		{
			// TODO Auto Generated method stub
			super.getAiObj(obj, targetObj);
		}
		
		override protected function reSetAll():void
		{
			// TODO Auto Generated method stub
			super.reSetAll();
		}
		
		/**1.取到攻击招式列表数组      2.拿到收个攻击动作 取到攻击距离      3.跑近开始顺序攻击*/ 
		
		
		private var _isBeHited:Boolean = false;
		public function action():void{
			if(_obj.getIsBeHiting()||_obj.getIsBeHitOuting()){
				//被击破
				_isBeHited = true;
				return;
			}
			
			if(_isBeHited){
				if(AIMoveNear.moveNearX(this._obj,this._targetObj,this.atkDistance)){
					_obj.moveStop();
					this._isBeHited = false;
				}
				return;
			}
			
			
			/**如果是起手攻击 先走近攻击距离*/
			if(this._isQishouGJ){
				if(AIMoveNear.moveNearX(this._obj,this._targetObj,this.atkDistance)){
					_obj.moveStop();
					this._isQishouGJ = false;
					getAtk();
				}
				return;	
			}
			
			if(_isAction&&_obj.getPlayFrameOver()){
				_isAction = false;
				if(_acArr.length){
					_czhaoshi = _acArr.shift();
					isDiyizhao = false;
					getAtk();
					
				}else{
					_cbk();
					Engine.createEngine().pop(this.action);
				}
			}
			
			
		}
		
		protected function getAtk():void{
			if(_czhaoshi){
				AIAtk.getInstance().getObj(this._obj,this._targetObj,_czhaoshi.split("_")[1]*1);	
				AIAtk.getInstance().getAc();
				_isAction = true;
			}
		}
		
		
	}
}