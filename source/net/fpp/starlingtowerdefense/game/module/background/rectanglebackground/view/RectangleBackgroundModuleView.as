/**
 * Created by newkrok on 19/06/16.
 */
package net.fpp.starlingtowerdefense.game.module.background.rectanglebackground.view
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;

	import net.fpp.common.starling.StaticAssetManager;

	import net.fpp.common.starling.module.AModel;
	import net.fpp.common.starling.module.AModuleView;
	import net.fpp.starlingtowerdefense.game.config.terraintexture.RectangleBackgroundTerrainTextureConfig;
	import net.fpp.starlingtowerdefense.game.module.background.rectanglebackground.RectangleBackgroundModel;
	import net.fpp.starlingtowerdefense.game.module.background.rectanglebackground.vo.RectangleBackgroundTerrainTextureVO;
	import net.fpp.starlingtowerdefense.vo.RectangleBackgroundVO;

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;

	public class RectangleBackgroundModuleView extends AModuleView
	{
		private var backgroundImages:Vector.<Image> = new <Image>[];

		private var _backgroundModel:RectangleBackgroundModel;

		private var _rectangleLayer:Sprite;

		public function RectangleBackgroundModuleView()
		{
		}

		override public function setModel( model:AModel ):void
		{
			this._backgroundModel = model as RectangleBackgroundModel;

			super.setModel( model );
		}

		override protected function onInit():void
		{
			this._rectangleLayer = new Sprite();

			this.addChild( this._rectangleLayer );
		}

		public function drawRectangleBackgrounds():void
		{
			for( var i:int = 0; i < this._backgroundModel.rectangleBackgroundVOs.length; i++ )
			{
				this.drawRectangleBackground( this._backgroundModel.rectangleBackgroundVOs[ i ] );
			}
		}

		public function drawRectangleBackground( rectangleBackgroundVO:RectangleBackgroundVO ):void
		{
			var terrainTextureVO:RectangleBackgroundTerrainTextureVO = RectangleBackgroundTerrainTextureConfig.instance.getTerrainTextureVO( rectangleBackgroundVO.terrainTextureId );
			var terrainBitmapTexture:BitmapData = this._backgroundModel.getTerrainById( terrainTextureVO.contentTextureId ).bitmapData;
			var backgroundImage:Image = new Image( Texture.fromBitmapData( terrainBitmapTexture ) );

			backgroundImage.tileGrid = new Rectangle( 0, 0, terrainBitmapTexture.width, terrainBitmapTexture.height );
			backgroundImage.textureRepeat = true;

			var scaleFactor:Number = StaticAssetManager.instance.scaleFactor;

			backgroundImage.width = Math.abs( rectangleBackgroundVO.polygon[ 1 ].x - rectangleBackgroundVO.polygon[ 0 ].x ) * scaleFactor;
			backgroundImage.height = Math.abs( rectangleBackgroundVO.polygon[ 3 ].y - rectangleBackgroundVO.polygon[ 0 ].y ) * scaleFactor;

			this._rectangleLayer.addChild( backgroundImage );

			this.backgroundImages.push( backgroundImage );
		}

		override public function dispose():void
		{
			this._backgroundModel = null;

			this._rectangleLayer.removeFromParent( true );
			this._rectangleLayer = null;
		}
	}
}