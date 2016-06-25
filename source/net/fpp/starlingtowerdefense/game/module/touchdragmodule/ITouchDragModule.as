/**
 * Created by newkrok on 08/05/16.
 */
package net.fpp.starlingtowerdefense.game.module.touchdragmodule
{
	import net.fpp.common.starling.module.IUpdatableModule;

	import starling.display.DisplayObjectContainer;

	public interface ITouchDragModule extends IUpdatableModule
	{
		function setGameContainer( value:DisplayObjectContainer ):void;

		function getIsTouchDragged():Boolean
	}
}