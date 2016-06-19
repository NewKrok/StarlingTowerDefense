/**
 * Created by newkrok on 24/05/16.
 */
package net.fpp.starlingtowerdefense.game.config.terraintexture
{
	import net.fpp.starlingtowerdefense.game.module.background.rectanglebackground.constant.CRectangleBackgroundTerrainTextureId;
	import net.fpp.starlingtowerdefense.game.module.background.rectanglebackground.vo.RectangleBackgroundTerrainTextureVO;

	public class RectangleBackgroundTerrainTextureConfig
	{
		private static var _instance:RectangleBackgroundTerrainTextureConfig;

		private var _configs:Vector.<RectangleBackgroundTerrainTextureVO>;

		public function RectangleBackgroundTerrainTextureConfig()
		{
			this._configs = new <RectangleBackgroundTerrainTextureVO>[
				new RectangleBackgroundTerrainTextureVO( CRectangleBackgroundTerrainTextureId.TERRAIN_0, 'rectangle_terrain_textures_0' ),
				new RectangleBackgroundTerrainTextureVO( CRectangleBackgroundTerrainTextureId.TERRAIN_1, 'rectangle_terrain_textures_1' ),
				new RectangleBackgroundTerrainTextureVO( CRectangleBackgroundTerrainTextureId.TERRAIN_2, 'rectangle_terrain_textures_2' ),
				new RectangleBackgroundTerrainTextureVO( CRectangleBackgroundTerrainTextureId.TERRAIN_3, 'rectangle_terrain_textures_3' ),
				new RectangleBackgroundTerrainTextureVO( CRectangleBackgroundTerrainTextureId.TERRAIN_4, 'rectangle_terrain_textures_4' ),
				new RectangleBackgroundTerrainTextureVO( CRectangleBackgroundTerrainTextureId.TERRAIN_5, 'rectangle_terrain_textures_5' )
			];
		}

		public function getTerrainTextureVO( terrainTextureId:String ):RectangleBackgroundTerrainTextureVO
		{
			for( var i:int = 0; i < this._configs.length; i++ )
			{
				if( this._configs[ i ].id == terrainTextureId )
				{
					return this._configs[ i ];
				}
			}

			return null;
		}

		public function getTerrainTextureList():Vector.<RectangleBackgroundTerrainTextureVO>
		{
			return this._configs;
		}

		public static function get instance():RectangleBackgroundTerrainTextureConfig
		{
			if( _instance )
			{
				return _instance;
			}
			else
			{
				_instance = new RectangleBackgroundTerrainTextureConfig();

				return _instance;
			}
		}
	}
}