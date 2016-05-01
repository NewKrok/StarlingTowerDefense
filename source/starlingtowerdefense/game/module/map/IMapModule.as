/**
 * Created by newkrok on 13/03/16.
 */
package starlingtowerdefense.game.module.map
{
	import net.fpp.util.pathfinding.vo.PathNodeVO;

	public interface IMapModule
	{
		function getMapNodes():Vector.<Vector.<PathNodeVO>>;
	}
}