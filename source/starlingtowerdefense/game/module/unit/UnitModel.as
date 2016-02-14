/**
 * Created by newkrok on 14/02/16.
 */
package starlingtowerdefense.game.module.unit
{
	import net.fpp.starling.module.AModel;

	public class UnitModel extends AModel
	{
		private var _movementSpeed:Number = 200; // pixel / sec

		public function getMovementSpeed():Number
		{
			return this._movementSpeed;
		}

		public function setMovementSpeed( value:Number ):void
		{
			this._movementSpeed = value;
		}
	}
}