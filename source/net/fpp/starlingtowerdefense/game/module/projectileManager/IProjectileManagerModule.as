/**
 * Created by newkrok on 26/06/16.
 */
package net.fpp.starlingtowerdefense.game.module.projectilemanager
{
	import net.fpp.common.starling.module.IModule;
	import net.fpp.starlingtowerdefense.game.module.projectilemanager.vo.ProjectileVO;

	public interface IProjectileManagerModule extends IModule
	{
		function addProjectile( projectileVO:ProjectileVO ):void;
	}
}