/**
 * Created by newkrok on 14/02/16.
 */
package starlingtowerdefense.game.module.unit
{
	import net.fpp.starling.module.AModel;

	public class UnitModel extends AModel
	{
		private var _movementSpeed:Number = 100; // pixel / sec
		private var _sizeRadius:Number = 25;

		public function getMovementSpeed():Number
		{
			return this._movementSpeed;
		}

		public function setMovementSpeed( value:Number ):void
		{
			this._movementSpeed = value;
		}

		public function getSizeRadius():Number
		{
			return this._sizeRadius;
		}

		public function setSizeRadius( value:Number ):void
		{
			this._sizeRadius = value;
		}
	}
}