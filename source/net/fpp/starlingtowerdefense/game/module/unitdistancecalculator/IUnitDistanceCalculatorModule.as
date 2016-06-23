/**
 * Created by newkrok on 21/03/16.
 */
package net.fpp.starlingtowerdefense.game.module.unitdistancecalculator
{
	import net.fpp.common.starling.module.IModule;
	import net.fpp.starlingtowerdefense.game.module.unit.IUnitModule;
	import net.fpp.starlingtowerdefense.game.module.unitdistancecalculator.vo.UnitDistanceVO;

	public interface IUnitDistanceCalculatorModule extends IModule
	{
		function update():void;

		function addUnit( value:IUnitModule ):void;

		function removeUnit( value:IUnitModule ):void;

		function getUnitDistanceVOs():Vector.<UnitDistanceVO>
	}
}