/**
 * Created by newkrok on 07/01/16.
 */
package starlingtowerdefense.game.module.background
{
	import flash.geom.Point;

	import net.fpp.starling.module.AModule;

	import starlingtowerdefense.game.module.background.view.BackgroundModuleView;

	public class BackgroundModule extends AModule implements IBackgroundModule
	{
		private var _backgroundModuleView:BackgroundModuleView;
		private var _backgroundModel:BackgroundModel;

		public function BackgroundModule():void
		{
			this._backgroundModuleView = this.createView( BackgroundModuleView ) as BackgroundModuleView;

			this._backgroundModel = this.createModel( BackgroundModel ) as BackgroundModel;
		}

		public function setPolygons( polygons:Vector.<Vector.<Point>> ):void
		{
			this._backgroundModel.setPolygons( polygons );

			this._backgroundModuleView.drawPolygons();
		}
	}
}