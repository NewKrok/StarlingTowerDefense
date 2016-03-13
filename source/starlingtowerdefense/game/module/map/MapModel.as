/**
 * Created by newkrok on 13/03/16.
 */
package starlingtowerdefense.game.module.map
{
	import net.fpp.starling.module.AModel;

	import starlingtowerdefense.game.module.map.vo.MapNodeVO;

	public class MapModel extends AModel
	{
		private var _mapNodes:Vector.<Vector.<MapNodeVO>> = new <Vector.<MapNodeVO>>[];

		public function get mapNodes():Vector.<Vector.<MapNodeVO>>
		{
			return this._mapNodes;
		}

		public function set mapNodes( value:Vector.<Vector.<MapNodeVO>> ):void
		{
			this._mapNodes = value;
		}
	}
}