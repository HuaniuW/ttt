package elements.I
{
	public interface IAi
	{
		function getRandom():void;
		function getAiObj(obj:Ibiont,targetObj:Ibiont):void
		function cbk(obj:Object = null):void;
		function reSetAll():void;
	}
}