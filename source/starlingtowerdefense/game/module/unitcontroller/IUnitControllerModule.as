/**
 * Created by newkrok on 20/03/16.
 */
package starlingtowerdefense.game.module.unitcontroller
{
	import net.fpp.starling.module.IModule;

	import starling.display.DisplayObjectContainer;

	import starlingtowerdefense.game.module.unit.IUnitModule;

	public interface IUnitControllerModule extends IModule
	{
		function setGameContainer( value:DisplayObjectContainer ):void

		function setTarget( value:IUnitModule ):void;

		function update():void;
	}
}