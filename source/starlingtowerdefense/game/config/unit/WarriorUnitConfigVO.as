/**
 * Created by newkrok on 20/03/16.
 */
package starlingtowerdefense.game.config.unit
{
	import starlingtowerdefense.game.module.unit.constant.CArmorType;
	import starlingtowerdefense.game.module.unit.constant.CAttackType;
	import starlingtowerdefense.game.module.unit.vo.UnitConfigVO;

	public class WarriorUnitConfigVO extends UnitConfigVO
	{
		public function WarriorUnitConfigVO()
		{
			this.name = 'Warrior';

			this.sizeRadius = 25;
			this.attackRadius = 90;
			this.unitDetectionRadius = 150;

			this.armor = 0;
			this.armorType = CArmorType.HEAVY;

			this.blockChance = 2;

			this.minDamage = 10;
			this.maxDamage = 15;

			this.areaDamage = 0;
			this.areaDamageSize = 0;

			this.attackSpeed = 2;
			this.attackType = CAttackType.NORMAL;

			this.criticalHitChance = .01;
			this.criticalHitDamageMultiple = 1.5;

			this.damageDelay = .5;

			this.maxLife = 30;
			this.lifeRegeneration = 2;

			this.movementSpeed = 100;
		}
	}
}