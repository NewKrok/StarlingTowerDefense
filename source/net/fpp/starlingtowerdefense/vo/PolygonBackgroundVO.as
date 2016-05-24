/**
 * Created by newkrok on 22/05/16.
 */
package net.fpp.starlingtowerdefense.vo
{
	import net.fpp.common.geom.SimplePoint;

	public class PolygonBackgroundVO
	{
		public var terrainTextureId:String;
		public var polygon:Vector.<SimplePoint>;

		public function PolygonBackgroundVO( terrainTextureId:String = '', polygon:Vector.<SimplePoint> = null )
		{
			this.terrainTextureId = terrainTextureId;
			this.polygon = polygon;
		}
	}
}