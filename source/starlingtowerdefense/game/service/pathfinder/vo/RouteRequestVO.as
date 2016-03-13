/**
 * Created by newkrok on 13/03/16.
 */
package starlingtowerdefense.game.service.pathfinder.vo
{
	import net.fpp.geom.SimplePoint;

	import starlingtowerdefense.game.module.map.vo.MapNodeVO;

	public class RouteRequestVO
	{
		public var startPosition:SimplePoint;
		public var endPosition:SimplePoint;
		public var mapNodes:Vector.<Vector.<MapNodeVO>>;
	}
}