/**
 * Created by newkrok on 23/06/16.
 */
package net.fpp.starlingtowerdefense.game.module.unitpushing
{
	import net.fpp.common.starling.module.IModule;
	import net.fpp.starlingtowerdefense.game.module.unitdistancecalculator.IUnitDistanceCalculatorModule;

	public interface IUnitDistanceHolderModule extends IModule
	{
		function setUnitDistanceCalculator( value:IUnitDistanceCalculatorModule ):void;

		function update():void;
	}
}