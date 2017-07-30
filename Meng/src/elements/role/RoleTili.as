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
		
		public function getBeHitTili():void{
			isTiliOver = false;
			_curTili++;
			_restNum = 0;
//			_isRest = false;
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