/**
 * Created by newkrok on 21/03/16.
 */
package net.fpp.starlingtowerdefense.game.module.distancechecker
{
	import net.fpp.common.starling.module.AModule;

	import net.fpp.starlingtowerdefense.game.module.unit.IUnitModule;

	public class DistanceCheckerModule extends AModule implements IDistanceCheckerModule
	{
		private var _distanceCheckerModel:DistanceCheckerModel;

		public function DistanceCheckerModule()
		{
			this._distanceCheckerModel = this.createModel( DistanceCheckerModel ) as DistanceCheckerModel;
		}

		public function update():void
		{

		}

		public function registerUnit( value:IUnitModule ):void
		{
			this._distanceCheckerModel.registerUnit( value );
		}
	}
}