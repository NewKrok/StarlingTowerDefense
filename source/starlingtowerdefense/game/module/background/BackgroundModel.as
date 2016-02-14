/**
 * Created by newkrok on 14/02/16.
 */
package starlingtowerdefense.game.module.background
{
	import flash.geom.Point;

	import net.fpp.starling.module.AModel;

	public class BackgroundModel extends AModel
	{
		private var _polygons:Vector.<Vector.<Point>>;

		public function getPolygons():Vector.<Vector.<Point>>
		{
			return this._polygons;
		}

		public function setPolygons( value:Vector.<Vector.<Point>> ):void
		{
			this._polygons = value;
		}
	}
}