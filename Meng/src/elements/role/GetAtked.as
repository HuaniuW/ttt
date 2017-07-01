package elements.role
{
	import controls.GetHit;
	import controls.Globals;
	
	import elements.I.Ibiont;
	import elements.texiao.TexiaoPool;
	
	import game.mySound.MySoundPool;
	
	import lzm.starling.swf.display.SwfImage;

	public class GetAtked
	{
		public function GetAtked()
		{
		}
		
		
		/**
		 *是否击中 
		 * 
		 */		
		protected function getAtked(hitMc:SwfImage,_w:Number,_h:Number,enemyArr:Array,gongjizhaoshiObj:Object,soundName:String):void{
			if(this._bodyMc.getImage("hitMc")){
				
				this._bodyMc.getImage("hitMc").width = this.gongjizhaoshiArr[this.cgjNum-1]["atkjuli"]
				
				TexiaoPool.getInstance().getOnTexiao(this.gongjizhaoshiArr[this.cgjNum-1]["texiao"],this,this.gongjizhaoshiArr[this.cgjNum-1]["txpy"]);
				
				MySoundPool.instance.getSound("atk",Globals.soundNums);
				for(var i:int in this.enemyArr){
					//					trace(((Globals.enemyArr[i]) as IHit).getBeHitMc().x);
					//					trace("是否碰撞      "+GetHit.getBDHit(this,Globals.enemyArr[i]));
					
					if(GetHit.getBDHit(this,this.enemyArr[i])){
						if(isJumpAtking){
							this.body.velocity.y = 0;
							this.body.velocity.y-=800;
						}
						
						/**1.招式的移动  2.招式的攻击力  3.被攻击者的硬直  4.技能攻击破盾   5.击退 击飞 高硬直  6.击中光效   判断*/
						var vx:Number = this.gongjizhaoshiArr[this.cgjNum-1]["vx"];
						var cy:Number = this.gongjizhaoshiArr[this.cgjNum-1]["cy"];
						var gjl:Number = this.gongjili+this.gongjizhaoshiArr[this.cgjNum-1]["gjl"];
						
						if(this.getScaleX()>0)vx*=-1;
						
						(this.enemyArr[i] as Ibiont).beHit(vx,cy,gjl);
					}
				}
			}
		}
	}
}