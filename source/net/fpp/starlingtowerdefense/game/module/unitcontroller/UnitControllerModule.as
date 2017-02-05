/**
 * Created by newkrok on 20/03/16.
 */
package net.fpp.starlingtowerdefense.game.module.unitcontroller
{
	import flash.geom.Point;

	import net.fpp.common.geom.SimplePoint;
	import net.fpp.common.starling.module.AModule;
	import net.fpp.common.util.pathfinding.vo.PathVO;
	import net.fpp.starlingtowerdefense.game.module.pathfinder.IPathFinderModule;
	import net.fpp.starlingtowerdefense.game.module.touchdrag.ITouchDragModule;
	import net.fpp.starlingtowerdefense.game.module.touchzoom.ITouchZoomModule;
	import net.fpp.starlingtowerdefense.game.module.unit.IUnitModule;
	import net.fpp.starlingtowerdefense.game.module.unitcontroller.view.UnitControllerModuleView;

	import starling.display.DisplayObjectContainer;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class UnitControllerModule extends AModule implements IUnitControllerModule
	{
		[Inject]
		public var pathFinderModule:IPathFinderModule;

		[Inject]
		public var touchDragModule:ITouchDragModule;

		[Inject]
		public var touchZoomModule:ITouchZoomModule;

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
				if( !touchDragModule.getIsTouchDragged() && !touchZoomModule.getIsZoomInProgress() )
				{
					var touchPoint:Point = e.touches[ 0 ].getLocation( this._unitControllerModuleView );

					var pathVO:PathVO = pathFinderModule.getPath( this._unitControllerModel.getTarget().getPosition(), new SimplePoint( touchPoint.x, touchPoint.y ) );

					if( pathVO.path && pathVO.path.length > 0 )
					{
						this._unitControllerModel.getTarget().moveTo( pathVO );
					}
				}
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