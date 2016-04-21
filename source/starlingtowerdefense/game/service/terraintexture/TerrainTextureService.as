/**
 * Created by newkrok on 21/04/16.
 */
package starlingtowerdefense.game.service.terraintexture
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;

	import net.fpp.starling.module.AService;

	public class TerrainTextureService extends AService
	{
		private var _terrainTextureList:Dictionary;

		public function processAtlas( bitmap:Bitmap, atlasDescription:String ):void
		{
			this._terrainTextureList = new Dictionary();

			var defaultBitmapData:BitmapData = bitmap.bitmapData;
			var description:Object = JSON.parse( atlasDescription );

			for( var key:String in description.frames )
			{
				var terrainTextureVO:TerrainTextureVO = new TerrainTextureVO();
				terrainTextureVO.id = key;

				var bitmapData:BitmapData = new BitmapData(
						description.frames[ key ].spriteSourceSize.w,
						description.frames[ key ].spriteSourceSize.h
				);

				bitmapData.copyPixels(
						defaultBitmapData,
						new Rectangle(
								description.frames[ key ].frame.x,
								description.frames[ key ].frame.y,
								description.frames[ key ].frame.w,
								description.frames[ key ].frame.h
						),
						new Point()
				);

				terrainTextureVO.bitmapData = bitmapData;

				this._terrainTextureList[key] = terrainTextureVO;
			}

			defaultBitmapData.dispose();
			defaultBitmapData = null;
		}

		public function get( terrainType:String ):BitmapData
		{
			return this._terrainTextureList[terrainType].bitmapData;
		}
	}
}