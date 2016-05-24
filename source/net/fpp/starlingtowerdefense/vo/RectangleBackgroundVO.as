/**
 * Created by newkrok on 24/05/16.
 */
package net.fpp.starlingtowerdefense.vo
{
	import net.fpp.common.geom.SimplePoint;

	public class RectangleBackgroundVO
	{
		public var terrainTextureId:String;
		public var polygon:Vector.<SimplePoint>;

		public function RectangleBackgroundVO( terrainTextureId:String = '', polygon:Vector.<SimplePoint> = null )
		{
			this.terrainTextureId = terrainTextureId;
			this.polygon = polygon;
		}
	}
}