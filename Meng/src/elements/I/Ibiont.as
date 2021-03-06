/**
 *生物 动作接口 
 */
package elements.I
{
	import elements.role.RoleLive;
	import elements.role.RoleTili;
	
	import starling.display.DisplayObjectContainer;

	public interface Ibiont
	{
		function moveL():void;
		function moveR():void;
		function jump():void;
		function atk(nums:int = 0):void;
		function avoid():void;
		function getX():int;
		function getY():int;
		function gedang():void;
		function gedangOver():void;
		function getAlertDistance():int;
		function isDie():Boolean;
		function getStop():void;
		function getJNObjArr():Array;
		/**
		 * 
		 * @param vx  x方向冲力
		 * @param cy  y方向冲力
		 * @param gjl  攻击力
		 * 
		 */		
		function beHit(cjvx:Number,cjvy:Number,gjl:Number):void;
		function getIsBeHitOuting():Boolean;
		function getIsBeHiting():Boolean;
		
		/**停止移动*/
		function moveStop():void;
		/**
		 *动作是否完成 
		 * @param num 倒数第几帧
		 * @param isCZ 是否启动帧数控制
		 * @return 
		 * 
		 */			
		function getPlayFrameOver(num:int = 0,isCZ:Boolean = false):Boolean;
		
		function getWidth():Number;
		
		function theVelocityX(vx:Number):void;
		function theVelocityY(vy:Number):void;
		
		function theMaxLive():Number;
		function theCurLive():Number;
		function theMaxTili():Number;
		function theCurTili():Number;
		
		function getRoleLive():RoleLive;
		function getRoleTili():RoleTili;
		
		
		function getParent():DisplayObjectContainer;
		function getHeight():Number;
		function getThisChildIndex():int;
		
<<<<<<< HEAD
		function getTheDongzuo(label:String,DZcbkFNum:int,DZcbk:Function):void;
=======
		function getTheDongzuo(label:String,showTXFrameNum:int,DZcbk:Function,DZcanMoveFrame:int=1):void;
>>>>>>> origin/master
		function getCurrentLabel():String;
		
		function getScaleX():int;
		/**
		 * 跳帧
		 * @param acName 跳帧的名字 
		 */		
		function getAction(acName:String):void;
		
		function getEnemyArr():Array;
<<<<<<< HEAD
=======
		
		
		function bodyMcStop():void;
		function bodyMcPlay():void;
		
		function getShiyingTXScale():Number;
		
		function getYingzhi():int;
		
		function getJNArrObj():Object;
		
		/**
		 *取到延迟等级 
		 * @return 
		 * 
		 */		
		function getYanChiDengji():int;
		
		function getACStopNums(nums:int):void;
		
		function getGJL():int;
		
		/**
		 * 
		 * @param obj 攻击状态变化的OBJ内容
		 * 
		 */		
		function zhuangtaiChange(obj:Object):void;
		
		/**
		 *取到攻击技能组合类型 
		 * @return 
		 * 
		 */		
		function getGJType():String;
		
>>>>>>> origin/master
		
	}
}