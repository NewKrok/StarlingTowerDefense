﻿/**
 * Created by newkrok on 07/01/16.
 */
package starlingtowerdefense.game.module.unit
{
	import caurina.transitions.Tweener;

	import net.fpp.geom.SimplePoint;
	import net.fpp.starling.module.AModule;

	import starlingtowerdefense.game.module.unit.events.UnitModuleEvent;

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
			this.move( this._routeVO.route[ this._routeIndex ] );

			this._routeIndex++;
		}

		private function move( position:SimplePoint ):void
		{
			if( position.x == this._unitView.x && position.y == this._unitView.y )
			{
				return;
			}

			if( this._unitView.x != position.x )
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
			return this._unitView.x > x ? -1 : 1;
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
			if( this._routeVO && this._routeVO.route )
			{
				if ( this._routeIndex == this._routeVO.route.length )
				{
					this.clearRouteData();
					this._isMoving = false;
					this._unitView.idle();
				}
				else if( !this._unitModel.getTarget() )
				{
					this.runNextRouteData();
				}
			}
			else if( this._unitModel.getTarget() )
			{
				this._unitView.idle();

				this._unitView.scaleX = this.calculateScaleByEndX( this._unitModel.getTarget().getView().x );
			}
		}

		private function clearRouteData():void
		{
			if ( this._routeVO && this._routeVO.route )
			{
				this._routeVO.route.length = 0;
				this._routeVO.route = null;
				this._routeVO = null;

				this._routeIndex = 0;
			}
		}

		public function setPosition( x:Number, y:Number ):void
		{
			this._unitView.x = x;
			this._unitView.y = y;

			if( this._isMoving && !this._unitModel.getTarget() )
			{
				Tweener.removeTweens( this._unitView );

				if( this._routeIndex > 0 )
				{
					this._routeIndex--;
				}

				this._unitView.run();
				this.runNextRouteData();
			}
		}

		public function attack():void
		{
			Tweener.removeTweens( this._unitView );

			var now:Number = new Date().time;
			if( new Date().time - this._unitModel.getLastAttackTime() > this._unitModel.getAttackSpeed() * 1000 )
			{
				this._unitModel.setLastAttackTime( now );

				this._unitView.scaleX = this.calculateScaleByEndX( this._unitModel.getTarget().getView().x );

				this._unitView.attack();

				Tweener.addTween( this, {time: this._unitModel.getDamageDelay(), onComplete: damageTarget} );
			}
		}

		private function damageTarget():void
		{
			if( this._unitModel.getTarget() )
			{
				this._unitModel.getTarget().damage( this._unitModel.getDamage() );

				if( this._unitModel.getTarget().getIsDead() )
				{
					this.removeTarget();
				}
			}
		}

		public function damage( value:Number ):void
		{
			this._unitModel.setLife( Math.max( this._unitModel.getLife() - value, 0 ) );

			if( this._unitModel.getLife() == 0 )
			{
				this.die();
			}
		}

		private function die():void
		{
			Tweener.removeTweens( this );

			Tweener.addTween( this._unitView, {time: 1, alpha: 0, onComplete: onDiedHandler} );

			this.clearRouteData();
			this.removeTarget();
		}

		private function onDiedHandler():void
		{
			this.dispatchEvent( new UnitModuleEvent( UnitModuleEvent.UNIT_DIED ) );
		}

		public function getIsDead():Boolean
		{
			return this._unitModel.getLife() == 0;
		}

		public function changeSkin( type:int ):void
		{
			this._unitView.changeSkin( type );
		}

		public function getSizeRadius():Number
		{
			return this._unitModel.getSizeRadius();
		}

		public function getTarget():IUnitModule
		{
			return this._unitModel.getTarget();
		}

		public function setTarget( value:IUnitModule ):void
		{
			this._unitModel.setTarget( value );

			this.move( new SimplePoint( this._unitModel.getTarget().getView().x, this._unitModel.getTarget().getView().y ) );
		}

		public function removeTarget():void
		{
			this._unitModel.setTarget( null );

			if( this._routeVO && this._routeVO.route && this._routeVO.route.length > 0 && this._routeIndex != this._routeVO.route.length )
			{
				if( this._routeIndex > 0 )
				{
					this._routeIndex--;
				}

				this._unitView.run();
				this.runNextRouteData();
			}
		}

		public function getPlayerGroup():String
		{
			return this._unitModel.getPlayerGroup();
		}

		public function setPlayerGroup( value:String ):void
		{
			this._unitModel.setPlayerGroup( value );
		}

		public function getIsMoving():Boolean
		{
			return this._isMoving;
		}
	}
}