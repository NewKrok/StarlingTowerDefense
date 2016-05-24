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
				new RectangleBackgroundTerrainTextureVO( CRectangleBackgroundTerrainTextureId.TERRAIN_0, 'terrain_4_content' ),
				new RectangleBackgroundTerrainTextureVO( CRectangleBackgroundTerrainTextureId.TERRAIN_1, 'terrain_3_content' ),
				new RectangleBackgroundTerrainTextureVO( CRectangleBackgroundTerrainTextureId.TERRAIN_2, 'terrain_2_content' ),
				new RectangleBackgroundTerrainTextureVO( CRectangleBackgroundTerrainTextureId.TERRAIN_3, 'terrain_1_content' )
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