package controls
{
	import elements.role.RoleO;
	
	import game.joyStick.MyGameStick;
	import game.joyStick.MyKeyBoardTest;
	
	
	public class GameControl
	{
		
		public function GameControl()
		{
		}
		
		public static var _obj:RoleO;
		
		/**
		 *键盘控制 
		 * @param obj
		 * 
		 */		
		public static function getControlObj(obj:RoleO):void{
			_obj = obj;
		}
		
		
		public static function upDate():void{
			if(_obj){
//				trace("?????????键盘控制");
				_obj.isRunLeft=MyKeyBoardTest.left;
				_obj.isRunRight=MyKeyBoardTest.right;
//				_obj.isAtk = MyKeyBoardTest.down;
//				_obj.isJump = MyKeyBoardTest.up;
				if(MyKeyBoardTest.up)_obj.jump();
//				if(!Globals.isDeBug)getStictColObj(_obj);
			}
		}
		
		/**
		 *虚拟摇杆控制 
		 * @param obj
		 * 
		 */		
		public static function getStictColObj(obj:RoleO):void{
//			trace("MyGameStick.PrevDirectionID> "+MyGameStick.PrevDirectionID);
			obj.isRunLeft 	= MyGameStick.PrevDirectionID == MyGameStick.LEFT ;
			obj.isRunRight	= MyGameStick.PrevDirectionID == MyGameStick.RIGHT;
			
		}
	}
}