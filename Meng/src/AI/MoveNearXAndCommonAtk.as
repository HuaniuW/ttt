/**
 *靠近X并普通攻击 
 */
package AI
{
	import elements.I.Ibiont;
	
	import game.engine.Engine;
	
	public class MoveNearXAndCommonAtk extends AIBase
	{
		public function MoveNearXAndCommonAtk(obj:Ibiont, targetObj:Ibiont, cbk:Function)
		{
			super(obj, targetObj, cbk);
		}
		
		public static function getInstance(obj:Ibiont,targetObj:Ibiont,cbk:Function):MoveNearXAndCommonAtk
		{
			return new MoveNearXAndCommonAtk(obj,targetObj,cbk);
		}
		
		public function getEvent():void{
			Engine.createEngine().push(this.action);
		}
		
		
		private var atkDistance:int = 180;
		
		private var isAtking:Boolean = false;
		
		public function action():void{
			//获取攻击范围
			//计算是否需要移动到攻击范围内
			if(MoveNear.moveNearX(this._obj,this._targetObj,this.atkDistance)){
				if(!isAtking){
					isAtking = true;
//					_obj.moveStop();
					if(!_obj.getIsAtking())_obj.atk();
					trace(">普通攻击!!");
				}else{
					if(_obj.getPlayFrameOver()){
						this.reSetAll();
						this._cbk();
					}
				}
			}
		}
		
		public override function reSetAll():void{
			isAtking = false;
			Engine.createEngine().pop(this.action);
		}
		
	}
}