/**
 * Created by newkrok on 05/05/16.
 */
package net.fpp.starlingtowerdefense.game.module.touchzoom
{
	import flash.geom.Point;

	import net.fpp.common.geom.SimplePoint;
	import net.fpp.common.starling.module.AModule;

	import starling.display.DisplayObjectContainer;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class TouchZoomModule extends AModule implements ITouchZoomModule
	{
		private var _touchZoomModel:TouchZoomModel;

		public function TouchZoomModule()
		{
			this._touchZoomModel = this.createModel( TouchZoomModel ) as TouchZoomModel;
		}

		public function setGameContainer( value:DisplayObjectContainer ):void
		{
			this._touchZoomModel.gameContainer = value;
			this._touchZoomModel.gameContainer.addEventListener( TouchEvent.TOUCH, this.onTouchHandler );

			this._touchZoomModel.zoomValue = value.scaleX;
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
				this._touchZoomModel.gameContainer.x -= this._touchZoomModel.gameContainer.pivotX;
				this._touchZoomModel.gameContainer.pivotX = 0
				this._touchZoomModel.gameContainer.y -= this._touchZoomModel.gameContainer.pivotY;
				this._touchZoomModel.gameContainer.pivotY = 0;

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
				this._touchZoomModel.gameContainer.scaleX = this._touchZoomModel.gameContainer.scaleY = newMapZoom;

				if( this._touchZoomModel.gameContainer.width < this._touchZoomModel.gameContainer.stage.stageWidth )
				{
					this._touchZoomModel.gameContainer.width = this._touchZoomModel.gameContainer.stage.stageWidth;
					this._touchZoomModel.gameContainer.scaleY = this._touchZoomModel.gameContainer.scaleX;
				}
				else if( this._touchZoomModel.gameContainer.height < this._touchZoomModel.gameContainer.stage.stageHeight )
				{
					this._touchZoomModel.gameContainer.height = this._touchZoomModel.gameContainer.stage.stageHeight;
					this._touchZoomModel.gameContainer.scaleX = this._touchZoomModel.gameContainer.scaleY;
				}

				this._touchZoomModel.zoomValue = this._touchZoomModel.gameContainer.scaleX;

				if( this._touchZoomModel.zoomMiddlePoint == null )
				{
					var _zoomTouchPointA:Point = touchA.getLocation( this._touchZoomModel.gameContainer );
					var _zoomTouchPointB:Point = touchB.getLocation( this._touchZoomModel.gameContainer );
					this._touchZoomModel.zoomMiddlePoint = new SimplePoint( ( _zoomTouchPointA.x + _zoomTouchPointB.x ) / 2, ( _zoomTouchPointA.y + _zoomTouchPointB.y ) / 2 );

					this._touchZoomModel.zoomPointOffset.setTo( ( touchA.globalX + touchB.globalX ) / 2, ( touchA.globalY + touchB.globalY ) / 2 );
				}

				this._touchZoomModel.gameContainer.x = this._touchZoomModel.zoomPointOffset.x - this._touchZoomModel.zoomMiddlePoint.x * newMapZoom;
				this._touchZoomModel.gameContainer.y = this._touchZoomModel.zoomPointOffset.y - this._touchZoomModel.zoomMiddlePoint.y * newMapZoom;

				this._touchZoomModel.gameContainer.x = getNormalizedWorldXPosition( this._touchZoomModel.gameContainer.x );
				this._touchZoomModel.gameContainer.y = getNormalizedWorldYPosition( this._touchZoomModel.gameContainer.y );
			}
		}

		private function getNormalizedWorldXPosition( x:Number ):Number
		{
			return Math.max( -this._touchZoomModel.gameContainer.width + this._touchZoomModel.gameContainer.stage.stageWidth, Math.min( 0, x ) );
		}

		private function getNormalizedWorldYPosition( y:Number ):Number
		{
			return Math.max( -this._touchZoomModel.gameContainer.height + this._touchZoomModel.gameContainer.stage.stageHeight, Math.min( 0, y ) );
		}

		public function getIsZoomInProgress():Boolean
		{
			return this._touchZoomModel.isZoomInProgress;
		}

		override public function dispose():void
		{
			if( this._touchZoomModel.gameContainer )
			{
				this._touchZoomModel.gameContainer.removeEventListener( TouchEvent.TOUCH, this.onTouchHandler );
			}

			super.dispose();
		}
	}
}