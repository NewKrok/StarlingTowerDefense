/**
 * Created by newkrok on 07/01/16.
 */
package starlingtowerdefense.game.module.unit
{
	import net.fpp.geom.SimplePoint;
	import net.fpp.starling.module.AModule;

	import caurina.transitions.Tweener

	import starlingtowerdefense.game.module.unit.view.UnitModuleView;
	import starlingtowerdefense.game.service.animatedgraphic.DragonBonesGraphicService;
	import starlingtowerdefense.game.service.pathfinder.vo.RouteVO;

	public class UnitModule extends AModule implements IUnitModule
	{
		private var _unitView:UnitModuleView;
		private var _unitModel:UnitModel;

		private var _routeVO:RouteVO;
		private var _routeIndex:int;
		private var _isMoving:Boolean;

		public function UnitModule( dragonBonesGraphicService:DragonBonesGraphicService ):void
		{
			this._unitModel = this.createModel( UnitModel ) as UnitModel;

			this._unitView = this.createView( UnitModuleView ) as UnitModuleView;
			this._unitView.setDragonBonesGraphicService( dragonBonesGraphicService );
		}

		public function moveTo( routeVO:RouteVO ):void
		{
			this._isMoving = true;

			this._routeIndex = 0;
			this._routeVO = routeVO;

			this.runNextRouteData();
			this._unitView.run();
		}

		private function runNextRouteData():void
		{
			this.move( this._routeVO.route[this._routeIndex] );

			this._routeIndex++;
		}

		private function move( position:SimplePoint ):void
		{
			if ( position.x == this._unitView.x && position.y == this._unitView.y )
			{
				return;
			}

			if ( this._unitView.x != position.x )
			{
				this._unitView.scaleX = this.calculateScaleByEndX( position.x );
			}

			Tweener.removeTweens( this._unitView );

			Tweener.addTween( this._unitView, {
				x: position.x,
				y: position.y,
				time: this.calculateMoveTimeByEndPosition( position.x, position.y ),
				transition: 'linear',
				onComplete: this.onMoveEnd
			} );
		}

		private function calculateScaleByEndX( x:Number ):Number
		{
			return this._view.x > x ? -1 : 1;
		}

		private function calculateMoveTimeByEndPosition( x:Number, y:Number ):Number
		{
			var distanceX:Number = this._view.x - x;
			var distanceY:Number = this._view.y - y;

			var distance:Number = Math.sqrt( Math.pow( distanceX, 2 ) + Math.pow( distanceY, 2 ) );

			return distance / this._unitModel.getMovementSpeed();
		}

		private function onMoveEnd():void
		{
			if ( this._routeIndex == this._routeVO.route.length )
			{
				this.clearRouteData();
				this._isMoving = false;
				this._unitView.idle();
			}
			else
			{
				this.runNextRouteData();
			}
		}

		private function clearRouteData():void
		{
			this._routeVO.route.length = 0;
			this._routeVO.route = null;
			this._routeVO = null;

			this._routeIndex = 0;
		}

		public function setPosition( x:Number, y:Number ):void
		{
			this._unitView.x = x;
			this._unitView.y = y;

			if ( this._isMoving )
			{
				Tweener.removeTweens( this._unitView );

				if( this._routeIndex > 0 )
				{
					this._routeIndex--;
				}

				this.runNextRouteData();
			}
		}

		public function attack():void
		{
			Tweener.removeTweens( this._unitView );

			this._unitView.attack();
		}

		public function changeSkin():void
		{
			this._unitView.changeSkin();
		}

		public function getSizeRadius():Number
		{
			return this._unitModel.getSizeRadius();
		}

		public function asd():void
		{
			this._unitModel.setSizeRadius(150);
		}
	}
}