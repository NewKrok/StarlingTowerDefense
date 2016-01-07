/**
 * Created by newkrok on 07/01/16.
 */
package starlingtowerdefense.game.module.unit
{
	import net.fpp.starling.module.AModule;

	import starlingtowerdefense.game.module.unit.view.UnitView;

	public class UnitModule extends AModule implements IUnitModule
	{
		public function UnitModule():void
		{
			this._view = new UnitView();
		}

		public function setPosition( x:Number, y:Number ):void
		{
			this._view.x = x;
			this._view.y = y;
		}
	}
}