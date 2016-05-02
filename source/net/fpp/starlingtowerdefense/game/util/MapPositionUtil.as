/**
 * Created by newkrok on 01/05/16.
 */
package net.fpp.starlingtowerdefense.game.util
{
	import net.fpp.common.geom.SimplePoint;

	import net.fpp.starlingtowerdefense.game.module.map.constant.CMapSize;

	public class MapPositionUtil
	{
		public static function changePositionToMapNodePoint( position:SimplePoint ):SimplePoint
		{
			return new SimplePoint(
					Math.floor( position.x / CMapSize.NODE_SIZE ),
					Math.floor( position.y / CMapSize.NODE_SIZE )
			);
		}

		public static function changeMapNodePointToPosition( mapNodePoint:SimplePoint ):SimplePoint
		{
			return new SimplePoint(
					mapNodePoint.x * CMapSize.NODE_SIZE + CMapSize.NODE_SIZE / 2,
					mapNodePoint.y * CMapSize.NODE_SIZE + CMapSize.NODE_SIZE / 2
			);
		}

		public static function changeMapNodePointVectorToPositionVector( mapNodePoints:Vector.<SimplePoint> ):Vector.<SimplePoint>
		{
			var result:Vector.<SimplePoint> = new <SimplePoint>[];

			for( var i:int = 0; i < mapNodePoints.length; i++ )
			{
				result.push( MapPositionUtil.changeMapNodePointToPosition( mapNodePoints[i] ) )
			}

			return result;
		}
	}
}