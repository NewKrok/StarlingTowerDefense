/**
 * Created by newkrok on 20/07/16.
 */
package net.fpp.starlingtowerdefense.game.config.unit
{
	import net.fpp.starlingtowerdefense.game.module.unit.vo.UnitConfigVO;

	public class UnitTypeList
	{
		public static var list:Vector.<UnitConfigVO> = new <UnitConfigVO> [
			new WarriorUnitConfigVO, new ArcherUnitConfigVO(), new MageUnitConfigVO()
		];
	}
}