/**
 * Created by newkrok on 08/05/16.
 */
package net.fpp.starlingtowerdefense.game.module.touchdrag
{
	import net.fpp.common.starling.module.IUpdatableModule;

	import starling.display.DisplayObjectContainer;

	public interface ITouchDragModule extends IUpdatableModule
	{
		function getIsTouchDragged():Boolean
	}
}