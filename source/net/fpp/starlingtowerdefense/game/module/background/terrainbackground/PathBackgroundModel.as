/**
 * Created by newkrok on 14/02/16.
 */
package net.fpp.starlingtowerdefense.game.module.background.terrainbackground
{
	import flash.geom.Point;

	import net.fpp.common.starling.module.AModel;
	import net.fpp.common.util.jsonbitmapatlas.vo.BitmapDataVO;

	public class PathBackgroundModel extends AModel
	{
		public var pathPolygons:Vector.<Vector.<Point>>;

		private var _terrains:Vector.<BitmapDataVO>;

		public function setTerrains( value:Vector.<BitmapDataVO> ):void
		{
			this._terrains = value;
		}

		public function getTerrainById( terrainId:String ):BitmapDataVO
		{
			for( var i:int = 0; this._terrains.length; i++ )
			{
				if( this._terrains[ i ].id == terrainId )
				{
					return this._terrains[ i ];
				}
			}

			return null;
		}
	}
}