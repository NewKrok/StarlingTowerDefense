/**
 * Created by newkrok on 25/06/16.
 */
package net.fpp.starlingtowerdefense.game.module.linebar
{
	import net.fpp.common.geom.SimplePoint;
	import net.fpp.common.starling.module.IModule;

	public interface ILineBarModule extends IModule
	{
		function setBackgroundColor( value:uint ):void;

		function setBackgroundAlpha( value:Number ):void;

		function setLineColor( value:uint ):void;

		function setViewSize( value:SimplePoint ):void;

		function setPercentage( value:Number ):void;
	}
}