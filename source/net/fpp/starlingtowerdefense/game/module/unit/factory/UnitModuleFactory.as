/**
 * Created by newkrok on 09/07/16.
 */
package net.fpp.starlingtowerdefense.game.module.unit.factory
{
	import net.fpp.common.util.objectpool.IPoolableObject;
	import net.fpp.common.util.objectpool.IPoolableObjectFactory;
	import net.fpp.starlingtowerdefense.game.module.unit.UnitModule;

	public class UnitModuleFactory implements IPoolableObjectFactory
	{
		public function createObject():IPoolableObject
		{
			return new UnitModule();
		}
	}
}