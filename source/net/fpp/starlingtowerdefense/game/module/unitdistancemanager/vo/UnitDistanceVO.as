/**
 * Created by newkrok on 23/06/16.
 */
package net.fpp.starlingtowerdefense.game.module.unitdistancemanager.vo
{
	import net.fpp.starlingtowerdefense.game.module.unit.IUnitModule;

	public class UnitDistanceVO
	{
		public var unitA:IUnitModule;
		public var unitB:IUnitModule;

		public var distance:Number;

		public function UnitDistanceVO( unitA:IUnitModule = null, unitB:IUnitModule = null, distance:Number = 0 )
		{
			this.unitA = unitA;
			this.unitB = unitB;

			this.distance = distance;
		}
	}
}