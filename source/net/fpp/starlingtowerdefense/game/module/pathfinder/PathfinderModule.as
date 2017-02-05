/**
 * Created by newkrok on 04/02/17.
 */
package net.fpp.starlingtowerdefense.game.module.pathfinder
{
	import net.fpp.common.geom.SimplePoint;
	import net.fpp.common.starling.module.AModule;
	import net.fpp.common.util.GeomUtil;
	import net.fpp.common.util.pathfinding.astar.AStarUtil;
	import net.fpp.common.util.pathfinding.astar.vo.AStarPathRequestVO;
	import net.fpp.common.util.pathfinding.vo.PathVO;
	import net.fpp.starlingtowerdefense.game.module.map.IMapModule;
	import net.fpp.starlingtowerdefense.game.util.MapPositionUtil;

	public class PathfinderModule extends AModule implements IPathFinderModule
	{
		[Inject]
		public var mapModule:IMapModule;

		public function getPath( startPosition:SimplePoint, endPoint:SimplePoint ):PathVO
		{
			var pathVO:PathVO = new PathVO();

			var pathRequestVO:AStarPathRequestVO = new AStarPathRequestVO();
			pathRequestVO.startPosition = MapPositionUtil.changePositionToMapNodePoint( startPosition );
			pathRequestVO.endPosition = MapPositionUtil.changePositionToMapNodePoint( endPoint );
			pathRequestVO.mapNodes = mapModule.getMapNodes();

			if( pathRequestVO.mapNodes[ pathRequestVO.endPosition.x ][ pathRequestVO.endPosition.y ].isWalkable ||
					!GeomUtil.isSimplePointEqual( pathRequestVO.startPosition, pathRequestVO.endPosition )
			)
			{
				pathVO = AStarUtil.getPath( pathRequestVO ) || pathVO;

				if( pathVO && pathVO.path && pathVO.path.length > 0 )
				{
					pathVO.path = MapPositionUtil.changeMapNodePointVectorToPositionVector( pathVO.path );
				}
				else
				{
					pathVO.path = null;
				}
			}

			return pathVO;
		}
	}
}