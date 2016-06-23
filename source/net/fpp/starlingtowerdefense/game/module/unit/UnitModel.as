/**
 * Created by newkrok on 14/02/16.
 */
package net.fpp.starlingtowerdefense.game.module.unit
{
	import net.fpp.common.starling.module.AModel;
	import net.fpp.starlingtowerdefense.game.module.unit.vo.UnitConfigVO;

	public class UnitModel extends AModel
	{
		private var _playerGroup:String;
		private var _target:IUnitModule;
		private var _lastAttackTime:Number = 0;
		private var _life:Number;
		private var _unitConfigVO:UnitConfigVO;

		public function getLife():Number
		{
			return this._life;
		}

		public function setLife( value:Number ):void
		{
			this._life = value;
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
	}
}