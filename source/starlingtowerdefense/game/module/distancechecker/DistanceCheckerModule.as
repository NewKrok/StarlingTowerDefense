/**
 * Created by newkrok on 21/03/16.
 */
package starlingtowerdefense.game.module.distancechecker
{
	import net.fpp.starling.module.AModule;

	import starlingtowerdefense.game.module.unit.IUnitModule;

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