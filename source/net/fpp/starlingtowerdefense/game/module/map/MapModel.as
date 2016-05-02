/**
 * Created by newkrok on 13/03/16.
 */
package net.fpp.starlingtowerdefense.game.module.map
{
	import net.fpp.common.starling.module.AModel;
	import net.fpp.common.util.pathfinding.vo.PathNodeVO;

	public class MapModel extends AModel
	{
		private var _mapNodes:Vector.<Vector.<PathNodeVO>> = new <Vector.<PathNodeVO>>[];

		public function get mapNodes():Vector.<Vector.<PathNodeVO>>
		{
			return this._mapNodes;
		}

		public function set mapNodes( value:Vector.<Vector.<PathNodeVO>> ):void
		{
			this._mapNodes = value;
		}
	}
}