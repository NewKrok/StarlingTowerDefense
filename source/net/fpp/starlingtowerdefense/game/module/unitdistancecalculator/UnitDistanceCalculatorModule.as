/**
 * Created by newkrok on 21/03/16.
 */
package net.fpp.starlingtowerdefense.game.module.unitdistancecalculator
{
	import net.fpp.common.starling.module.AModule;

	import net.fpp.starlingtowerdefense.game.module.unit.IUnitModule;
	import net.fpp.starlingtowerdefense.game.module.unitdistancecalculator.vo.UnitDistanceVO;

	public class UnitDistanceCalculatorModule extends AModule implements IUnitDistanceCalculatorModule
	{
		private var _unitDistanceCalculatorModel:UnitDistanceCalculatorModel;

		public function UnitDistanceCalculatorModule()
		{
			this._unitDistanceCalculatorModel = this.createModel( UnitDistanceCalculatorModel ) as UnitDistanceCalculatorModel;
		}

		public function onUpdate():void
		{
			this._unitDistanceCalculatorModel.calculateDistances();
		}

		public function addUnit( value:IUnitModule ):void
		{
			this._unitDistanceCalculatorModel.addUnit( value );
		}

		public function removeUnit( value:IUnitModule ):void
		{
			this._unitDistanceCalculatorModel.removeUnit( value );
		}

		public function getUnitDistanceVOs():Vector.<UnitDistanceVO>
		{
			return this._unitDistanceCalculatorModel.getUnitDistanceVOs();
		}

		override public function dispose():void
		{
			this._unitDistanceCalculatorModel = null;

			super.dispose();
		}
	}
}