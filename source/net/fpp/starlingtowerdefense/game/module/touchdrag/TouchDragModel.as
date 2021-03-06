/**
 * Created by newkrok on 08/05/16.
 */
package net.fpp.starlingtowerdefense.game.module.touchdrag
{
	import net.fpp.common.geom.SimplePoint;
	import net.fpp.common.starling.module.AModel;

	public class TouchDragModel extends AModel
	{
		public var touchStartPoint:SimplePoint = new SimplePoint();
		public var isTouched:Boolean;
		public var lastTouchPoint:SimplePoint;
		public var swipeForce:Number;
		public var swipeDirection:Number;
		public var isTouchDragged:Boolean;
	}
}