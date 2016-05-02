/**
 * Created by newkrok on 20/03/16.
 */
package net.fpp.starlingtowerdefense.game.module.helper
{
	import flash.utils.Dictionary;

	import net.fpp.starlingtowerdefense.game.module.unit.constant.CArmorType;
	import net.fpp.starlingtowerdefense.game.module.unit.constant.CAttackType;

	public class DamageCalculator
	{
		private var _damageMultipleByArmorMaifest:Dictionary;

		public function DamageCalculator()
		{
			this._damageMultipleByArmorMaifest = new Dictionary();

			this._damageMultipleByArmorMaifest[CArmorType.NORMAL + CAttackType.NORMAL] = .75;
			this._damageMultipleByArmorMaifest[CArmorType.NORMAL + CAttackType.PIERCING] = 1.25;
			this._damageMultipleByArmorMaifest[CArmorType.NORMAL + CAttackType.MAGIC] = 1;

			this._damageMultipleByArmorMaifest[CArmorType.HEAVY + CAttackType.NORMAL] = 1;
			this._damageMultipleByArmorMaifest[CArmorType.HEAVY + CAttackType.PIERCING] = .75;
			this._damageMultipleByArmorMaifest[CArmorType.HEAVY + CAttackType.MAGIC] = 1.25;

			this._damageMultipleByArmorMaifest[CArmorType.MAGIC + CAttackType.NORMAL] = 1.25;
			this._damageMultipleByArmorMaifest[CArmorType.MAGIC + CAttackType.PIERCING] = 1;
			this._damageMultipleByArmorMaifest[CArmorType.MAGIC + CAttackType.MAGIC] = .75;
		}

		public function calculateDamageByAttackAndArmorType( damage:Number, attackType:String, armorType:String ):Number
		{
			return damage * this._damageMultipleByArmorMaifest[armorType + attackType];
		}

		public function getAttackByMinAndMax( min:Number, max:Number ):Number
		{
			var difference:Number = max - min;

			return Math.round( min + Math.random() * difference );
		}
	}
}