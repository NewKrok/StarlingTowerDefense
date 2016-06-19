/**
 * Created by newkrok on 14/02/16.
 */
package net.fpp.starlingtowerdefense.game.service.level
{
	import assets.level.Area0DataVO;

	import flash.utils.getQualifiedClassName;

	import net.fpp.starlingtowerdefense.config.ImportParserConfig;
	import net.fpp.starlingtowerdefense.config.vo.ImportParserConfigVO;
	import net.fpp.starlingtowerdefense.parser.IParser;
	import net.fpp.starlingtowerdefense.vo.LevelDataVO;

	public class LevelDataService
	{
		private var _importParserConfig:ImportParserConfig;

		private var _areaDatas:Vector.<AreaDataVO> = new <AreaDataVO>[
			new Area0DataVO()
		];

		public function loadAreaData( area:uint ):void
		{
			if( !this._importParserConfig )
			{
				this._importParserConfig = new ImportParserConfig();
			}

			if( !this._areaDatas[ area ].levelDatas )
			{
				var levelDatas:Vector.<LevelDataVO> = new Vector.<LevelDataVO>;

				for( var i:int = 0; i < this._areaDatas[ area ].jsonLevelDatas.length; i++ )
				{
					levelDatas.push( this.convertJSONDataToLevelDataVO( JSON.parse( this._areaDatas[ area ].jsonLevelDatas[ i ] ) ) );
				}

				this._areaDatas[ area ].levelDatas = levelDatas;
			}
		}

		private function convertJSONDataToLevelDataVO( data:Object ):LevelDataVO
		{
			var levelData:LevelDataVO = new LevelDataVO;
			levelData.createEmptyDatas();

			for( var key:String in data )
			{
				levelData[ key ] = this.parse( data[ key ], levelData[ key ] );
			}

			return levelData;
		}

		private function parse( source:Object, target:Object ):Object
		{
			for( var i:int = 0; i < this._importParserConfig.config.length; i++ )
			{
				var rule:ImportParserConfigVO = this._importParserConfig.config[ i ];

				if( getQualifiedClassName( rule.entryType ) == getQualifiedClassName( target ) )
				{
					var parser:IParser = new rule.parserClass();
					return parser.parse( source );
				}
			}

			return null;
		}

		public function getLevelData( area:uint, level:uint ):LevelDataVO
		{
			return this._areaDatas[ area ].levelDatas[ level ];
		}
	}
}