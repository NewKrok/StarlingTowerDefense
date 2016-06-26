/**
 * Created by newkrok on 08/05/16.
 */
package net.fpp.starlingtowerdefense.game.module.touchdragmodule
{
	import net.fpp.common.starling.module.AModule;
	import net.fpp.starlingtowerdefense.game.module.touchdragmodule.constant.CTouchDrag;

	import starling.display.DisplayObjectContainer;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class TouchDragModule extends AModule implements ITouchDragModule
	{
		private var _touchDragModel:TouchDragModel;

		public function TouchDragModule()
		{
			this._touchDragModel = this.createModel( TouchDragModel ) as TouchDragModel;
		}

		public function setGameContainer( value:DisplayObjectContainer ):void
		{
			this._touchDragModel.gameContainer = value;
			this._touchDragModel.gameContainer.addEventListener( TouchEvent.TOUCH, this.onTouchHandler );
		}

		private function onTouchHandler( e:TouchEvent ):void
		{
			if( e.touches.length > 1 )
			{
				return;
			}

			var touch:Touch = e.touches[ 0 ];

			var offset:Number = Math.sqrt( Math.pow( Math.abs( this._touchDragModel.touchStartPoint.x - touch.globalX ), 2 ) + Math.pow( Math.abs( this._touchDragModel.touchStartPoint.y - touch.globalY ), 2 ) );

			switch( touch.phase )
			{
				case TouchPhase.BEGAN:
					this._touchDragModel.isTouched = true;
					this._touchDragModel.touchStartPoint.setTo( touch.globalX, touch.globalY );
					this._touchDragModel.lastTouchPoint = this._touchDragModel.touchStartPoint.clone();
					break;

				case TouchPhase.ENDED:
					this._touchDragModel.isTouched = false;
					this._touchDragModel.isTouchDragged = false;
					break;

				case TouchPhase.MOVED:
					if( offset > CTouchDrag.MINIMUM_DRAG_VALUE )
					{
						this._touchDragModel.isTouchDragged = true;
					}

					if( this._touchDragModel.isTouchDragged )
					{
						this._touchDragModel.gameContainer.x -= ( this._touchDragModel.lastTouchPoint.x - touch.globalX );
						this._touchDragModel.gameContainer.y -= ( this._touchDragModel.lastTouchPoint.y - touch.globalY );
					}
					this._touchDragModel.swipeForce = Math.sqrt( Math.pow( Math.abs( touch.previousGlobalX - touch.globalX ), 2 ) + Math.pow( Math.abs( touch.previousGlobalY - touch.globalY ), 2 ) );
					this._touchDragModel.swipeDirection = Math.atan2( touch.globalY - touch.previousGlobalY, touch.globalX - touch.previousGlobalX );
					this._touchDragModel.lastTouchPoint.setTo( touch.globalX, touch.globalY );
					break;
			}
		}

		public function onUpdate():void
		{
			if ( this._touchDragModel.swipeForce > 1 )
			{
				this._touchDragModel.gameContainer.x = getNormalizedWorldXPosition( this._touchDragModel.gameContainer.x + this._touchDragModel.swipeForce / 2 * Math.cos( this._touchDragModel.swipeDirection ) );
				this._touchDragModel.gameContainer.y = getNormalizedWorldYPosition( this._touchDragModel.gameContainer.y + this._touchDragModel.swipeForce / 2 * Math.sin( this._touchDragModel.swipeDirection ) );

				this._touchDragModel.swipeForce *= .96;
			}
			else if ( this._touchDragModel.swipeForce != 0 )
			{
				this._touchDragModel.swipeForce = 0;
				this._touchDragModel.gameContainer.x = getNormalizedWorldXPosition( this._touchDragModel.gameContainer.x );
				this._touchDragModel.gameContainer.y = getNormalizedWorldYPosition( this._touchDragModel.gameContainer.y );
			}
		}

		private function getNormalizedWorldXPosition( x:Number ):Number
		{
			return Math.max( -this._touchDragModel.gameContainer.width + this._touchDragModel.gameContainer.stage.stageWidth, Math.min( 0, x ) );
		}

		private function getNormalizedWorldYPosition( y:Number ):Number
		{
			return Math.max( -this._touchDragModel.gameContainer.height + this._touchDragModel.gameContainer.stage.stageHeight, Math.min( 0, y ) );
		}

		public function getIsTouchDragged():Boolean
		{
			return this._touchDragModel.isTouchDragged;
		}

		override public function dispose():void
		{
			if( this._touchDragModel.gameContainer )
			{
				this._touchDragModel.gameContainer.removeEventListener( TouchEvent.TOUCH, this.onTouchHandler );
			}

			super.dispose();
		}
	}
}