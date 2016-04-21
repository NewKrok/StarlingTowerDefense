/**
 * Created by newkrok on 21/03/16.
 */
package starlingtowerdefense.game.module.distancechecker
{
	import starlingtowerdefense.game.module.unit.IUnitModule;

	public interface IDistanceCheckerModule
	{
		function update():void;

		function registerUnit( value:IUnitModule ):void;
	}
}