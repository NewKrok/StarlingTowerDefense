/**
 * Created by newkrok on 20/03/16.
 */
package starlingtowerdefense.game.module.unitcontroller
{
	import net.fpp.starling.module.AModel;

	import starling.display.DisplayObjectContainer;

	import starlingtowerdefense.game.module.unit.IUnitModule;

	public class UnitControllerModel extends AModel
	{
		private var target:IUnitModule;
		private var _gameContainer:DisplayObjectContainer;

		public function UnitControllerModel()
		{
		}

		public function getTarget():IUnitModule
		{
			return this.target;
		}

		public function setTarget( value:IUnitModule ):void
		{
			this.target = value;
		}

		public function getGameContainer():DisplayObjectContainer
		{
			return this._gameContainer;
		}

		public function setGameContainer( value:DisplayObjectContainer ):void
		{
			this._gameContainer = value;
		}
	}
}