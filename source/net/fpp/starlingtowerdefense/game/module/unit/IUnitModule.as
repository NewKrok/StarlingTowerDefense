/**
 * Created by newkrok on 07/01/16.
 */
package net.fpp.starlingtowerdefense.game.module.unit
{
	import net.fpp.common.geom.SimplePoint;
	import net.fpp.common.starling.module.IModule;
	import net.fpp.common.util.pathfinding.vo.PathVO;

	public interface IUnitModule extends IModule
	{
		function setPosition( x:Number, y:Number ):void;

		function getPosition():SimplePoint;

		function moveTo( pathVO:PathVO ):void;

		function attack():void;

		function damage( value:Number ):void;

		function changeSkin( type:int ):void;

		function getSizeRadius():Number;

		function getPlayerGroup():String;

		function setPlayerGroup( value:String ):void;

		function getTarget():IUnitModule

		function removeTarget():void

		function setTarget( value:IUnitModule ):void;

		function getIsMoving():Boolean;

		function getIsDead():Boolean;

		function getArmorType():String;

		function getAttackRadius():Number;

		function getUnitDetectionRadius():Number;
	}
}