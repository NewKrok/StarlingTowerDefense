/**
 * Created by newkrok on 23/06/16.
 */
package net.fpp.starlingtowerdefense.game.module.unitdistanceholder
{
	import net.fpp.common.starling.module.AModule;
	import net.fpp.starlingtowerdefense.game.module.unitdistancecalculator.IUnitDistanceCalculatorModule;

	public class UnitDistanceHolderModule extends AModule implements IUnitDistanceHolderModule
	{
		private var _unitDistanceHolderModel:UnitDistanceHolderModel;

		public function UnitDistanceHolderModule()
		{
			this._unitDistanceHolderModel = this.createModel( UnitDistanceHolderModel ) as UnitDistanceHolderModel;
		}

		public function setUnitDistanceCalculator( value:IUnitDistanceCalculatorModule ):void
		{
			this._unitDistanceHolderModel.setUnitDistanceCalculatorModule( value );
		}

		public function onUpdate():void
		{
			this._unitDistanceHolderModel.setUnitDistances();
		}

		public function getUpdateFrequency():int
		{
			return 5;
		}

		override public function dispose():void
		{
			this._unitDistanceHolderModel = null;

			super.dispose();
		}
	}
}