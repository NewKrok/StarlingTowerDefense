/**
 * Created by newkrok on 21/03/16.
 */
package net.fpp.starlingtowerdefense.game.module.unitdistancemanager
{
	import net.fpp.common.starling.module.AModule;
	import net.fpp.starlingtowerdefense.game.module.unit.IUnitModule;
	import net.fpp.starlingtowerdefense.game.module.unitdistancemanager.distanceaction.IUnitDistanceAction;

	public class UnitDistanceManagerModule extends AModule implements IUnitDistanceManagerModule
	{
		private var _unitDistanceCalculatorModel:UnitDistanceManagerModel;

		public function UnitDistanceManagerModule()
		{
			this._unitDistanceCalculatorModel = this.createModel( UnitDistanceManagerModel ) as UnitDistanceManagerModel;
		}

		public function onUpdate():void
		{
			this._unitDistanceCalculatorModel.calculateDistances();
		}

		public function getUpdateFrequency():int
		{
			return 100;
		}

		public function addDistanceAction( value:IUnitDistanceAction ):void
		{
			this._unitDistanceCalculatorModel.addDistanceAction( value );
		}

		public function addUnit( value:IUnitModule ):void
		{
			this._unitDistanceCalculatorModel.addUnit( value );
		}

		public function removeUnit( value:IUnitModule ):void
		{
			this._unitDistanceCalculatorModel.removeUnit( value );
		}

		override public function dispose():void
		{
			this._unitDistanceCalculatorModel = null;

			super.dispose();
		}
	}
}