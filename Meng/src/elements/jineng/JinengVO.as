/**
 *技能VO 
 */
package elements.jineng
{
	public class JinengVO
	{
		public function JinengVO()
		{
		}
		
		public static function getJinengVO():JinengVO{
			return new JinengVO();
		}
		
		/**
		 *技能的名字 用来取技能对象 Obj 
		 */		
		public var jnName:String;
		
		/**
		 *技能用到的特效名字 
		 */		
		public var txMCName:String;
		
		/**
		 *技能用到的 调用类 的名字 
		 */		
		public var className:String;
		
		/**
		 *第几帧返回调用函数 
		 */		
		public var cbkF:int;
		
		/**
		 *倒数第几帧 可以关闭控制 使角色可以做其他动作 
		 */		
		public var DZcanMoveFrame:int;
		
		/**
		 *调用特效时 调用的帧标签 
		 */		
		public var dongzuoLabel:String;
		
		/**
		 *给予角色的速度 
		 */		
		public var vx:int;
		
		public var vy:int;
		
		/**
		 *技能冲击速度 击退速度 
		 */		
		public var cjvx:int;
		public var cjvy:int;
		
		/**
		 *换层的帧 多少帧 特效移动到 role的下一层 
		 */		
		public var huancengNum:int;
		
		/**
		 *控制 技能特效 x 
		 */		
		public var _x:int;
		public var _y:int;
		
		/**
		 *攻击块的长度 
		 */		
		public var atkjuli:int;
		
		/**
		 *攻击块偏移的位置 
		 */		
		public var gjkpy:int;
		
		/**
		 *攻击力 
		 */		
		public var gjl:int;
		
		/**
		 *消耗体力 
		 */		
		public var xhtl:int;
		
		/**
		 *消耗魂 
		 */		
		public var xhh:int;
		
		/**
		 *技能的声音 
		 */		
		public var JNSound:String = "";
		
		/**
		 *技能图标 
		 */		
		public var JNIcon:String = "";
		
		/**
		 *技能类型 用来判断是什么类型 技能 用来做特殊处理  
		 * 比如：硬直的处理 
		 */		
		public var JNType:String = "";
		
		/**
		 *起手延迟  动作起手的时候的延迟停顿 给出反应时间 
		 */		
		public var qishouyanchi:int = 0;
		
		
		
		public function getVO(obj:Object):void{
			JNIcon = jnName = obj["jnName"];
			txMCName = obj["txMCName"];
			className = obj["className"];
			cbkF = obj["cbkF"];
			DZcanMoveFrame = obj["DZcanMoveFrame"];
			dongzuoLabel = obj["dongzuoLabel"];
			vx = obj["vx"];
			vy = obj["vy"];
			cjvx = obj["cjvx"];
			cjvy = obj["cjvy"];
			huancengNum = obj["huancengNum"];
			_x = obj["_x"];
			_y = obj["_y"];
			atkjuli = obj["atkjuli"];
			gjkpy = obj["gjkpy"];
			gjl = obj["gjl"];
			xhtl = obj["xhtl"];
			xhh = obj["xhh"];
			JNSound = obj["JNSound"];
			JNType = obj["JNType"];
			qishouyanchi = obj["qishouyanchi"];
		}
	}
}