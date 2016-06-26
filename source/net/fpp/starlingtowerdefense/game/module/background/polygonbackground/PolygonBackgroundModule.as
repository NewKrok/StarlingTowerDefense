/**
 * Created by newkrok on 07/01/16.
 */
package net.fpp.starlingtowerdefense.game.module.background.polygonbackground
{
	import net.fpp.common.starling.module.AModule;
	import net.fpp.common.util.jsonbitmapatlas.vo.BitmapDataVO;
	import net.fpp.starlingtowerdefense.game.module.background.polygonbackground.view.PathBackgroundModuleView;
	import net.fpp.starlingtowerdefense.vo.PolygonBackgroundVO;

	public class PolygonBackgroundModule extends AModule implements IPolygonBackgroundModule
	{
		private var _backgroundModuleView:PathBackgroundModuleView;
		private var _backgroundModel:PolygonBackgroundModel;

		public function PolygonBackgroundModule():void
		{
			this._backgroundModuleView = this.createModuleView( PathBackgroundModuleView ) as PathBackgroundModuleView;

			this._backgroundModel = this.createModel( PolygonBackgroundModel ) as PolygonBackgroundModel;
		}

		public function setTerrainInformations( terrains:Vector.<BitmapDataVO> ):void
		{
			this._backgroundModel.setTerrains( terrains );
		}

		public function setPolygonBackgroundVO( polygonBackroundVOs:Vector.<PolygonBackgroundVO> ):void
		{
			this._backgroundModel.polygonBackroundVOs = polygonBackroundVOs;

			this._backgroundModuleView.drawPathPolygons();
		}
	}
}