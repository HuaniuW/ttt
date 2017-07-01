package controls
{
	import elements.role.RoleO;
	
	public class Globals
	{
		public function Globals()
		{
		}
		
		//角色偏移量 修正角色与地图碰撞位置
		public static var numOffset:Number=0;
		
		
		
		public static var currentC:String = "spr_s_s1";
		
		
		public static var isKeyBorad:Boolean = true;
		public static var cx:Number = 0;
		public static var cy:Number = 0;
		
		public static var player:RoleO;
		
		
		public static var enemyArr:Array = [];
		
		
		public static var isDebug:Boolean = false;
		
		public static var soundNums:Number = 0.3;
		
	}
}