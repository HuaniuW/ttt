package AI.aifas
{
	import flash.utils.ByteArray;
	
	import AI.actionAI.AIAcPlay;
	import AI.actionAI.AIAcPlay2;
	import AI.actionAI.AIStandPatrol;
	import AI.baseAI.AIMoveNear;
	
	import elements.I.IAi;
	import elements.I.Ibiont;
	import elements.jineng.IJiNeng;
	import elements.jineng.JNClassGet;
	import elements.jineng.JinengObj;
	import elements.jineng.JinengVO;
	import elements.texiao.TexiaoPool2;
	
	import game.engine.Engine;
	
	import lib.Clones;
	
	
	public class AIfn3 implements IAi
	{
		
		private var _obj:Ibiont;
		private var _targetObj:Ibiont;
		private var _isRandom:Boolean = false;
		private var _cJNArr:Array = [];
		/**
		 *攻击技能数组 
		 */		
		private var _JNObj:Object = {};
		
		private var standPatrol:AIStandPatrol;
		
		private var cjineng:IJiNeng;
		
		
		/**
		 * 取到攻击招式数组   
		 *   什么时候用t1 t2 t3
		 * 筛选攻击招技能  
		 * 		取到随机数 比对 脚本数组 取到技能  
		 * 取到攻击技能的攻击距离  
		 * 调用移动AI 接近目标 
		 * 调用攻击技能
		 * 
		 * 攻击组合 变招组合  怎么配招式  要单独编辑 概率 什么的 都要编辑  写进文本 {"t1":[{"jinengName":"","jilv1":10,"jilv2":30}],"t2":[],"t3":[]}
		 */		
		
		
		public function AIfn3()
		{
			
		}
		
		private static var _instance:AIfn3;
		
		public static function getInstance():AIfn3{
			return new AIfn3();
		}
		
		public function getAiObj(obj:Ibiont, targetObj:Ibiont):void
		{
			_obj = obj;
			_targetObj = targetObj;
			_JNObj = obj.getJNArrObj();
			_cJNArr = _JNObj["t1"];
			jichuAI();
			Engine.createEngine().push(random);
		}
		
		private function jichuAI():void
		{
			/**站着不动 警示站岗*/
			if(!standPatrol)standPatrol = AIStandPatrol.getInstance(_obj,_targetObj,cbk,_obj.getAlertDistance());
			standPatrol.action();
		}		
		
		private var JNAtkDistance:int = -1;
		private var isRandom:Boolean = false;
		private var aiAcPlay:AIAcPlay2;
		private var atkArrs:Array = [];
		private var isAction:Boolean = false;
		private function random():void{
			if(_obj.getIsBeHiting()||_obj.getIsBeHitOuting()){
				_obj.moveStop();
				isRandom = true;
				isAction = false;
				return;
			}
			
			if(isAction)return;
			
			if(!_obj.getPlayFrameOver()){
				isRandom = true;
				return;
			}
			
//			trace(_obj.getIsBeHiting()+"       "+_obj.getIsBeHitOuting());
			
			
//			trace("isRandom "+isRandom);
			
			
			if(isRandom){
				isRandom = false;
				var n:int = Math.random()*100;
				JNAtkDistance = getJNAndGetAtkDistance(n);
//				trace("random>筛选技能 取到技能攻击距离 "+JNAtkDistance+" n>  "+n);
			}
			
//			trace(JNAtkDistance);
			
			
			if(JNAtkDistance==-2){
				JNAtkDistance = -3;
				isAction = true;
				if(!aiAcPlay)aiAcPlay = new AIAcPlay2(_obj,_targetObj,cbk);
				aiAcPlay.getAcArr(atkArrs);
				return;
			}
			
			
			
			if(JNAtkDistance!=-1||JNAtkDistance != -3){
//				trace("找到技能 取到了攻击距离 开始移动"+JNAtkDistance);	
				if(AIMoveNear.moveNearX(this._obj,this._targetObj,JNAtkDistance)){
					JNAtkDistance = -1;
					isAction = true;
					_obj.moveStop();
					TexiaoPool2.getInstance().getOnTexiao(jinengVO.jnName,_obj,cbk);
				}
			}
			
		}
		
		private var jinengVO:JinengVO;
		private function getJNAndGetAtkDistance(n:int):int{
			for(var i:int in _cJNArr){
				if(n>=_cJNArr[i]["jilv1"]&&n<_cJNArr[i]["jilv2"]){
					/**如果是数组 进入第二种模式
					 * 分为单个技能攻击 和普通招式攻击
					 * */
					if(!jinengVO)jinengVO = new JinengVO();
					if(_cJNArr[i]["jinengName"] is Array){
						atkArrs = Clones.clone(_cJNArr[i]["jinengName"]);
//						trace("攻击数组  "+atkArrs);
						return -2;
					}else{
						jinengVO.getVO(JinengObj[_cJNArr[i]["jinengName"]]);
						return jinengVO.atkjuli;
					}
				}
			}
			return -1;
		}
		
		
		
		private function cbk():void{
			trace(">>>cbk");
			isAction = false;
			isRandom = true;
		}
	}
}