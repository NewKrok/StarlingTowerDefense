/**
 * Created by newkrok on 15/05/16.
 */
package net.fpp.starlingtowerdefense.game.config.terraintexture
{
	import net.fpp.starlingtowerdefense.game.module.background.polygonbackground.constant.CPolygonBackgroundTerrainTextureId;
	import net.fpp.starlingtowerdefense.game.module.background.polygonbackground.vo.PolygonBackgroundTerrainTextureVO;

	public class PolygonBackgroundTerrainTextureConfig
	{
		private static var _instance:PolygonBackgroundTerrainTextureConfig;

		private var _configs:Vector.<PolygonBackgroundTerrainTextureVO>;

		public function PolygonBackgroundTerrainTextureConfig()
		{
			this._configs = new <PolygonBackgroundTerrainTextureVO>[
				new PolygonBackgroundTerrainTextureVO( CPolygonBackgroundTerrainTextureId.TERRAIN_0, 'terrain_0_border', 'terrain_0_content' ),
				new PolygonBackgroundTerrainTextureVO( CPolygonBackgroundTerrainTextureId.TERRAIN_1, 'terrain_1_border', 'terrain_1_content' ),
				new PolygonBackgroundTerrainTextureVO( CPolygonBackgroundTerrainTextureId.TERRAIN_2, 'terrain_2_border', 'terrain_2_content' ),
				new PolygonBackgroundTerrainTextureVO( CPolygonBackgroundTerrainTextureId.TERRAIN_3, 'terrain_3_border', 'terrain_3_content' )
			];
		}

		public function getTerrainTextureVO( terrainTextureId:String ):PolygonBackgroundTerrainTextureVO
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

		public function getTerrainTextureList():Vector.<PolygonBackgroundTerrainTextureVO>
		{
			return this._configs;
		}

		public static function get instance():PolygonBackgroundTerrainTextureConfig
		{
			if( _instance )
			{
				return _instance;
			}
			else
			{
				_instance = new PolygonBackgroundTerrainTextureConfig();

				return _instance;
			}
		}
	}
}