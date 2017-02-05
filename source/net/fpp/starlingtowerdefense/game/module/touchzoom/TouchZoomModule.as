/**
 * Created by newkrok on 05/05/16.
 */
package net.fpp.starlingtowerdefense.game.module.touchzoom
{
	import flash.geom.Point;

	import net.fpp.common.geom.SimplePoint;
	import net.fpp.common.starling.module.AModule;

	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class TouchZoomModule extends AModule implements ITouchZoomModule
	{
		[Inject(id="viewContainer")]
		public var viewContainer:Sprite;

		private var _touchZoomModel:TouchZoomModel;

		public function TouchZoomModule()
		{
			this._touchZoomModel = this.createModel( TouchZoomModel ) as TouchZoomModel;
		}

		override public function onInited():void
		{
			viewContainer.addEventListener( TouchEvent.TOUCH, onTouchHandler );

			_touchZoomModel.zoomValue = viewContainer.scaleX;
		}

		private function onTouchHandler( e:TouchEvent ):void
		{
			if( e.touches.length < 2 )
			{
				return;
			}

			var touchA:Touch = e.touches[ 0 ];
			var touchB:Touch = e.touches[ 1 ];

			if( touchA.phase == TouchPhase.ENDED || touchB.phase == TouchPhase.ENDED )
			{
				viewContainer.x -= viewContainer.pivotX;
				viewContainer.pivotX = 0
				viewContainer.y -= viewContainer.pivotY;
				viewContainer.pivotY = 0;

				this._touchZoomModel.zoomStartOffset = 0;
				this._touchZoomModel.isZoomInProgress = false;
				this._touchZoomModel.zoomMiddlePoint = null;
			}
			else if( touchA.phase == TouchPhase.MOVED || touchB.phase == TouchPhase.MOVED )
			{
				if( this._touchZoomModel.zoomStartOffset == 0 )
				{
					this._touchZoomModel.zoomStartOffset = Math.sqrt( Math.pow( touchA.globalX - touchB.globalX, 2 ) + Math.pow( touchA.globalY - touchB.globalY, 2 ) );
					this._touchZoomModel.zoomValueAtStart = this._touchZoomModel.zoomValue;
					this._touchZoomModel.isZoomInProgress = true;
				}

				var zoomOffset:Number = Math.sqrt( Math.pow( touchA.globalX - touchB.globalX, 2 ) + Math.pow( touchA.globalY - touchB.globalY, 2 ) );
				var zoomOffsetFromStart:Number = zoomOffset - this._touchZoomModel.zoomStartOffset;

				var newMapZoom:Number = this._touchZoomModel.zoomValueAtStart + zoomOffsetFromStart / 250;
				newMapZoom = Math.max( .5, newMapZoom );
				newMapZoom = Math.min( 2, newMapZoom );
				viewContainer.scaleX = viewContainer.scaleY = newMapZoom;

				if( viewContainer.width < viewContainer.stage.stageWidth )
				{
					viewContainer.width = viewContainer.stage.stageWidth;
					viewContainer.scaleY = viewContainer.scaleX;
				}
				else if( viewContainer.height < viewContainer.stage.stageHeight )
				{
					viewContainer.height = viewContainer.stage.stageHeight;
					viewContainer.scaleX = viewContainer.scaleY;
				}

				this._touchZoomModel.zoomValue = viewContainer.scaleX;

				if( this._touchZoomModel.zoomMiddlePoint == null )
				{
					var _zoomTouchPointA:Point = touchA.getLocation( viewContainer );
					var _zoomTouchPointB:Point = touchB.getLocation( viewContainer );
					this._touchZoomModel.zoomMiddlePoint = new SimplePoint( ( _zoomTouchPointA.x + _zoomTouchPointB.x ) / 2, ( _zoomTouchPointA.y + _zoomTouchPointB.y ) / 2 );

					this._touchZoomModel.zoomPointOffset.setTo( ( touchA.globalX + touchB.globalX ) / 2, ( touchA.globalY + touchB.globalY ) / 2 );
				}

				viewContainer.x = this._touchZoomModel.zoomPointOffset.x - this._touchZoomModel.zoomMiddlePoint.x * newMapZoom;
				viewContainer.y = this._touchZoomModel.zoomPointOffset.y - this._touchZoomModel.zoomMiddlePoint.y * newMapZoom;

				viewContainer.x = getNormalizedWorldXPosition( viewContainer.x );
				viewContainer.y = getNormalizedWorldYPosition( viewContainer.y );
			}
		}

		private function getNormalizedWorldXPosition( x:Number ):Number
		{
			return Math.max( -viewContainer.width + viewContainer.stage.stageWidth, Math.min( 0, x ) );
		}

		private function getNormalizedWorldYPosition( y:Number ):Number
		{
			return Math.max( -viewContainer.height + viewContainer.stage.stageHeight, Math.min( 0, y ) );
		}

		public function getIsZoomInProgress():Boolean
		{
			return this._touchZoomModel.isZoomInProgress;
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