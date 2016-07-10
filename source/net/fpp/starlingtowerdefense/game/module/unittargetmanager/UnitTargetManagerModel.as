/**
 * Created by newkrok on 26/06/16.
 */
package net.fpp.starlingtowerdefense.game.module.unittargetmanager
{
	import net.fpp.common.starling.module.AModel;
	import net.fpp.starlingtowerdefense.game.module.unit.IUnitModule;
	import net.fpp.starlingtowerdefense.game.module.unitdistancecalculator.IUnitDistanceCalculatorModule;
	import net.fpp.starlingtowerdefense.game.module.unitdistancecalculator.vo.UnitDistanceVO;

	public class UnitTargetManagerModel extends AModel
	{
		private var _unitDistanceCalculatorModule:IUnitDistanceCalculatorModule;

		public function UnitTargetManagerModel()
		{
		}

		public function setUnitDistanceCalculatorModule( value:IUnitDistanceCalculatorModule ):void
		{
			this._unitDistanceCalculatorModule = value;
		}

		public function calculateTargets():void
		{
			var unitDistanceVOs:Vector.<UnitDistanceVO> = this._unitDistanceCalculatorModule.getUnitDistanceVOs();
			var length:int = unitDistanceVOs.length;

			for( var i:int = 0; i < length; i++ )
			{
				var unitA:IUnitModule = unitDistanceVOs[ i ].unitA;
				var unitB:IUnitModule = unitDistanceVOs[ i ].unitB;

				if( unitA.getIsMoving() && !unitA.getIsAttackMoveToInProgress() )
				{
					continue;
				}

				var distance:Number = unitDistanceVOs[ i ].distance;

				if( distance < unitA.getUnitDetectionRadius() && unitA.getPlayerGroup() != unitB.getPlayerGroup() && unitA.getTarget() == null )
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

		override public function dispose():void
		{
			this._unitDistanceCalculatorModule = null;

			super.dispose();
		}
	}
}