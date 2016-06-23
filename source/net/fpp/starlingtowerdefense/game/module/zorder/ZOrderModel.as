/**
 * Created by newkrok on 23/06/16.
 */
package net.fpp.starlingtowerdefense.game.module.zorder
{
	import net.fpp.common.starling.module.AModel;
	import net.fpp.starlingtowerdefense.game.module.unit.IUnitModule;

	import starling.display.DisplayObjectContainer;

	public class ZOrderModel extends AModel
	{
		private var _units:Vector.<IUnitModule>;

		private var _unitContainer:DisplayObjectContainer;

		public function ZOrderModel()
		{
			this._units = new <IUnitModule>[];
		}

		public function setUnitContainer( value:DisplayObjectContainer ):void
		{
			this._unitContainer = value;
		}

		public function addUnit( value:IUnitModule ):void
		{
			this._units.push( value );
		}

		public function removeUnit( value:IUnitModule ):void
		{
			var length:int = this._units.length;

			for( var i:int; i < length; i++ )
			{
				if( this._units[ i ] == value )
				{
					this._units.splice( i, 1 );
					return;
				}
			}
		}

		public function updateZOrder():void
		{
			var unitPositionInfos:Array = [];

			for( var i:int = 0; i < this._units.length; i++ )
			{
				unitPositionInfos.push( {y: _units[ i ].getView().y, content: _units[ i ]} );
			}

			unitPositionInfos.sortOn( "y", Array.NUMERIC );

			for( i = 0; i < unitPositionInfos.length; i++ )
			{
				this._unitContainer.addChild( unitPositionInfos[ i ].content.getView() );
			}
		}

		override public function dispose():void
		{
			this._units.length = 0;
			this._units = null;

			this._unitContainer = null;
		}
	}
}