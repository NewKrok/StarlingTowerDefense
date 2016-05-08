/**
 * Created by newkrok on 05/05/16.
 */
package net.fpp.starlingtowerdefense.game.module.touchzoom
{
	import net.fpp.common.geom.SimplePoint;
	import net.fpp.common.starling.module.AModel;

	import starling.display.DisplayObjectContainer;

	public class TouchZoomModel extends AModel
	{
		public var gameContainer:DisplayObjectContainer;

		public var zoomValue:Number;
		public var zoomStartOffset:Number = 0;
		public var zoomValueAtStart:Number = 0;

		public var zoomMiddlePoint:SimplePoint;
		public var zoomPointOffset:SimplePoint = new SimplePoint();

		public var isZoomInProgress:Boolean;
	}
}