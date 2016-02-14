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

	import starlingtowerdefense.utils.BrushPattern;

	public class PolygonView extends Sprite
	{
		public function PolygonView( polygon:Vector.<Point> )
		{
			var terrainGroundTexture:BitmapData = new terrain_1;
			var terrainFillTexture:BitmapData = new terrain_0_content;

			var generatedTerrain:BrushPattern = new BrushPattern( polygon, terrainGroundTexture, terrainFillTexture, 30, 40 );
			var maxBlockSize:uint = 2048;
			var pieces:uint = Math.ceil( generatedTerrain.width / maxBlockSize );

			for( var i:int = 0; i < pieces; i++ )
			{
				var tmpBitmapData:BitmapData = new BitmapData( maxBlockSize, maxBlockSize, true, 0x60 );
				var offsetMatrix:Matrix = new Matrix;
				offsetMatrix.tx = -i * maxBlockSize;
				tmpBitmapData.draw( generatedTerrain, offsetMatrix );

				var piece:Image = Image.fromBitmap( new Bitmap( tmpBitmapData ), false, 2 );
				piece.x = i * maxBlockSize / 2;
				piece.touchable = false;
				this.addChild( piece );

				tmpBitmapData.dispose();
				tmpBitmapData = null;
			}

			this.flatten();

			terrainGroundTexture.dispose();
			terrainGroundTexture = null;
			terrainFillTexture.dispose();
			terrainFillTexture = null;

			generatedTerrain.dispose();
			generatedTerrain = null;
		}
	}
}