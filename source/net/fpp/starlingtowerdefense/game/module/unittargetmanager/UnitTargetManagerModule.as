/**
 * Created by newkrok on 26/06/16.
 */
package net.fpp.starlingtowerdefense.game.module.unittargetmanager
{
	import net.fpp.common.starling.module.AModule;
	import net.fpp.starlingtowerdefense.game.module.unitdistancecalculator.IUnitDistanceCalculatorModule;

	public class UnitTargetManagerModule extends AModule implements IUnitTargetManagerModule
	{
		private var _unitTargetManagerModel:UnitTargetManagerModel;

		public function UnitTargetManagerModule()
		{
			this._unitTargetManagerModel = this.createModel( UnitTargetManagerModel ) as UnitTargetManagerModel;
		}

		public function setUnitDistanceCalculator( value:IUnitDistanceCalculatorModule ):void
		{
			this._unitTargetManagerModel.setUnitDistanceCalculatorModule( value );
		}

		public function onUpdate():void
		{
			this._unitTargetManagerModel.calculateTargets();
		}

		override public function dispose():void
		{
			this._unitTargetManagerModel = null;

			super.dispose();
		}
	}
}