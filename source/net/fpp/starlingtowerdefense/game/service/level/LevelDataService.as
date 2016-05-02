/**
 * Created by newkrok on 14/02/16.
 */
package net.fpp.starlingtowerdefense.game.service.level
{
	import flash.geom.Point;

	import assets.level.Area0DataVO;
	import net.fpp.starlingtowerdefense.vo.LevelDataVO;

	public class LevelDataService
	{
		private var _areaDatas:Vector.<AreaDataVO> = new <AreaDataVO>[
			new Area0DataVO()
		];

		public function loadAreaData( area:uint ):void
		{
			if( !this._areaDatas[ area ].levelDatas )
			{
				var levelDatas:Vector.<LevelDataVO> = new Vector.<LevelDataVO>;

				for( var i:int = 0; i < this._areaDatas[ area ].jsonLevelDatas.length; i++ )
				{
					levelDatas.push( this.convertJSONDataToLevelDataVO( this._areaDatas[ area ].jsonLevelDatas[ i ] ) );
				}

				this._areaDatas[ area ].levelDatas = levelDatas;
			}
		}

		private function convertJSONDataToLevelDataVO( pureJSONData:String ):LevelDataVO
		{
			var data:Object = JSON.parse( pureJSONData );

			var result:LevelDataVO = new LevelDataVO();

			for( var key:String in data )
			{
				if ( key == 'polygons' )
				{
					result.polygons = new Vector.<Vector.<Point>>;
					for ( var i:int = 0; i < data.polygons.length; i++ )
					{
						result.polygons.push( new Vector.<Point> );
						for ( var j:int = 0; j < data.polygons[i].length; j++ )
						{
							result.polygons[i].push( new Point( data.polygons[i][j].x, data.polygons[i][j].y ) );
						}
					}
				}
				else
				{
					result[ key ] = data[ key ];
				}
			}

			return result;
		}

		public function getLevelData( area:uint, level:uint ):LevelDataVO
		{
			return this._areaDatas[ area ].levelDatas[ level ];
		}
	}
}