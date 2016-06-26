/**
 * Created by newkrok on 26/06/16.
 */
package net.fpp.starlingtowerdefense.game.module.targetmanager
{
	import net.fpp.common.starling.module.AModule;
	import net.fpp.starlingtowerdefense.game.module.unitdistancecalculator.IUnitDistanceCalculatorModule;

	public class TargetManagerModule extends AModule implements ITargetManagerModule
	{
		private var _targetManagerModel:TargetManagerModel;

		public function TargetManagerModule()
		{
			this._targetManagerModel = this.createModel( TargetManagerModel ) as TargetManagerModel;
		}

		public function setUnitDistanceCalculator( value:IUnitDistanceCalculatorModule ):void
		{
			this._targetManagerModel.setUnitDistanceCalculatorModule( value );
		}

		public function onUpdate():void
		{
			this._targetManagerModel.calculateTargets();
		}

		override public function dispose():void
		{
			this._targetManagerModel = null;

			super.dispose();
		}
	}
}