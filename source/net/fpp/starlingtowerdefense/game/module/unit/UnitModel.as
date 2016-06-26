/**
 * Created by newkrok on 14/02/16.
 */
package net.fpp.starlingtowerdefense.game.module.unit
{
	import com.greensock.TweenLite;

	import net.fpp.common.geom.SimplePoint;

	import net.fpp.common.starling.module.AModel;
	import net.fpp.starlingtowerdefense.game.module.unit.events.UnitModelEvent;
	import net.fpp.starlingtowerdefense.game.module.unit.vo.UnitConfigVO;

	public class UnitModel extends AModel
	{
		private var _playerGroup:String;
		private var _target:IUnitModule;
		private var _lastAttackTime:Number = 0;
		private var _life:Number
		private var _mana:Number;
		private var _unitConfigVO:UnitConfigVO;
		public var damageDelayTween:TweenLite;
		private var _lastRegenerateTime:Number = new Date().time;
		private var _lastPositionBeforeFight:SimplePoint;

		public function getLife():Number
		{
			return this._life;
		}

		public function getLifePercentage():Number
		{
			return Math.max( this._life / this._unitConfigVO.maxLife, 0 );
		}

		public function setLife( value:Number ):void
		{
			this._life = Math.min( value, this._unitConfigVO.maxLife );

			this.dispatchEvent( new UnitModelEvent( UnitModelEvent.LIFE_CHANGED ) );
		}

		public function getMana():Number
		{
			return this._mana;
		}

		public function getManaPercentage():Number
		{
			return Math.max( this._mana / this._unitConfigVO.maxMana, 0 );
		}

		public function setMana( value:Number ):void
		{
			this._mana = Math.min( value, this._unitConfigVO.maxMana );

			this.dispatchEvent( new UnitModelEvent( UnitModelEvent.MANA_CHANGED ) );
		}

		public function regenerateLifeAndMana():void
		{
			if( this._life < this._unitConfigVO.maxLife )
			{
				this.regenerateLife();
			}

			if( this._unitConfigVO.maxMana > 0 && this._mana < this._unitConfigVO.maxMana )
			{
				this.regenerateMana();
			}

			this._lastRegenerateTime = new Date().time;
		}

		private function regenerateLife():void
		{
			var now:Number = new Date().time;

			var newLifeValue:Number = this._life;

			newLifeValue += ( now - this._lastRegenerateTime ) / 1000 * this._unitConfigVO.lifeRegeneration;

			this.setLife( newLifeValue );
		}

		private function regenerateMana():void
		{
			var now:Number = new Date().time;

			var newManaValue:Number = this._mana;

			newManaValue += ( now - this._lastRegenerateTime ) / 1000 * this._unitConfigVO.manaRegeneration;

			this.setMana( newManaValue );
		}

		public function getLastAttackTime():Number
		{
			return this._lastAttackTime;
		}

		public function setLastAttackTime( value:Number ):void
		{
			this._lastAttackTime = value;
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

		public function setUnitConfigVO( value:UnitConfigVO ):void
		{
			this._unitConfigVO = value;
		}

		public function getUnitConfigVO():UnitConfigVO
		{
			return this._unitConfigVO;
		}

		public function setLastPositionBeforeFight( value:SimplePoint ):void
		{
			this._lastPositionBeforeFight = value;
		}

		public function getLastPositionBeforeFight():SimplePoint
		{
			return this._lastPositionBeforeFight;
		}
	}
}