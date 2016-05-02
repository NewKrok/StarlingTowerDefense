/**
 * Created by newkrok on 20/03/16.
 */
package net.fpp.starlingtowerdefense.game.module.unitcontroller.request
{
	import net.fpp.common.geom.SimplePoint;

	import net.fpp.starlingtowerdefense.game.module.unit.IUnitModule;

	public class UnitMoveToRequest
	{
		public var unit:IUnitModule;
		public var position:SimplePoint;
	}
}