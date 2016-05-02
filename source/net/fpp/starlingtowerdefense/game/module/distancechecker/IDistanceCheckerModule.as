/**
 * Created by newkrok on 21/03/16.
 */
package net.fpp.starlingtowerdefense.game.module.distancechecker
{
	import net.fpp.starlingtowerdefense.game.module.unit.IUnitModule;

	public interface IDistanceCheckerModule
	{
		function update():void;

		function registerUnit( value:IUnitModule ):void;
	}
}