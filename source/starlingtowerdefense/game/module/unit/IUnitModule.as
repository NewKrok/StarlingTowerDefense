/**
 * Created by newkrok on 07/01/16.
 */
package starlingtowerdefense.game.module.unit
{
	import net.fpp.starling.module.IModule;

	public interface IUnitModule extends IModule
	{
		function setPosition( x:Number, y:Number ):void;
	}
}