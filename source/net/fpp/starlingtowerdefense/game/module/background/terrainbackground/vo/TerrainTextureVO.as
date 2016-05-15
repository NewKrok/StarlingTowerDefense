/**
 * Created by newkrok on 15/05/16.
 */
package net.fpp.starlingtowerdefense.game.module.background.terrainbackground.vo
{
	public class TerrainTextureVO
	{
		public var id:String;
		public var borderTextureId:String;
		public var contentTextureId:String;

		public function TerrainTextureVO( id:String, borderTextureId:String, contentTextureId:String )
		{
			this.id = id;
			this.borderTextureId = borderTextureId;
			this.contentTextureId = contentTextureId;
		}
	}
}