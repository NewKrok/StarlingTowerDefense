/**
 * Created by newkrok on 26/06/16.
 */
package net.fpp.starlingtowerdefense.game.module.targetmanager
{
	import net.fpp.common.starling.module.AModel;
	import net.fpp.starlingtowerdefense.game.module.unit.IUnitModule;
	import net.fpp.starlingtowerdefense.game.module.unitdistancecalculator.IUnitDistanceCalculatorModule;
	import net.fpp.starlingtowerdefense.game.module.unitdistancecalculator.vo.UnitDistanceVO;

	import starling.display.DisplayObject;

	public class TargetManagerModel extends AModel
	{
		private var _unitDistanceCalculatorModule:IUnitDistanceCalculatorModule;

		public function TargetManagerModel()
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

			for ( var i:int = 0; i < length; i++ )
			{
				var unitA:IUnitModule = unitDistanceVOs[ i ].unitA;
				var unitB:IUnitModule = unitDistanceVOs[ i ].unitB;

				var distance:Number = unitDistanceVOs[ i ].distance;

				if( distance < unitA.getUnitDetectionRadius() && unitA.getPlayerGroup() != unitB.getPlayerGroup() && unitA.getTarget() == null )
				{
					unitA.setTarget( unitB );
				}

				if( unitA.getTarget() == unitB )
				{
					if( distance < unitA.getAttackRadius() )
					{
						unitA.attack();

						var unitAView:DisplayObject = unitDistanceVOs[i].unitA.getView();
						var unitBView:DisplayObject = unitDistanceVOs[i].unitB.getView();

						if( Math.abs( unitAView.x - unitBView.x ) < 40 )
						{
							unitA.setPosition( unitAView.x + ( unitAView.x > unitBView.x ? 1 : -1 ), unitAView.y );
							unitB.setPosition( unitBView.x + ( unitBView.x > unitBView.x ? 1 : -1 ), unitBView.y );
						}

						if( Math.abs( unitAView.y - unitBView.y ) > 10 )
						{
							unitA.setPosition( unitAView.x, unitAView.y + ( unitAView.y > unitBView.y ? -1 : 1 ) );
							unitB.setPosition( unitBView.x, unitBView.y + ( unitBView.y > unitAView.y ? -1 : 1 ) );
						}
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