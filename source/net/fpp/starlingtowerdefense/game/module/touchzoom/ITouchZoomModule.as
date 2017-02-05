/**
 * Created by newkrok on 05/05/16.
 */
package net.fpp.starlingtowerdefense.game.module.touchzoom
{
	import net.fpp.common.starling.module.IModule;

	import starling.display.DisplayObjectContainer;

	public interface ITouchZoomModule extends IModule
	{
		function getIsZoomInProgress():Boolean;
	}
}