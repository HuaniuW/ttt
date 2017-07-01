package AI
{
	import AI.aiac.AIAtk;
	
	import elements.I.Ibiont;
	
	import game.engine.Engine;
	
	public class AIAcPlay extends AIBase
	{
		private var _acArr:Array = [];
		private var _isAction:Boolean = false;
		private var _isQishouGJ:Boolean = false;
		private var atkDistance:int = 180;
		
		
		public function AIAcPlay(obj:Ibiont, targetObj:Ibiont, cbk:Function)
		{
			super(obj, targetObj, cbk);
		}
		
		
		
		
		private static var _instance:AIAcPlay;
		public static function getInstance(obj:Ibiont, targetObj:Ibiont, cbk:Function):AIAcPlay{
			return new AIAcPlay(obj,targetObj,cbk);
		}
		
		
		private var _czhaoshi:String = "";
		/**
		 *取到攻击招式列表数组 
		 * @param arr
		 * 
		 */		
		public function getAcArr(arr:Array):void{
			_acArr = arr;
			
			_acArr = ["atk_1","atk_2","atk_1","atk_2","atk_1","atk_2"];
			//取第一招 攻击对象
			_isQishouGJ = true;
			_czhaoshi = _acArr.shift();
			if(_czhaoshi.split("_")[0]=="atk"){
				AIAtk.getInstance().getObj(this._obj,this._targetObj,_czhaoshi.split("_")[1]*1);	
				this.atkDistance = 	AIAtk.getInstance().getGJDastance();
			}
			
			
			
			Engine.createEngine().push(this.action);
		}
		
		override public function cbk(obj:Object=null):void
		{
			// TODO Auto Generated method stub
			super.cbk(obj);
		}
		
		override public function getAiObj(obj:Ibiont, targetObj:Ibiont):void
		{
			// TODO Auto Generated method stub
			super.getAiObj(obj, targetObj);
		}
		
		override public function reSetAll():void
		{
			// TODO Auto Generated method stub
			super.reSetAll();
		}
		
		/**1.取到攻击招式列表数组      2.拿到收个攻击动作 取到攻击距离      3.跑近开始顺序攻击*/ 
		
		
		private var _isBeHited:Boolean = false;
		public function action():void{
//			trace("_acArr.length: "+_acArr.length);
			if(_obj.getIsBeHiting()||_obj.getIsBeHitOuting()){
				//被击破
				_isBeHited = true;
				return;
			}
			
			if(_isBeHited){
				if(MoveNear.moveNearX(this._obj,this._targetObj,this.atkDistance)){
					_obj.moveStop();
					this._isBeHited = false;
				}
				return;
			}
			
			
			/**如果是起手攻击 先走近攻击距离*/
			if(this._isQishouGJ){
				if(MoveNear.moveNearX(this._obj,this._targetObj,this.atkDistance)){
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
					getAtk();
				}
			}else{
				
			}
			
			
		}
		
		private function getAtk():void{
			if(_czhaoshi.split("_")[0]=="atk"){
				AIAtk.getInstance().getObj(this._obj,this._targetObj,_czhaoshi.split("_")[1]*1);	
				AIAtk.getInstance().getAc();
				_isAction = true;
			}
		}
		
		
	}
}