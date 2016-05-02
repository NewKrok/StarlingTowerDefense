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

			for ( var i:int = 0; i < 15; i++ )
			{
				this._mapModel.mapNodes.push( new <PathNodeVO>[] );
				for ( var j:int = 0; j < 10; j++ )
				{
					this._mapModel.mapNodes[i].push( new PathNodeVO( i, j ) );
				}
			}
		}

		public function getMapNodes():Vector.<Vector.<PathNodeVO>>
		{
			return this._mapModel.mapNodes;
		}
	}
}