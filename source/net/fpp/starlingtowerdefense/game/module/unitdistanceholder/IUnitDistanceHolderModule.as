/**
 * Created by newkrok on 23/06/16.
 */
package net.fpp.starlingtowerdefense.game.module.unitdistanceholder
{
	import net.fpp.common.starling.module.IUpdatableModule;
	import net.fpp.starlingtowerdefense.game.module.unitdistancecalculator.IUnitDistanceCalculatorModule;

	public interface IUnitDistanceHolderModule extends IUpdatableModule
	{
		function setUnitDistanceCalculator( value:IUnitDistanceCalculatorModule ):void;
	}
}