/**
 * Created by newkrok on 14/02/16.
 */
package net.fpp.starlingtowerdefense.vo
{
	public class LevelDataVO
	{
		public var polygonBackgroundData:Vector.<PolygonBackgroundVO>;
		public var rectangleBackgroundData:Vector.<RectangleBackgroundVO>;
		public var enemyPathData:Vector.<EnemyPathDataVO>;
		public var libraryElements:Array;

		public function createEmptyDatas():void
		{
			this.polygonBackgroundData = new <PolygonBackgroundVO>[];
			this.rectangleBackgroundData = new <RectangleBackgroundVO>[];
			this.enemyPathData = new <EnemyPathDataVO>[];
			this.libraryElements = [];
		}
	}
}