/**
 * Created by newkrok on 13/03/16.
 */
package net.fpp.starlingtowerdefense.game.module.map
{
	import net.fpp.common.starling.module.AModule;
	import net.fpp.common.util.pathfinding.vo.PathNodeVO;

	public class MapModule extends AModule implements IMapModule
	{
		private var _mapModel:MapModel;

		public function MapModule()
		{
			this._mapModel = this.createModel( MapModel ) as MapModel;

			for ( var i:int = 0; i < 40; i++ )
			{
				this._mapModel.mapNodes.push( new <PathNodeVO>[] );
				for ( var j:int = 0; j < 40; j++ )
				{
					this._mapModel.mapNodes[i].push( new PathNodeVO( i, j ) );
					if ( Math.random() > .8 )
					{
						this._mapModel.mapNodes[i][j].isWalkable = false;
					}
				}
			}

			/*this._mapModel.mapNodes[2][1].isWalkable = false;
			this._mapModel.mapNodes[2][2].isWalkable = false;
			this._mapModel.mapNodes[2][3].isWalkable = false;

			this._mapModel.mapNodes[3][2].isWalkable = false;
			this._mapModel.mapNodes[4][2].isWalkable = false;
			this._mapModel.mapNodes[5][2].isWalkable = false;*/
		}

		public function getMapNodes():Vector.<Vector.<PathNodeVO>>
		{
			return this._mapModel.mapNodes;
		}
	}
}