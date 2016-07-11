/**
 * Created by newkrok on 13/03/16.
 */
package net.fpp.starlingtowerdefense.game.module.map
{
	import net.fpp.common.starling.module.AModel;
	import net.fpp.common.util.pathfinding.astar.vo.AStarNodeVO;

	public class MapModel extends AModel
	{
		private var _mapNodes:Vector.<Vector.<AStarNodeVO>> = new <Vector.<AStarNodeVO>>[];

		public function get mapNodes():Vector.<Vector.<AStarNodeVO>>
		{
			return this._mapNodes;
		}

		public function set mapNodes( value:Vector.<Vector.<AStarNodeVO>> ):void
		{
			this._mapNodes = value;
		}
	}
}