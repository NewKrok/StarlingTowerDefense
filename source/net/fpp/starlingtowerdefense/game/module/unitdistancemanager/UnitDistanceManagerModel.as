/**
 * Created by newkrok on 21/03/16.
 */
package net.fpp.starlingtowerdefense.game.module.unitdistancemanager
{
	import net.fpp.common.starling.module.AModel;
	import net.fpp.starlingtowerdefense.game.module.unit.IUnitModule;
	import net.fpp.starlingtowerdefense.game.module.unitdistancemanager.distanceaction.IUnitDistanceAction;
	import net.fpp.starlingtowerdefense.game.module.unitdistancemanager.vo.UnitDistanceVO;

	import starling.display.DisplayObject;

	public class UnitDistanceManagerModel extends AModel
	{
		private var _units:Vector.<IUnitModule>;
		private var _unitDistanceVOs:Vector.<UnitDistanceVO>;
		private var _distanceActions:Vector.<IUnitDistanceAction>;

		public function UnitDistanceManagerModel()
		{
			this._units = new <IUnitModule>[];
			this._unitDistanceVOs = new <UnitDistanceVO>[];
			this._distanceActions = new <IUnitDistanceAction>[];
		}

		public function addDistanceAction( value:IUnitDistanceAction ):void
		{
			this._distanceActions.push( value );
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
					length--;
					i--;
				}
			}
		}

		public function calculateDistances():void
		{
			var distanceListLength:int = this._unitDistanceVOs.length;
			var unitListLength:int = this._units.length;

			var unitDistanceVO:UnitDistanceVO;
			var unitA:IUnitModule;
			var unitB:IUnitModule;
			var unitAView:DisplayObject;
			var unitBView:DisplayObject;
			var xDistance:Number;
			var yDistance:Number;
			var distance:Number;

			for( var i:int = 0; i < distanceListLength; i++ )
			{
				unitDistanceVO = this._unitDistanceVOs[ i ];

				unitA = unitDistanceVO.unitA;
				unitB = unitDistanceVO.unitB;

				if( unitA.getIsDead() || unitB.getIsDead() )
				{
					continue;
				}

				unitAView = unitA.getView();
				unitBView = unitB.getView();

				xDistance = unitBView.x - unitAView.x;
				yDistance = unitBView.y - unitAView.y;

				unitDistanceVO.distance = Math.sqrt( xDistance * xDistance + yDistance * yDistance ) << 0;

				this.executeDistanceActions( unitDistanceVO );
			}
		}

		private function executeDistanceActions( value:UnitDistanceVO ):void
		{
			for ( var i:int = 0; i < this._distanceActions.length; i++ )
			{
				this._distanceActions[i].execute( value );
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