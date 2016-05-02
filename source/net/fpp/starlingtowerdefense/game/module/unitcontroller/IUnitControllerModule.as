/**
 * Created by newkrok on 20/03/16.
 */
package net.fpp.starlingtowerdefense.game.module.unitcontroller
{
	import net.fpp.common.starling.module.IModule;

	import starling.display.DisplayObjectContainer;

	import net.fpp.starlingtowerdefense.game.module.unit.IUnitModule;

	public interface IUnitControllerModule extends IModule
	{
		function setGameContainer( value:DisplayObjectContainer ):void

		function setTarget( value:IUnitModule ):void;

		function update():void;
	}
}