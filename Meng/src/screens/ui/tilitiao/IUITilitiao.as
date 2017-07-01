package screens.ui.tilitiao
{
	public interface IUITilitiao
	{
		/**
		 *设置最大体力 
		 * @param num
		 * @return 
		 * 
		 */		
		function setMaxTili(num:Number):void;
		/**
		 *当前体力 
		 * @return 
		 * 
		 */		
		function getCurTili():Number;
		function tiliChange():void;
		/**
		 *体力条增长速度 
		 * @param num
		 * 
		 */		
		function tilizengzhangsudu(num:Number):void;
		/**
		 *是否锁定体力条 
		 * @param suoDing
		 * 
		 */		
		function tilisuoding(suoDing:Boolean):void;
		
		
		
		function rest(restNums:Number=40):void;
		
	}
}