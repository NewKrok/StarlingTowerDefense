/**
 * Created by newkrok on 21/03/16.
 */
package net.fpp.starlingtowerdefense.game.module.unitdistancecalculator
{
	import net.fpp.common.starling.module.AModel;
	import net.fpp.starlingtowerdefense.game.module.unit.IUnitModule;
	import net.fpp.starlingtowerdefense.game.module.unitdistancecalculator.vo.UnitDistanceVO;

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
			var length:int = this._units.length;

			for( var i:int = 0; i < length; i++ )
			{
				this._unitDistanceVOs.push( new UnitDistanceVO( value, this._units[ i ], Number.MAX_VALUE ) );
			}

			this._units.push( value );
		}

		public function removeUnit( value:IUnitModule ):void
		{
			var length:int = this._units.length;

			for( var i:int = 0; i < length; i++ )
			{
				if( this._units[ i ] == value )
				{
					this._units.splice( i, 1 );
					break;
				}
			}

			length = this._unitDistanceVOs.length;

			for( i = 0; i < length; i++ )
			{
				if( this._unitDistanceVOs[ i ].unitA == value || this._unitDistanceVOs[ i ].unitB == value )
				{
					this._unitDistanceVOs.splice( i, 1 );
					i--;
				}
			}
		}

		public function calculateDistances():void
		{
			var distanceListLength:int = this._unitDistanceVOs.length;
			var unitListLength:int = this._units.length;

			for( var i:int = 0; i < distanceListLength; i++ )
			{
				var unitA:IUnitModule = this._unitDistanceVOs[ i ].unitA;
				var unitB:IUnitModule = this._unitDistanceVOs[ i ].unitB;

				if( !unitA || !unitB || unitA.getIsDead() || unitB.getIsDead() )
				{
					break;
				}

				var unitAView:DisplayObject = unitA.getView() as DisplayObject;
				var unitBView:DisplayObject = unitB.getView() as DisplayObject;

				var distance:Number = Math.sqrt( (unitBView.x - unitAView.x) * (unitBView.x - unitAView.x) + (unitBView.y - unitAView.y) * (unitBView.y - unitAView.y) );

				this._unitDistanceVOs[ i ].distance = distance << 0;
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