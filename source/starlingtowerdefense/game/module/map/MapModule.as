/**
 * Created by newkrok on 13/03/16.
 */
package starlingtowerdefense.game.module.map
{
	import net.fpp.starling.module.AModule;

	import starlingtowerdefense.game.module.map.vo.MapNodeVO;

	public class MapModule extends AModule implements IMapModule
	{
		private var _mapModel:MapModel;

		public function MapModule()
		{
			this._mapModel = this.createModel( MapModel ) as MapModel;

			for ( var i:int = 0; i < 15; i++ )
			{
				this._mapModel.mapNodes.push( new <MapNodeVO>[] );
				for ( var j:int = 0; j < 10; j++ )
				{
					this._mapModel.mapNodes[i].push( new MapNodeVO( i, j ) );
				}
			}

			/*this._mapModel.mapNodes[9][0].isWalkable = false;
			this._mapModel.mapNodes[7][1].isWalkable = false;
			this._mapModel.mapNodes[7][2].isWalkable = false;
			this._mapModel.mapNodes[7][3].isWalkable = false;
			this._mapModel.mapNodes[8][5].isWalkable = false;
			this._mapModel.mapNodes[6][5].isWalkable = false;
			this._mapModel.mapNodes[5][6].isWalkable = false;*/
		}

		public function getMapNodes():Vector.<Vector.<MapNodeVO>>
		{
			return this._mapModel.mapNodes;
		}
	}
}