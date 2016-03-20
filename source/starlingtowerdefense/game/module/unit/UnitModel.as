/**
 * Created by newkrok on 14/02/16.
 */
package starlingtowerdefense.game.module.unit
{
	import net.fpp.starling.module.AModel;

	public class UnitModel extends AModel
	{
		private var _playerGroup:String;
		private var _target:IUnitModule;
		private var _lastAttackTime:Number = 0;
		private var _life:Number;

		private var _movementSpeed:Number;
		private var _sizeRadius:Number;
		private var _minDamage:Number;
		private var _maxDamage:Number;
		private var _damageDelay:Number;
		private var _attackSpeed:Number;
		private var _maxLife:Number;
		private var _areaDamage:Number;
		private var _areaDamageSize:Number;
		private var _armor:Number;
		private var _armorType:String;
		private var _attackRadius:Number;
		private var _attackType:String;
		private var _blockChance:Number;
		private var _criticalHitChance:Number;
		private var _criticalHitDamageMultiple:Number;
		private var _lifeRegeneration:Number;
		private var _unitDetectionRadius:Number;

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

		public function getMinDamage():Number
		{
			return this._minDamage;
		}

		public function setMinDamage( value:Number ):void
		{
			this._minDamage = value;
		}

		public function getMaxDamage():Number
		{
			return this._maxDamage;
		}

		public function setMaxDamage( value:Number ):void
		{
			this._maxDamage = value;
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

		public function getAreaDamage():Number
		{
			return this._areaDamage;
		}

		public function setAreaDamage( value:Number ):void
		{
			this._areaDamage = value;
		}

		public function getAreaDamageSize():Number
		{
			return this._areaDamageSize;
		}

		public function setAreaDamageSize( value:Number ):void
		{
			this._areaDamageSize = value;
		}

		public function getArmor():Number
		{
			return this._armor;
		}

		public function setArmor( value:Number ):void
		{
			this._armor = value;
		}

		public function getArmorType():String
		{
			return this._armorType;
		}

		public function setArmorType( value:String ):void
		{
			this._armorType = value;
		}

		public function getAttackRadius():Number
		{
			return this._attackRadius;
		}

		public function setAttackRadius( value:Number ):void
		{
			this._attackRadius = value;
		}

		public function getAttackType():String
		{
			return this._attackType;
		}

		public function setAttackType( value:String ):void
		{
			this._attackType = value;
		}

		public function getBlockChance():Number
		{
			return this._blockChance;
		}

		public function setBlockChance( value:Number ):void
		{
			this._blockChance = value;
		}

		public function getCriticalHitChance():Number
		{
			return this._criticalHitChance;
		}

		public function setCriticalHitChance( value:Number ):void
		{
			this._criticalHitChance = value;
		}

		public function getCriticalHitDamageMultiple():Number
		{
			return this._criticalHitDamageMultiple;
		}

		public function setCriticalHitDamageMultiple( value:Number ):void
		{
			this._criticalHitDamageMultiple = value;
		}

		public function getLifeRegeneration():Number
		{
			return this._lifeRegeneration;
		}

		public function setLifeRegeneration( value:Number ):void
		{
			this._lifeRegeneration = value;
		}

		public function getUnitDetectionRadius():Number
		{
			return this._unitDetectionRadius;
		}

		public function setUnitDetectionRadius( value:Number ):void
		{
			this._unitDetectionRadius = value;
		}
	}
}