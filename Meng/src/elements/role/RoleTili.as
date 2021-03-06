package elements.role
{
	import game.engine.Engine;

	public class RoleTili
	{
		private var _maxTili:Number = 0;
		private var _curTili:Number = 0;
		
		public var _isSuoding:Boolean = false;
		private var zzsd:Number = 0.7;
		
		private var _restNum:Number = 0;
		private var _isRest:Boolean = false;
		private var _restNums:Number = 60;
		
		public var isTiliOver:Boolean = false;
		
		public function RoleTili()
		{
			init();
		}
		
		

		private function init():void
		{
			Engine.createEngine().push(action);
		}
		
<<<<<<< HEAD
=======
		/**
		 *重设 rest时间 
		 * @param restNums
		 * 
		 */		
>>>>>>> origin/master
		public function getXRest(restNums:Number = 60):void{
			this._restNum = 0;
			_restNums = restNums;
			this._isRest = true;
		}
		
		public function getDaRest():void{
			this._restNum = 0;
			_restNums = 100;
			this._isRest = true;
		}
		/**
		 *被击中后体力开始增长 
		 * 
		 */		
		public function getBeHitTiliStart():void{
			isTiliOver = false;
			_curTili++;
			if(_curTili>=_maxTili)_curTili = _maxTili;
			_restNum = 0;
//			_isRest = false;
		}
		
		public function isGetRest():Boolean{
			return _isRest;
		}
		
		private function action():void
		{
			isTiliOver = _curTili==0;
			if(this._isRest){
				this._restNum++;
				if(_restNum>=_restNums){
					this._isRest = false;
					this._restNum = 0;
				}
				return;
			}
			
			if(_isSuoding)return;
			
			if(_curTili>=_maxTili)_curTili = _maxTili;
			if(_curTili<_maxTili){
				_curTili+=zzsd;
			}
		}
		
		private var zzsdJL:Number = 0;
		/**
		 *重置体力增长速度 
		 * @param v
		 * 
		 */		
		public function setZZSD(v:Number):void{
			zzsdJL = zzsd;
			this.zzsd = v;
		}
		
		/**
		 *还原初始体力增长速度 
		 * 
		 */		
		public function HYZZSD():void{
			zzsd = zzsdJL;
		}
		
		/**
		 * 增加体力
		 * @param value 增加的体力值
		 * 
		 */		
		public function tiliAdd(value:Number):void{
			this.curTili +=value;
		}
		
		
		/**
		 *按最大体力值的%比增加体力 
		 * @param bi   0-1之间的数  
		 * 
		 */		
		public function tiliAddBi(bi:Number):void{
			this.curTili+= maxTili*bi;
		}
		
		
		public function get curTili():Number
		{
			return _curTili;
		}
		
		public function set curTili(value:Number):void
		{
			_curTili = value;
			if(_curTili>=_maxTili)_curTili = _maxTili;
			if(_curTili<=0){
				_curTili = 0;
				getDaRest();
			}
			
		}
		
		public function get maxTili():Number
		{
			return _maxTili;
		}
		
		public function set maxTili(value:Number):void
		{
			_maxTili = value;
		}
	}
}