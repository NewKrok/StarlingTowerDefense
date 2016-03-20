/**
 * Created by newkrok on 20/03/16.
 */
package starlingtowerdefense.game.module.unitcontroller.request
{
	import net.fpp.geom.SimplePoint;

	import starlingtowerdefense.game.module.unit.IUnitModule;

	public class UnitMoveToRequest
	{
		public var unit:IUnitModule;
		public var position:SimplePoint;
	}
}