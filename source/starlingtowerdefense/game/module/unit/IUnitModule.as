/**
 * Created by newkrok on 07/01/16.
 */
package starlingtowerdefense.game.module.unit
{
	import net.fpp.starling.module.IModule;

	import starlingtowerdefense.game.service.pathfinder.vo.RouteVO;

	public interface IUnitModule extends IModule
	{
		function setPosition( x:Number, y:Number ):void;

		function moveTo( routeVO:RouteVO ):void;

		function attack():void;

		function changeSkin():void;

		function getSizeRadius():Number;

		function asd():void;
	}
}