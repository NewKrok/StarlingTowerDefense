/**
 * Created by newkrok on 20/03/16.
 */
package net.fpp.starlingtowerdefense.game.config.unit
{
	import net.fpp.common.geom.SimplePoint;
	import net.fpp.starlingtowerdefense.constant.CSkin;
	import net.fpp.starlingtowerdefense.game.module.projectilemanager.vo.ProjectileSettingVO;
	import net.fpp.starlingtowerdefense.game.module.unit.constant.CArmorType;
	import net.fpp.starlingtowerdefense.game.module.unit.constant.CAttackType;
	import net.fpp.starlingtowerdefense.game.module.unit.vo.UnitConfigVO;

	public class HeroArcherUnitConfigVO extends UnitConfigVO
	{
		public function HeroArcherUnitConfigVO()
		{
			this.name = 'Hero Archer';
			this.skeleton = 'Archer';

			this.sizeRadius = 30;
			this.unitHeight = 100;

			this.attackRadius = 320;
			this.unitDetectionRadius = 320;

			this.armor = 0;
			this.armorType = CArmorType.MAGIC;

			this.blockChance = 2;

			this.projectileConfigVO = new ProjectileSettingVO();
			this.projectileConfigVO.skinId = CSkin.ARCHER_ARROW;
			this.projectileConfigVO.minDamage = 25;
			this.projectileConfigVO.maxDamage = 35;
			this.projectileConfigVO.attackType = CAttackType.PIERCING;
			this.projectileConfigVO.speed = 300;
			this.projectileConfigVO.isEnemyFollower = false;
			this.projectileConfigVO.startPointOffset = new SimplePoint( 30, -50 );
			this.projectileConfigVO.projectileArcHeight = 60;

			this.minDamage = 3;
			this.maxDamage = 7;

			this.areaDamage = 0;
			this.areaDamageRadius = 0;

			this.attackSpeed = .5;
			this.attackAnimationSpeed = .4;
			this.attackType = CAttackType.NORMAL;

			this.criticalHitChance = .01;
			this.criticalHitDamageMultiple = 1.5;

			this.attackActionDelay = .4;

			this.maxLife = 200;
			this.lifeRegeneration = 2;

			this.maxMana = 10;
			this.manaRegeneration = 2;

			this.movementSpeed = 90;
		}
	}
}