/**
 * Created by newkrok on 19/06/16.
 */
package net.fpp.starlingtowerdefense.game.module.background.rectanglebackground
{
	import net.fpp.common.starling.module.AModel;
	import net.fpp.common.util.jsonbitmapatlas.vo.BitmapDataVO;
	import net.fpp.starlingtowerdefense.vo.RectangleBackgroundVO;

	public class RectangleBackgroundModel extends AModel
	{
		public var rectangleBackgroundVOs:Vector.<RectangleBackgroundVO>;

		private var _terrains:Vector.<BitmapDataVO>;

		public function setTerrains( value:Vector.<BitmapDataVO> ):void
		{
			this._terrains = value;
		}

		public function getTerrainById( terrainId:String ):BitmapDataVO
		{
			for( var i:int = 0; i < this._terrains.length; i++ )
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