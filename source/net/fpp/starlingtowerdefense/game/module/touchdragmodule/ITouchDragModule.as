/**
 * Created by newkrok on 08/05/16.
 */
package net.fpp.starlingtowerdefense.game.module.touchdragmodule
{
	import net.fpp.common.starling.module.IModule;

	import starling.display.DisplayObjectContainer;

	public interface ITouchDragModule extends IModule
	{
		function setGameContainer( value:DisplayObjectContainer ):void;

		function update():void;

		function getIsTouchDragged():Boolean
	}
}