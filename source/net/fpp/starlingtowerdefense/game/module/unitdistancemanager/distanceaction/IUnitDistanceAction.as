/**
 * Created by newkrok on 19/07/16.
 */
package net.fpp.starlingtowerdefense.game.module.unitdistancemanager.distanceaction
{
	import net.fpp.starlingtowerdefense.game.module.unitdistancemanager.vo.UnitDistanceVO;

	public interface IUnitDistanceAction
	{
		function execute( value:UnitDistanceVO ):void;
	}
}