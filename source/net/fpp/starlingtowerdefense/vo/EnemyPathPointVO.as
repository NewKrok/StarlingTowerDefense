/**
 * Created by newkrok on 01/06/16.
 */
package net.fpp.starlingtowerdefense.vo
{
	import net.fpp.common.geom.SimplePoint;

	public class EnemyPathPointVO
	{
		public var radius:Number;
		public var point:SimplePoint;

		public function EnemyPathPointVO( radius:Number, point:SimplePoint )
		{
			this.radius = radius;
			this.point = point;
		}
	}
}