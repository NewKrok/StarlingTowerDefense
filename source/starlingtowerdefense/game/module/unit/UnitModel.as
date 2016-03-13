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
		private var _damage:Number = 1;
		private var _damageDelay:Number = .2;
		private var _lastAttackTime:Number = 0;
		private var _attackSpeed:Number = 1;
		private var _maxLife:Number = 5;
		private var _life:Number = _maxLife;
		private var _target:IUnitModule;
		private var _playerGroup:String;

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

		public function getMaxLife():Number
		{
			return this._maxLife;
		}

		public function setMaxLife( value:Number ):void
		{
			this._maxLife = value;
		}

		public function getLife():Number
		{
			return this._life;
		}

		public function setLife( value:Number ):void
		{
			this._life = value;
		}

		public function getDamage():Number
		{
			return this._damage;
		}

		public function setDamage( value:Number ):void
		{
			this._damage = value;
		}

		public function getDamageDelay():Number
		{
			return this._damageDelay;
		}

		public function setDamageDelay( value:Number ):void
		{
			this._damageDelay = value;
		}

		public function getLastAttackTime():Number
		{
			return this._lastAttackTime;
		}

		public function setLastAttackTime( value:Number ):void
		{
			this._lastAttackTime = value;
		}

		public function getAttackSpeed():Number
		{
			return this._attackSpeed;
		}

		public function setAttackSpeed( value:Number ):void
		{
			this._attackSpeed = value;
		}

		public function getTarget():IUnitModule
		{
			return this._target;
		}

		public function setTarget( value:IUnitModule ):void
		{
			this._target = value;
		}

		public function getPlayerGroup():String
		{
			return this._playerGroup;
		}

		public function setPlayerGroup( value:String ):void
		{
			this._playerGroup = value;
		}
	}
}