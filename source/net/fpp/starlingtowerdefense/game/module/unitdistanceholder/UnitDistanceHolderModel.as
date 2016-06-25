/**
 * Created by newkrok on 23/06/16.
 */
package net.fpp.starlingtowerdefense.game.module.unitdistanceholder
{
	import net.fpp.common.starling.module.AModel;
	import net.fpp.starlingtowerdefense.game.module.unit.IUnitModule;
	import net.fpp.starlingtowerdefense.game.module.unitdistancecalculator.IUnitDistanceCalculatorModule;
	import net.fpp.starlingtowerdefense.game.module.unitdistancecalculator.vo.UnitDistanceVO;

	import starling.display.DisplayObject;

	public class UnitDistanceHolderModel extends AModel
	{
		private const PUSHING_FORCE_WITH_SAME_RADIUS:Number = .8;
		private const PUSHING_FORCE_WITH_DIFFERENT_RADIUS:Number = 5;

		private var _unitDistanceCalculatorModule:IUnitDistanceCalculatorModule;

		public function setUnitDistanceCalculatorModule( value:IUnitDistanceCalculatorModule ):void
		{
			this._unitDistanceCalculatorModule = value;
		}

		public function setUnitDistances():void
		{
			var unitDistanceVOs:Vector.<UnitDistanceVO> = this._unitDistanceCalculatorModule.getUnitDistanceVOs();
			var length:int = unitDistanceVOs.length;

			for ( var i:int = 0; i < length; i++ )
			{
				var unitA:IUnitModule = unitDistanceVOs[i].unitA;
				var unitB:IUnitModule = unitDistanceVOs[i].unitB;

				var distance:Number = unitDistanceVOs[i].distance;

				var unitARadius:Number = unitA.getSizeRadius();
				var unitBRadius:Number = unitB.getSizeRadius();

				if( distance < unitARadius / 2 + unitBRadius / 2 && unitA.getTarget() == null && unitB.getTarget() == null )
				{
					var unitAView:DisplayObject = unitDistanceVOs[i].unitA.getView();
					var unitBView:DisplayObject = unitDistanceVOs[i].unitB.getView();

					var unitAOffset:Number;
					var unitBOffset:Number;

					if( unitARadius == unitBRadius )
					{
						unitAOffset = unitBOffset = this.PUSHING_FORCE_WITH_SAME_RADIUS;
					}
					else if( unitARadius > unitBRadius )
					{
						unitAOffset = 0;
						unitBOffset = this.PUSHING_FORCE_WITH_DIFFERENT_RADIUS;
					}
					else
					{
						unitAOffset = this.PUSHING_FORCE_WITH_DIFFERENT_RADIUS;
						unitBOffset = 0;
					}

					var angle:Number = Math.atan2( unitAView.y - unitBView.y, unitAView.x - unitBView.x );

					unitA.setPosition( unitAView.x + unitAOffset * Math.cos( angle ), unitAView.y + unitAOffset * Math.sin( angle ) );
					unitB.setPosition( unitBView.x - unitBOffset * Math.cos( angle ), unitBView.y - unitBOffset * Math.sin( angle ) );
				}
			}
		}

		override public function dispose():void
		{
			this._unitDistanceCalculatorModule = null;
		}
	}
}