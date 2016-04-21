/**
 * Created by newkrok on 14/02/16.
 */
package starlingtowerdefense.game.module.background.view
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;

	import starling.display.Image;

	import starling.display.Sprite;
	import starling.textures.Texture;

	import starlingtowerdefense.game.module.background.constant.CTerrainType;

	import starlingtowerdefense.game.service.terraintexture.TerrainTextureService;

	import starlingtowerdefense.utils.BrushPattern;

	public class PolygonView extends Sprite
	{
		public function PolygonView( terrainTextureService:TerrainTextureService, polygon:Vector.<Point> )
		{
			var terrainGroundTexture:BitmapData = terrainTextureService.get( CTerrainType.TERRAIN_0_BORDER );
			var terrainFillTexture:BitmapData = terrainTextureService.get( CTerrainType.TERRAIN_0_CONTENT );

			var generatedTerrain:BrushPattern = new BrushPattern( polygon, terrainGroundTexture, terrainFillTexture, 30, 40 );
			var maxBlockSize:uint = 2048;
			var pieces:uint = Math.ceil( generatedTerrain.width / maxBlockSize );

			for( var i:int = 0; i < pieces; i++ )
			{
				var tmpBitmapData:BitmapData = new BitmapData( maxBlockSize, maxBlockSize, true, 0x60 );
				var offsetMatrix:Matrix = new Matrix;
				offsetMatrix.tx = -i * maxBlockSize;
				tmpBitmapData.draw( generatedTerrain, offsetMatrix );

				var piece:Image = new Image( Texture.fromBitmap( new Bitmap( tmpBitmapData ) ) );
				piece.x = i * maxBlockSize / 2;
				piece.touchable = false;
				this.addChild( piece );

				tmpBitmapData.dispose();
				tmpBitmapData = null;
			}

			terrainGroundTexture.dispose();
			terrainGroundTexture = null;
			terrainFillTexture.dispose();
			terrainFillTexture = null;

			generatedTerrain.dispose();
			generatedTerrain = null;
		}
	}
}