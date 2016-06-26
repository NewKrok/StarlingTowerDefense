/**
 * Created by newkrok on 25/06/16.
 */
package net.fpp.starlingtowerdefense.game.module.linebar
{
	import net.fpp.common.geom.SimplePoint;
	import net.fpp.common.starling.module.AModule;
	import net.fpp.starlingtowerdefense.game.module.linebar.view.LineBarModuleView;

	public class LineBarModule extends AModule implements ILineBarModule
	{
		private var lineBarModel:LineBarModel;
		private var lineBarModuleView:LineBarModuleView;

		public function LineBarModule()
		{
			this.lineBarModel = this.createModel( LineBarModel ) as LineBarModel;

			this.lineBarModuleView = this.createModuleView( LineBarModuleView ) as LineBarModuleView;
		}

		public function setViewSize( value:SimplePoint ):void
		{
			this.lineBarModuleView.setSize( value );
		}

		public function setBackgroundColor( value:uint ):void
		{
			this.lineBarModuleView.setBackgroundColor( value );
		}

		public function setBackgroundAlpha( value:Number ):void
		{
			this.lineBarModuleView.setBackgroundAlpha( value );
		}

		public function setLineColor( value:uint ):void
		{
			this.lineBarModuleView.setLineColor( value );
		}

		public function setPercentage( value:Number ):void
		{
			this.lineBarModel.setPercentage( value );

			this.lineBarModuleView.updatePercentage();
		}
	}
}