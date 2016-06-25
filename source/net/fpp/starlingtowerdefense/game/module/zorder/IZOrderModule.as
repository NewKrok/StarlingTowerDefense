/**
 * Created by newkrok on 23/06/16.
 */
package net.fpp.starlingtowerdefense.game.module.zorder
{
	import net.fpp.common.starling.module.IUpdatableModule;
	import net.fpp.starlingtowerdefense.game.module.unit.IUnitModule;

	import starling.display.DisplayObjectContainer;

	public interface IZOrderModule extends IUpdatableModule
	{
		function addUnit( value:IUnitModule ):void;

		function removeUnit( value:IUnitModule ):void;

		function setUnitContainer( value:DisplayObjectContainer ):void;
	}
}