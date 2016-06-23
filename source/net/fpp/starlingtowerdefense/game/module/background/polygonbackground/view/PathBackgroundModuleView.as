/**
 * Created by newkrok on 14/02/16.
 */
package net.fpp.starlingtowerdefense.game.module.background.polygonbackground.view
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;

	import net.fpp.common.starling.module.AModel;
	import net.fpp.common.starling.module.AModuleView;
	import net.fpp.starlingtowerdefense.game.config.terraintexture.PolygonBackgroundTerrainTextureConfig;
	import net.fpp.starlingtowerdefense.game.module.background.polygonbackground.PolygonBackgroundModel;
	import net.fpp.starlingtowerdefense.game.module.background.polygonbackground.vo.PolygonBackgroundTerrainTextureVO;
	import net.fpp.starlingtowerdefense.util.BrushPattern;
	import net.fpp.starlingtowerdefense.vo.PolygonBackgroundVO;

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;

	public class PathBackgroundModuleView extends AModuleView
	{
		private const MAXIMUM_TEXTURE_SIZE:uint = 2048;

		private var _backgroundModel:PolygonBackgroundModel;

		private var _polygonLayer:Sprite;

		public function PathBackgroundModuleView()
		{
		}

		override public function setModel( model:AModel ):void
		{
			this._backgroundModel = model as PolygonBackgroundModel;

			super.setModel( model );
		}

		override protected function onInit():void
		{
			this._polygonLayer = new Sprite();
			this.addChild( this._polygonLayer );
		}

		public function drawPathPolygons():void
		{
			var polygons:Vector.<PolygonBackgroundVO> = this._backgroundModel.polygonBackroundVOs;

			for( var i:int = 0; i < polygons.length; i++ )
			{
				this._polygonLayer.addChild( this.createPathPolygon( polygons[ i ] ) );
			}
		}

		public function createPathPolygon( polygonBackgroundVO:PolygonBackgroundVO ):Sprite
		{
			var pathPolygon:Sprite = new Sprite();

			var terrainTextureVO:PolygonBackgroundTerrainTextureVO = PolygonBackgroundTerrainTextureConfig.instance.getTerrainTextureVO( polygonBackgroundVO.terrainTextureId );

			var terrainGroundTexture:BitmapData = this._backgroundModel.getTerrainById( terrainTextureVO.borderTextureId ).bitmapData;
			var terrainFillTexture:BitmapData = this._backgroundModel.getTerrainById( terrainTextureVO.contentTextureId ).bitmapData;

			var generatedTerrain:BrushPattern = new BrushPattern( polygonBackgroundVO.polygon, terrainGroundTexture, terrainFillTexture, 30, 40 );
			var xPieceCount:uint = Math.ceil( generatedTerrain.width / MAXIMUM_TEXTURE_SIZE );
			var yPieceCount:uint = Math.ceil( generatedTerrain.height / MAXIMUM_TEXTURE_SIZE );

			for( var i:int = 0; i < xPieceCount; i++ )
			{
				for( var j:int = 0; j < yPieceCount; j++ )
				{
					var tmpBitmapData:BitmapData = new BitmapData( MAXIMUM_TEXTURE_SIZE, MAXIMUM_TEXTURE_SIZE, true, 0x60 );
					var offsetMatrix:Matrix = new Matrix;
					offsetMatrix.tx = -i * MAXIMUM_TEXTURE_SIZE;
					offsetMatrix.ty = -j * MAXIMUM_TEXTURE_SIZE;
					tmpBitmapData.draw( generatedTerrain, offsetMatrix );

					var piece:Image = new Image( Texture.fromBitmap( new Bitmap( tmpBitmapData ) ) );
					piece.x = i * MAXIMUM_TEXTURE_SIZE;
					piece.y = j * MAXIMUM_TEXTURE_SIZE;
					piece.touchable = false;
					pathPolygon.addChild( piece );

					tmpBitmapData.dispose();
					tmpBitmapData = null;
				}
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