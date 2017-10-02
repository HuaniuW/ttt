package elements.role
{
	import controls.GetHit;
	import controls.Globals;
	
	import elements.I.IHit;
	import elements.I.Ibiont;
	import elements.texiao.TexiaoPool;
	
	import game.mySound.MySoundPool;
	
	import lzm.starling.swf.display.SwfImage;
	import lzm.starling.swf.display.SwfMovieClip;

	public class GetAtked
	{
		public function GetAtked()
		{
		}
		
<<<<<<< HEAD
		private var _bodyMc;
		
=======
>>>>>>> origin/master
		/**
		 *是否击中 
		 * this IHit
		 * this.scaleX
		 * texiaoMc
		 * _role
		 * enemyArr
		 * jinengVO
		 * 
		 */		
		public static function getAtked(hitObj:IHit,hitObjScaleX:int,_texiaoMc:SwfMovieClip):void{
			if(_texiaoMc&&_texiaoMc.getImage("hitMc")){
				hitMc = _texiaoMc.getImage("hitMc");
				hitMc.width = jinengVO.atkjuli;
				//				hitMc.scaleX*=_role.getShiyingTXScale(); 
				//				hitMc.scaleY*=_role.getShiyingTXScale(); 
				hitMc.x = -100;
				MySoundPool.instance.getSound(jinengVO.JNSound,Globals.soundNums);
				for(var i:int in _enemyArr){
					//					trace(((Globals.enemyArr[i]) as IHit).getBeHitMc().x);
					//					trace("是否碰撞      "+GetHit.getBDHit(this,Globals.enemyArr[i]));
					
					if(GetHit.getBDHit(this,_enemyArr[i])){
						/**1.招式的移动  2.招式的攻击力  3.被攻击者的硬直  4.技能攻击破盾   5.击退 击飞 高硬直  6.击中光效   判断*/
						var vx:Number = jinengVO.vx;
						var cjvx:Number = jinengVO.cjvx;
						var cjvy:Number = jinengVO.cjvy;
						var gjl:Number = jinengVO.gjl;
						/**加入硬直对比 是自己被击退 还是敌人被击退----------------------------------------------------------------------------------------*/
						/**自己硬直*/
						var zjyingzhi:int = _role.getYingzhi();
						/**敌人硬直*/
						var dryingzhi:int = (_enemyArr[i] as Ibiont).getYingzhi();
						
						
						if(this.scaleX>0)cjvx*=-1;
						(_enemyArr[i] as Ibiont).beHit(cjvx,cjvy,gjl);
					}
				}
			}
		}
	}
}