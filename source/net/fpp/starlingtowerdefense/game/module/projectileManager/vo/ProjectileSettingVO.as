/**
 * Created by newkrok on 26/06/16.
 */
package net.fpp.starlingtowerdefense.game.module.projectileManager.vo
{
	import net.fpp.common.geom.SimplePoint;

	public class ProjectileSettingVO
	{
		public var skinId:String;
		public var speed:Number;
		public var isEnemyFollower:Boolean;
		public var startPointOffset:SimplePoint;
		public var projectileArcHeight:Number = 0;
		public var minDamage:Number;
		public var maxDamage:Number;
		public var attackType:String;

		public function ProjectileSettingVO()
		{
		}
	}
}