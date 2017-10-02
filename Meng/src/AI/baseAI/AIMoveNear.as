package AI.baseAI
{
	import elements.I.Ibiont;

	public class AIMoveNear
	{
		public function AIMoveNear()
		{
		}
		
		
		public static function moveNearX(obj:Ibiont,targetObj:Ibiont,nearDistance:int):Boolean{
			if(targetObj.isDie()||obj.isDie())return false;
			if(targetObj.getX() - obj.getX()>nearDistance){
				obj.moveR();
//				trace("右移动");
			}else if(targetObj.getX() - obj.getX()<-nearDistance){
				obj.moveL();
//				trace("左移动");
			}else{
				if(targetObj.getX() - obj.getX()>0){
//					trace("R");
					obj.moveR();	
				}else{
//					trace("L");
					obj.moveL();	
				}
				return true;
			}
			return false;	
		}
		
		
		
	}
}