/**
 * Created by newkrok on 15/05/16.
 */
package net.fpp.starlingtowerdefense.game.module.background.polygonbackground.vo
{
	public class PolygonBackgroundTerrainTextureVO
	{
		public var id:String;
		public var borderTextureId:String;
		public var contentTextureId:String;

		public function PolygonBackgroundTerrainTextureVO( id:String, borderTextureId:String, contentTextureId:String )
		{
			this.id = id;
			this.borderTextureId = borderTextureId;
			this.contentTextureId = contentTextureId;
		}
	}
}