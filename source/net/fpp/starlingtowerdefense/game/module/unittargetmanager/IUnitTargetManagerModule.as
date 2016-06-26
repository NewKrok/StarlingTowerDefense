/**
 * Created by newkrok on 26/06/16.
 */
package net.fpp.starlingtowerdefense.game.module.unittargetmanager
{
	import net.fpp.common.starling.module.IUpdatableModule;
	import net.fpp.starlingtowerdefense.game.module.unitdistancecalculator.IUnitDistanceCalculatorModule;

	public interface IUnitTargetManagerModule extends IUpdatableModule
	{
		function setUnitDistanceCalculator( value:IUnitDistanceCalculatorModule ):void;
	}
}