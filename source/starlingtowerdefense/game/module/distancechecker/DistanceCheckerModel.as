/**
 * Created by newkrok on 21/03/16.
 */
package starlingtowerdefense.game.module.distancechecker
{
	import net.fpp.starling.module.AModel;

	import starlingtowerdefense.game.module.unit.IUnitModule;

	public class DistanceCheckerModel extends AModel
	{
		private var _units:Vector.<IUnitModule>;

		public function DistanceCheckerModel()
		{
			this._units = new <IUnitModule>[];
		}

		public function registerUnit( value:IUnitModule ):void
		{
			this._units.push( value );
		}
	}
}