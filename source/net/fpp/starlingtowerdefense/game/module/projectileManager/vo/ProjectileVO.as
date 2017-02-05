/**
 * Created by newkrok on 26/06/16.
 */
package net.fpp.starlingtowerdefense.game.module.projectilemanager.vo
{
	import net.fpp.starlingtowerdefense.game.module.unit.IUnitModule;

	public class ProjectileVO
	{
		public var projectileConfigVO:ProjectileSettingVO;
		public var owner:IUnitModule;
		public var target:IUnitModule;

		public function ProjectileVO()
		{
		}
	}
}