/**
 * Created by newkrok on 26/06/16.
 */
package net.fpp.starlingtowerdefense.game.module.projectileManager
{
	import net.fpp.common.starling.module.IUpdatableModule;
	import net.fpp.starlingtowerdefense.game.module.projectileManager.vo.ProjectileVO;

	public interface IProjectileManagerModule extends IUpdatableModule
	{
		function addProjectile( projectileVO:ProjectileVO ):void;
	}
}