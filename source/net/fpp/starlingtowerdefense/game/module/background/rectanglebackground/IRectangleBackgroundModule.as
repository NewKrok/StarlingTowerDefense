/**
 * Created by newkrok on 19/06/16.
 */
package net.fpp.starlingtowerdefense.game.module.background.rectanglebackground
{
	import net.fpp.common.starling.module.IModule;
	import net.fpp.common.util.jsonbitmapatlas.vo.BitmapDataVO;
	import net.fpp.starlingtowerdefense.vo.RectangleBackgroundVO;

	public interface IRectangleBackgroundModule extends IModule
	{
		function setRectangleBackgroundVO( rectangleBackgroundVO:Vector.<RectangleBackgroundVO> ):void

		function setTerrainInformations( terrains:Vector.<BitmapDataVO> ):void
	}
}