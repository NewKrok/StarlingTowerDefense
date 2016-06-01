/**
 * Created by newkrok on 01/06/16.
 */
package net.fpp.starlingtowerdefense.vo
{
	public class EnemyPathDataVO
	{
		public var id:String;
		public var enemyPathPoints:Vector.<EnemyPathPointVO>;

		public function EnemyPathDataVO( id:String = '', enemyPathPoints:Vector.<EnemyPathPointVO> = null )
		{
			this.id = id;
			this.enemyPathPoints = enemyPathPoints;
		}
	}
}