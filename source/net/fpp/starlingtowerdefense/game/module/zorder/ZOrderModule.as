/**
 * Created by newkrok on 23/06/16.
 */
package net.fpp.starlingtowerdefense.game.module.zorder
{
	import net.fpp.common.starling.module.AModule;
	import net.fpp.starlingtowerdefense.game.module.unit.IUnitModule;

	import starling.display.DisplayObjectContainer;

	public class ZOrderModule extends AModule implements IZOrderModule
	{
		private var _zOrderModel:ZOrderModel;

		public function ZOrderModule()
		{
			this._zOrderModel = this.createModel( ZOrderModel ) as ZOrderModel;
		}

		public function setUnitContainer( value:DisplayObjectContainer ):void
		{
			this._zOrderModel.setUnitContainer( value );
		}

		public function update():void
		{
			this._zOrderModel.updateZOrder();
		}

		public function addUnit( value:IUnitModule ):void
		{
			this._zOrderModel.addUnit( value );
		}

		public function removeUnit( value:IUnitModule ):void
		{
			this._zOrderModel.removeUnit( value );
		}

		override public function dispose():void
		{
			this._zOrderModel.dispose();
			this._zOrderModel = null;

			super.dispose();
		}
	}
}