/**
 *取到攻击距离  
 *  敌人数组 
 *  配置的特效
 *  配置文件
 * 
 * 
 *  怎么调  怎么用  攻击动作 这这里面调 
 * 
 * 
 * 
 * 
 *  
 */
package skill.atkSkill
{
	import elements.I.Ibiont;

	public class Atk
	{
		private var _obj:Ibiont;
		private var _enemyArr:Array;
		private var _acName:String;
		/**显示特效在第几帧出*/
		private var _acShowFrame:int = 0;
		
		public function Atk()
		{
			
		}
		
		public function getObj(obj:Ibiont,enemyArr:Array):void{
			_obj = obj;
			_enemyArr = enemyArr;
		}
		
		
		
	}
}