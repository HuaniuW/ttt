package elements.I
{
	import nape.phys.Interactor;

	public interface IHitObj
	{
		function hitCbk(int:Interactor = null):void;
	}
}