/**
 * Created by newkrok on 19/07/16.
 */
package net.fpp.starlingtowerdefense.game.module.unitdistancemanager.distanceaction
{
	import net.fpp.starlingtowerdefense.game.module.unit.IUnitModule;
	import net.fpp.starlingtowerdefense.game.module.unitdistancemanager.vo.UnitDistanceVO;

	public class UnitTargetSelectorAction implements IUnitDistanceAction
	{
		public function execute( value:UnitDistanceVO ):void
		{
			var unitA:IUnitModule = value.unitA;
			var unitB:IUnitModule = value.unitB;

			this.selectTarget( unitA, unitB, value.distance );
			this.selectTarget( unitB, unitA, value.distance );
		}

		private function selectTarget( unitA:IUnitModule, unitB:IUnitModule, distance:Number ):void
		{
			if( unitA.getIsMoving() && !unitA.getIsAttackMoveToInProgress() )
			{
				return;
			}

			if( unitA.getTarget() == null && distance < unitA.getUnitDetectionRadius() && unitA.getPlayerGroup() != unitB.getPlayerGroup() )
			{
				unitA.setTarget( unitB );
			}

			if( unitA.getTarget() == unitB )
			{
				if( unitB.getIsDead() )
				{
					unitA.removeTarget();
				}
				else if( distance < unitA.getAttackRadius() )
				{
					unitA.attack();
				}
				else if( !unitA.getIsMoving() )
				{
					unitA.removeTarget();
				}
			}
		}
	}
}