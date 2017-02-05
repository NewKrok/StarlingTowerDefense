/**
 * Created by newkrok on 04/02/17.
 */
package net.fpp.starlingtowerdefense.game.module.pathfinder
{
	import net.fpp.common.geom.SimplePoint;
	import net.fpp.common.starling.module.IModule;
	import net.fpp.common.util.pathfinding.vo.PathVO;

	public interface IPathFinderModule extends IModule
	{
		function getPath( startPosition:SimplePoint, endPoint:SimplePoint ):PathVO;
	}
}