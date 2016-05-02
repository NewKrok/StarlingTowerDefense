/**
 * Created by newkrok on 14/02/16.
 */
package net.fpp.starlingtowerdefense.game.module.background.pathbackground
{
	import flash.geom.Point;

	import net.fpp.common.starling.module.IModule;
	import net.fpp.common.util.jsonbitmapatlas.vo.BitmapDataVO;

	public interface IPathBackgroundModule extends IModule
	{
		function setPathPolygons( polygons:Vector.<Vector.<Point>> ):void

		function setTerrainInformations( terrains:Vector.<BitmapDataVO> ):void
	}
}