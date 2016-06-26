/**
 * Created by newkrok on 26/06/16.
 */
package net.fpp.starlingtowerdefense.game.module.targetmanager
{
	import net.fpp.common.starling.module.IUpdatableModule;
	import net.fpp.starlingtowerdefense.game.module.unitdistancecalculator.IUnitDistanceCalculatorModule;

	public interface ITargetManagerModule extends IUpdatableModule
	{
		function setUnitDistanceCalculator( value:IUnitDistanceCalculatorModule ):void;
	}
}