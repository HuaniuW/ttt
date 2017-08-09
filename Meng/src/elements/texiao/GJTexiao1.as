package elements.texiao
{
	import controls.GetHit;
	import controls.Globals;
	
	import elements.I.IHit;
	import elements.I.Ibiont;
	import elements.jineng.JinengVO;
	
	import game.engine.Engine;
	import game.mySound.MySoundPool;
	
	import lzm.starling.swf.display.SwfImage;
	

	public class GJTexiao1 extends Texiao implements IHit
	{
		public function GJTexiao1()
		{
			super();
		}
		
		
		protected var _framelabel:String;
		protected var _numshow:int;
		protected var _vx:Number;
		protected var _vy:Number;
		protected var _enemyArr:Array = [];
		protected var _jishinuums:int=0;
		protected var _chixushijian:int = 0;
		protected var jinengVO:JinengVO;
		protected var hitMc:SwfImage;
		
		/**
		 *技能对象 和攻击对象 
		 * @param obj
		 * @param role
		 * 
		 */		
		public function getSJObj(obj:Object,role:Ibiont):void{
			if(!this.jinengVO){
				this.jinengVO = new JinengVO();
			}
			jinengVO.getVO(obj);
			show(jinengVO.txMCName,role,jinengVO._x,jinengVO._y);
			getFrameShow(jinengVO.dongzuoLabel,jinengVO.cbkF);
			this._enemyArr = role.getEnemyArr();
		}
		
		
		/**
		 *显示 
		 * @param role  哪个角色的特效
		 * @param _x	
		 * @param _y	
		 * @param num	第几帧显示到角色的下一层
		 * 
		 */		
		override public function show(txMCName:String, role:Ibiont= null, _x:Number=0, _y:Number=0, numChangeCeng:int=100):void
		{
			this._txMCName = txMCName;
//			trace("_txname   "+_txMCName);
			this._numChangeCeng = numChangeCeng;
			
			
			this.__x = _x;
			this.__y = _y;
			
			this._role = role;
			this._parent = this._role.getParent();
			this._parent.addChild(this);
			
			
			if(__x == 1000){
				_isGensui = true;
				__x = 0;
			}
			
			
		}
		
		
		/**
		 * 
		 * @param framelabel 角色调用哪个动作
		 * @param showTXFrameNums 角色运动到哪一帧 丢特效
		 * @param enemyArr 敌人数组
		 * @param vx  
		 * @param vy 
		 */		
		public function getFrameShow(framelabel:String,showTXFrameNums:int,vx:Number=0,vy:Number=0):void{
			this._vx = vx;
			this._vy = vy;
			this._framelabel = framelabel;
			this._numshow = showTXFrameNums;
			this._role.getTheDongzuo(framelabel,showTXFrameNums,cbkF,jinengVO.DZcanMoveFrame);
			this._role.theVelocityX(-jinengVO.vx*_role.getScaleX());
			this._role.theVelocityY(-jinengVO.vy);
		}
		
		
		private function cbkF():void{
			if(!this._texiaoMc)this._texiaoMc = TXMcPool.getInstance().getTexiaoMc(_txMCName); 
//			trace("shiyingTXScale  "+this._role.getShiyingTXScale());
//			this._texiaoMc.scaleX = this._texiaoMc.scaleY = this._role.getShiyingTXScale(); 
			this._texiaoMc.gotoAndPlay(0);
			this.addChild(_texiaoMc);
			this.scaleX =  this._role.getScaleX();
			this.x = this._role.getX()-this.scaleX*this.__x;
			this.y = this._role.getY()+this._role.getHeight()*0.5+this.__y;
			Engine.createEngine().push(this.action);
		}
		
		/**
		 *????? 干嘛的？  防止重复判断？？？
		 */		
		private var numsss:int = 0;
		
		override protected function action():void
		{
			/**持续时间 ?>???*/
			if(this._chixushijian&&this._chixushijian!=0){
				return;
			}
			if(this._texiaoMc&&this._texiaoMc.getImage("hitMc")){
				numsss++;
				if(numsss>1)return;
				getAtked();
			}
			
			super.action();
			
		}
		
		
		/**
		 *是否击中 
		 * 
		 */		
		protected function getAtked():void{
			if(this._texiaoMc&&this._texiaoMc.getImage("hitMc")){
				hitMc = this._texiaoMc.getImage("hitMc");
				hitMc.width = this.jinengVO.atkjuli;
//				hitMc.scaleX*=_role.getShiyingTXScale(); 
//				hitMc.scaleY*=_role.getShiyingTXScale(); 
				hitMc.x = -100;
				MySoundPool.instance.getSound("atk",Globals.soundNums);
				for(var i:int in this._enemyArr){
					//					trace(((Globals.enemyArr[i]) as IHit).getBeHitMc().x);
					//					trace("是否碰撞      "+GetHit.getBDHit(this,Globals.enemyArr[i]));
					
					if(GetHit.getBDHit(this,this._enemyArr[i])){
						/**1.招式的移动  2.招式的攻击力  3.被攻击者的硬直  4.技能攻击破盾   5.击退 击飞 高硬直  6.击中光效   判断*/
						var vx:Number = this.jinengVO.vx;
						var cjvx:Number = this.jinengVO.cjvx;
						var cjvy:Number = this.jinengVO.cjvy;
						var gjl:Number = this.jinengVO.gjl;
						/**加入硬直对比 是自己被击退 还是敌人被击退----------------------------------------------------------------------------------------*/
						
						
						
						if(this.scaleX>0)cjvx*=-1;
						(this._enemyArr[i] as Ibiont).beHit(cjvx,cjvy,gjl);
					}
				}
			}
		}
		
		protected override function removeSelf():void{
			if(this.parent){
				this._texiaoMc.removeFromParent();
				numsss = 0;
				Engine.createEngine().pop(this.action);
				this.removeFromParent();
				TexiaoPool2.getInstance().getInPool(jinengVO.jnName,this);
				TXMcPool.getInstance().getInPool(this._txMCName,this._texiaoMc);
				this._texiaoMc = null;
			}
		}
		
		public function getBeHitMc():SwfImage
		{
			return null;
		}
		
		public function getJNObj():JinengVO
		{
			return this.jinengVO;
		}
		
		public function getHitMc():SwfImage
		{
			return hitMc;
		}
		
		public function getScaleX():int
		{
			return this.scaleX;
		}
		
		public function getX():int
		{
			return this.x;
		}
		
		public function getY():int
		{
			return this.y-this.height*4/5;
		}
		
		
	}
}