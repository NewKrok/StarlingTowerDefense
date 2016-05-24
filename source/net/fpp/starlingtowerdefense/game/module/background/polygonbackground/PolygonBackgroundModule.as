/**
 * Created by newkrok on 07/01/16.
 */
package net.fpp.starlingtowerdefense.game.module.background.polygonbackground
{
	import flash.geom.Point;

	import net.fpp.common.starling.module.AModule;
	import net.fpp.common.util.jsonbitmapatlas.vo.BitmapDataVO;

	import net.fpp.starlingtowerdefense.game.module.background.polygonbackground.view.PathBackgroundModuleView;

	public class PolygonBackgroundModule extends AModule implements IPolygonBackgroundModule
	{
		private var _backgroundModuleView:PathBackgroundModuleView;
		private var _backgroundModel:PolygonBackgroundModel;

		public function PolygonBackgroundModule():void
		{
			this._backgroundModuleView = this.createView( PathBackgroundModuleView ) as PathBackgroundModuleView;

			this._backgroundModel = this.createModel( PolygonBackgroundModel ) as PolygonBackgroundModel;
		}

		public function setTerrainInformations( terrains:Vector.<BitmapDataVO> ):void
		{
			this._backgroundModel.setTerrains( terrains );
		}

		public function setPathPolygons( pathPolygons:Vector.<Vector.<Point>> ):void
		{
			this._backgroundModel.pathPolygons = pathPolygons;

			this._backgroundModuleView.drawPathPolygons();
		}
	}
}