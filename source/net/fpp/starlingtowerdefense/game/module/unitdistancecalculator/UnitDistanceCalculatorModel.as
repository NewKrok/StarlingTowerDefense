/**
 * Created by newkrok on 21/03/16.
 */
package net.fpp.starlingtowerdefense.game.module.unitdistancecalculator
{
	import net.fpp.common.starling.module.AModel;
	import net.fpp.starlingtowerdefense.game.module.unitdistancecalculator.vo.UnitDistanceVO;

	import net.fpp.starlingtowerdefense.game.module.unit.IUnitModule;

	import starling.display.DisplayObject;

	public class UnitDistanceCalculatorModel extends AModel
	{
		private var _units:Vector.<IUnitModule>;
		private var _unitDistanceVOs:Vector.<UnitDistanceVO>;

		public function UnitDistanceCalculatorModel()
		{
			this._units = new <IUnitModule>[];
			this._unitDistanceVOs = new <UnitDistanceVO>[];
		}

		public function addUnit( value:IUnitModule ):void
		{
			this._units.push( value );
		}

		public function removeUnit( value:IUnitModule ):void
		{
			var length:int = this._units.length;

			for ( var i:int; i < length; i++ )
			{
				if ( this._units[i] == value )
				{
					this._units.splice( i, 1 );
					return;
				}
			}
		}

		public function calculateDistances():void
		{
			this._unitDistanceVOs.length = 0;

			var length:int = this._units.length;

			for( var i:int = 0; i < length; i++ )
			{
				for( var j:int = 0; j < length; j++ )
				{
					if( i != j )
					{
						var unitA:IUnitModule = this._units[ i ] as IUnitModule;
						var unitB:IUnitModule = this._units[ j ] as IUnitModule;

						if( unitA.getIsDead() || unitB.getIsDead() )
						{
							break;
						}

						var unitAView:DisplayObject = unitA.getView() as DisplayObject;
						var unitBView:DisplayObject = unitB.getView() as DisplayObject;

						var distance:Number = Math.sqrt(
								Math.pow( unitAView.x - unitBView.x, 2 ) +
								Math.pow( unitAView.y - unitBView.y, 2 )
						);

						this._unitDistanceVOs.push( new UnitDistanceVO( unitA, unitB, Math.floor( distance ) ) );
					}
				}
			}
		}

		public function getUnitDistanceVOs():Vector.<UnitDistanceVO>
		{
			return this._unitDistanceVOs;
		}

		override public function dispose():void
		{
			this._units.length = 0;
			this._units = null;

			this._unitDistanceVOs.length = 0;
			this._unitDistanceVOs = null;
		}
	}
}