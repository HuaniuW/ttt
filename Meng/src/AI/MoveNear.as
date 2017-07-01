package AI
{
	import elements.I.Ibiont;

	public class MoveNear
	{
		public function MoveNear()
		{
		}
		
		
		public static function moveNearX(obj:Ibiont,targetObj:Ibiont,nearDistance:int):Boolean{
			if(targetObj.isDie()||obj.isDie())return false;
//			trace("玩家    "+targetObj.getX()+"  怪   "+obj.getX());
			if(targetObj.getX() - obj.getX()>nearDistance){
				obj.moveR();
//				trace("右移动");
			}else if(targetObj.getX() - obj.getX()<-nearDistance){
				obj.moveL();
//				trace("左移动");
			}else{
				
//				trace("进入攻击范围    "+(targetObj.getX() - obj.getX()));
				if(targetObj.getX() - obj.getX()>0){
					obj.moveR();	
//					trace("RRRRRRRRRRRRRRRRRRRRRR");
				}else{
//					trace("LLLLLLLLLLLLLLLLLLLLLL");
					obj.moveL();	
				}
				
//				obj.moveStop();
				return true;
			}
			return false;	
		}
		
		
		
	}
}