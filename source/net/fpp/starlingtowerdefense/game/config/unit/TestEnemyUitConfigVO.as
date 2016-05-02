/**
 * Created by newkrok on 20/03/16.
 */
package net.fpp.starlingtowerdefense.game.config.unit
{
	import net.fpp.starlingtowerdefense.game.module.unit.constant.CArmorType;
	import net.fpp.starlingtowerdefense.game.module.unit.constant.CAttackType;
	import net.fpp.starlingtowerdefense.game.module.unit.vo.UnitConfigVO;

	public class TestEnemyUitConfigVO extends UnitConfigVO
	{
		public function TestEnemyUitConfigVO()
		{
			this.name = 'tst enemy';

			this.sizeRadius = 30;
			this.attackRadius = 90;
			this.unitDetectionRadius = 150;

			this.armor = 0;
			this.armorType = CArmorType.NORMAL;

			this.blockChance = 2;

			this.minDamage = 10;
			this.maxDamage = 15;

			this.areaDamage = 0;
			this.areaDamageSize = 0;

			this.attackSpeed = 1;
			this.attackType = CAttackType.NORMAL;

			this.criticalHitChance = .01;
			this.criticalHitDamageMultiple = 1.5;

			this.damageDelay = .5;

			this.maxLife = 5000;
			this.lifeRegeneration = 2;

			this.movementSpeed = 100;
		}
	}
}