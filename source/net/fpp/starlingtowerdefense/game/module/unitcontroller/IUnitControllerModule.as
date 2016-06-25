/**
 * Created by newkrok on 20/03/16.
 */
package net.fpp.starlingtowerdefense.game.module.unitcontroller
{
	import net.fpp.common.starling.module.IUpdatableModule;
	import net.fpp.starlingtowerdefense.game.module.unit.IUnitModule;

	import starling.display.DisplayObjectContainer;

	public interface IUnitControllerModule extends IUpdatableModule
	{
		function setGameContainer( value:DisplayObjectContainer ):void

		function setTarget( value:IUnitModule ):void;
	}
}