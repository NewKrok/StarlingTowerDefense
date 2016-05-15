/**
 * Created by newkrok on 15/05/16.
 */
package net.fpp.starlingtowerdefense.game.config.terraintexture
{
	import net.fpp.starlingtowerdefense.game.module.background.terrainbackground.constant.CTerrainTextureId;
	import net.fpp.starlingtowerdefense.game.module.background.terrainbackground.vo.TerrainTextureVO;

	public class TerrainTextureConfig
	{
		private static var _instance:TerrainTextureConfig;

		private var _configs:Vector.<TerrainTextureVO>;

		public function TerrainTextureConfig()
		{
			this._configs = new <TerrainTextureVO>[
					new TerrainTextureVO( CTerrainTextureId.TERRAIN_0, 'terrain_0_border', 'terrain_0_content' ),
					new TerrainTextureVO( CTerrainTextureId.TERRAIN_1, 'terrain_1_border', 'terrain_1_content' ),
					new TerrainTextureVO( CTerrainTextureId.TERRAIN_2, 'terrain_2_border', 'terrain_2_content' ),
					new TerrainTextureVO( CTerrainTextureId.TERRAIN_3, 'terrain_3_border', 'terrain_3_content' )
			];
		}

		public function getTerrainTextureVO( terrainTextureId:String ):TerrainTextureVO
		{
			for ( var i:int = 0; i < this._configs.length; i++ )
			{
				if ( this._configs[i].id == terrainTextureId )
				{
					return this._configs[i];
				}
			}

			return null;
		}

		public function getTerrainTextureList():Vector.<TerrainTextureVO>
		{
			return this._configs;
		}

		public static function get instance():TerrainTextureConfig
		{
			if ( _instance )
			{
				return _instance;
			}
			else
			{
				_instance = new TerrainTextureConfig();

				return _instance;
			}
		}
	}
}