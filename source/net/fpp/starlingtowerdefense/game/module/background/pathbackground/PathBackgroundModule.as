/**
 * Created by newkrok on 07/01/16.
 */
package net.fpp.starlingtowerdefense.game.module.background.pathbackground
{
	import flash.geom.Point;

	import net.fpp.common.starling.module.AModule;
	import net.fpp.common.util.jsonbitmapatlas.vo.BitmapDataVO;

	import net.fpp.starlingtowerdefense.game.module.background.pathbackground.view.PathBackgroundModuleView;

	public class PathBackgroundModule extends AModule implements IPathBackgroundModule
	{
		private var _backgroundModuleView:PathBackgroundModuleView;
		private var _backgroundModel:PathBackgroundModel;

		public function PathBackgroundModule():void
		{
			this._backgroundModuleView = this.createView( PathBackgroundModuleView ) as PathBackgroundModuleView;

			this._backgroundModel = this.createModel( PathBackgroundModel ) as PathBackgroundModel;
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