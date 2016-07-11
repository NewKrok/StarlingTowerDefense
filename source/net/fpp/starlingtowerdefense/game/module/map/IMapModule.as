/**
 * Created by newkrok on 13/03/16.
 */
package net.fpp.starlingtowerdefense.game.module.map
{
	import net.fpp.common.util.pathfinding.astar.vo.AStarNodeVO;

	public interface IMapModule
	{
		function getMapNodes():Vector.<Vector.<AStarNodeVO>>;
	}
}