/**
 * Created by newkrok on 08/05/16.
 */
package net.fpp.starlingtowerdefense.game.module.touchdrag
{
	import net.fpp.common.starling.module.AModule;
	import net.fpp.common.util.GeomUtil;
	import net.fpp.starlingtowerdefense.game.module.touchdrag.constant.CTouchDrag;

	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class TouchDragModule extends AModule implements ITouchDragModule
	{
		[Inject(id="viewContainer")]
		public var viewContainer:Sprite;

		private var _touchDragModel:TouchDragModel;

		public function TouchDragModule()
		{
			this._touchDragModel = this.createModel( TouchDragModel ) as TouchDragModel;
		}

		override public function onInited():void
		{
			viewContainer.addEventListener( TouchEvent.TOUCH, this.onTouchHandler );
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
						viewContainer.x -= ( this._touchDragModel.lastTouchPoint.x - touch.globalX );
						viewContainer.y -= ( this._touchDragModel.lastTouchPoint.y - touch.globalY );
					}
					this._touchDragModel.swipeForce = Math.sqrt( Math.pow( Math.abs( touch.previousGlobalX - touch.globalX ), 2 ) + Math.pow( Math.abs( touch.previousGlobalY - touch.globalY ), 2 ) );
					this._touchDragModel.swipeDirection = GeomUtil.atan2( touch.globalY - touch.previousGlobalY, touch.globalX - touch.previousGlobalX );
					this._touchDragModel.lastTouchPoint.setTo( touch.globalX, touch.globalY );
					break;
			}
		}

		public function onUpdate():void
		{
			if ( this._touchDragModel.swipeForce > 1 )
			{
				viewContainer.x = getNormalizedWorldXPosition( viewContainer.x + this._touchDragModel.swipeForce / 2 * Math.cos( this._touchDragModel.swipeDirection ) );
				viewContainer.y = getNormalizedWorldYPosition( viewContainer.y + this._touchDragModel.swipeForce / 2 * Math.sin( this._touchDragModel.swipeDirection ) );

				this._touchDragModel.swipeForce *= .96;
			}
			else if ( this._touchDragModel.swipeForce != 0 )
			{
				this._touchDragModel.swipeForce = 0;
				viewContainer.x = getNormalizedWorldXPosition( viewContainer.x );
				viewContainer.y = getNormalizedWorldYPosition( viewContainer.y );
			}
		}

		public function getUpdateFrequency():int
		{
			return 100;
		}

		private function getNormalizedWorldXPosition( x:Number ):Number
		{
			return Math.max( -viewContainer.width + viewContainer.stage.stageWidth, Math.min( 0, x ) );
		}

		private function getNormalizedWorldYPosition( y:Number ):Number
		{
			return Math.max( -viewContainer.height + viewContainer.stage.stageHeight, Math.min( 0, y ) );
		}

		public function getIsTouchDragged():Boolean
		{
			return this._touchDragModel.isTouchDragged;
		}

		override public function dispose():void
		{
			if( viewContainer )
			{
				viewContainer.removeEventListener( TouchEvent.TOUCH, this.onTouchHandler );
			}

			super.dispose();
		}
	}
}