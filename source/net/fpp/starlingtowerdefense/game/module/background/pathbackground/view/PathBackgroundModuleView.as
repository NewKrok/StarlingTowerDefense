/**
 * Created by newkrok on 14/02/16.
 */
package net.fpp.starlingtowerdefense.game.module.background.pathbackground.view
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;

	import net.fpp.common.starling.module.AModel;
	import net.fpp.common.starling.module.AModuleView;

	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.textures.Texture;

	import net.fpp.starlingtowerdefense.game.module.background.pathbackground.PathBackgroundModel;
	import net.fpp.starlingtowerdefense.game.module.background.pathbackground.constant.CTerrainType;
	import net.fpp.starlingtowerdefense.utils.BrushPattern;

	public class PathBackgroundModuleView extends AModuleView
	{
		private var _backgroundModel:PathBackgroundModel;

		private var _polygonLayer:Sprite;

		public function PathBackgroundModuleView()
		{
		}

		override public function setModel( model:AModel ):void
		{
			this._backgroundModel = model as PathBackgroundModel;

			super.setModel( model );
		}

		override protected function onInit():void
		{
			this._polygonLayer = new Sprite();
			this.addChild( this._polygonLayer );
		}

		public function drawPathPolygons():void
		{
			var polygons:Vector.<Vector.<Point>> = this._backgroundModel.pathPolygons;

			for( var i:int = 0; i < polygons.length; i++ )
			{
				this._polygonLayer.addChild( this.createPathPolygon( polygons[ i ] ) );
			}

			this.addChildAt( new Quad( this.width, this.height, 0 ), 0 );
		}

		public function createPathPolygon( polygon:Vector.<Point> ):Sprite
		{
			var pathPolygon:Sprite = new Sprite();

			var terrainGroundTexture:BitmapData = this._backgroundModel.getTerrainById( CTerrainType.TERRAIN_0_BORDER ).bitmapData;
			var terrainFillTexture:BitmapData = this._backgroundModel.getTerrainById( CTerrainType.TERRAIN_0_CONTENT ).bitmapData;

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
				pathPolygon.addChild( piece );

				tmpBitmapData.dispose();
				tmpBitmapData = null;
			}

			terrainGroundTexture.dispose();
			terrainGroundTexture = null;
			terrainFillTexture.dispose();
			terrainFillTexture = null;

			generatedTerrain.dispose();
			generatedTerrain = null;

			return pathPolygon;
		}

		override public function dispose():void
		{
			this._backgroundModel = null;

			this._polygonLayer.removeFromParent( true );
			this._polygonLayer = null;
		}
	}
}