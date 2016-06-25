/**
 * Created by newkrok on 21/03/16.
 */
package net.fpp.starlingtowerdefense.game.module.unitdistancecalculator
{
	import net.fpp.common.starling.module.IUpdatableModule;
	import net.fpp.starlingtowerdefense.game.module.unit.IUnitModule;
	import net.fpp.starlingtowerdefense.game.module.unitdistancecalculator.vo.UnitDistanceVO;

	public interface IUnitDistanceCalculatorModule extends IUpdatableModule
	{
		function addUnit( value:IUnitModule ):void;

		function removeUnit( value:IUnitModule ):void;

		function getUnitDistanceVOs():Vector.<UnitDistanceVO>
	}
}