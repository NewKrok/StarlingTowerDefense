/**
 * Created by newkrok on 23/06/16.
 */
package net.fpp.starlingtowerdefense.game.module.unitdistancecalculator.vo
{
	import net.fpp.starlingtowerdefense.game.module.unit.IUnitModule;

	public class UnitDistanceVO
	{
		public var unitB:IUnitModule;
		public var unitA:IUnitModule;

		public var distance:Number;

		public function UnitDistanceVO( unitA:IUnitModule, unitB:IUnitModule, distance:Number )
		{
			this.unitA = unitA;
			this.unitB = unitB;

			this.distance = distance;
		}
	}
}