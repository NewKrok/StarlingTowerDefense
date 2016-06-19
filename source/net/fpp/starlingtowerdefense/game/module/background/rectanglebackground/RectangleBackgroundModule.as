/**
 * Created by newkrok on 19/06/16.
 */
package net.fpp.starlingtowerdefense.game.module.background.rectanglebackground
{
	import net.fpp.common.starling.module.AModule;
	import net.fpp.common.util.jsonbitmapatlas.vo.BitmapDataVO;
	import net.fpp.starlingtowerdefense.game.module.background.rectanglebackground.view.RectangleBackgroundModuleView;
	import net.fpp.starlingtowerdefense.vo.RectangleBackgroundVO;

	public class RectangleBackgroundModule extends AModule implements IRectangleBackgroundModule
	{
		private var _backgroundModuleView:RectangleBackgroundModuleView;
		private var _backgroundModel:RectangleBackgroundModel;

		public function RectangleBackgroundModule():void
		{
			this._backgroundModuleView = this.createView( RectangleBackgroundModuleView ) as RectangleBackgroundModuleView;

			this._backgroundModel = this.createModel( RectangleBackgroundModel ) as RectangleBackgroundModel;
		}

		public function setTerrainInformations( terrains:Vector.<BitmapDataVO> ):void
		{
			this._backgroundModel.setTerrains( terrains );
		}

		public function setRectangleBackgroundVO( rectangleBackgroundVO:Vector.<RectangleBackgroundVO> ):void
		{
			this._backgroundModel.rectangleBackgroundVOs = rectangleBackgroundVO;

			this._backgroundModuleView.drawRectangleBackgrounds();
		}
	}
}