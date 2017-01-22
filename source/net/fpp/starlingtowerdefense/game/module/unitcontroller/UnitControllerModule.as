/**
 * Created by newkrok on 20/03/16.
 */
package net.fpp.starlingtowerdefense.game.module.unitcontroller
{
	import flash.geom.Point;

	import net.fpp.common.geom.SimplePoint;
	import net.fpp.common.starling.module.AModule;
	import net.fpp.starlingtowerdefense.game.module.unit.IUnitModule;
	import net.fpp.starlingtowerdefense.game.module.unitcontroller.events.UnitControllerModuleEvent;
	import net.fpp.starlingtowerdefense.game.module.unitcontroller.request.UnitMoveToRequest;
	import net.fpp.starlingtowerdefense.game.module.unitcontroller.view.UnitControllerModuleView;

	import starling.display.DisplayObjectContainer;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class UnitControllerModule extends AModule implements IUnitControllerModule
	{
		private var _unitControllerModel:UnitControllerModel;
		private var _unitControllerModuleView:UnitControllerModuleView;

		public function UnitControllerModule()
		{
			this._unitControllerModel = this.createModel( UnitControllerModel ) as UnitControllerModel;
			this._unitControllerModuleView = this.createModuleView( UnitControllerModuleView ) as UnitControllerModuleView;
		}

		public function setGameContainer( value:DisplayObjectContainer ):void
		{
			this._unitControllerModel.setGameContainer( value );

			this._unitControllerModel.getGameContainer().addEventListener( TouchEvent.TOUCH, this.onTouchHandler );
		}

		private function onTouchHandler( e:TouchEvent ):void
		{
			if( e.touches[ 0 ].phase == TouchPhase.ENDED )
			{
				var unitMoveToRequest:UnitMoveToRequest = new UnitMoveToRequest();
				unitMoveToRequest.unit = this._unitControllerModel.getTarget();

				var touchPoint:Point = e.touches[ 0 ].getLocation( this._unitControllerModuleView );
				unitMoveToRequest.position = new SimplePoint( touchPoint.x, touchPoint.y );

				this.dispatchEvent( new UnitControllerModuleEvent( UnitControllerModuleEvent.UNIT_MOVE_TO_REQUEST, unitMoveToRequest ) );
			}
		}

		public function setTarget( value:IUnitModule ):void
		{
			this._unitControllerModel.setTarget( value );

			if( value )
			{
				this._unitControllerModuleView.updateSelectionMarkerVisibility();
			}
		}

		public function onUpdate():void
		{
			if( this._unitControllerModel.getTarget() )
			{
				this._unitControllerModuleView.updateSelectionMarkerPosition();
			}
		}

		public function getUpdateFrequency():int
		{
			return 10;
		}
	}
}