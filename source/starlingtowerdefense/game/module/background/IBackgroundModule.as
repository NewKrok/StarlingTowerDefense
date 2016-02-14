/**
 * Created by newkrok on 14/02/16.
 */
package starlingtowerdefense.game.module.background
{
	import flash.geom.Point;

	import net.fpp.starling.module.IModule;

	public interface IBackgroundModule extends IModule
	{
		function setPolygons( polygons:Vector.<Vector.<Point>> ):void
	}
}