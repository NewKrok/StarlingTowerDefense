/**
 * Created by newkrok on 13/03/16.
 */
package starlingtowerdefense.game.service.pathfinder
{
	import net.fpp.geom.SimplePoint;

	import starlingtowerdefense.game.module.map.constant.CMapSize;

	import starlingtowerdefense.game.module.map.vo.MapNodeVO;
	import starlingtowerdefense.game.service.pathfinder.vo.RouteRequestVO;
	import starlingtowerdefense.game.service.pathfinder.vo.RouteVO;

	public class PathFinderService
	{
		private var _startNode:MapNodeVO;
		private var _endNode:MapNodeVO;
		private var _mapNodes:Vector.<Vector.<MapNodeVO>>;

		private var _openedRouteNodes:Vector.<MapNodeVO>;
		private var _closedRouteNodes:Vector.<MapNodeVO>;
		private var _path:Vector.<MapNodeVO>;

		private var _straightCost:Number = 1.0;

		public function getRoute( routeRequestVO:RouteRequestVO ):RouteVO
		{
			this._startNode = this.getNodeByPosition( routeRequestVO.mapNodes, routeRequestVO.startPosition );
			this._endNode = this.getNodeByPosition( routeRequestVO.mapNodes, routeRequestVO.endPosition );
			this._mapNodes = routeRequestVO.mapNodes;

			this._openedRouteNodes = new <MapNodeVO>[];
			this._closedRouteNodes = new <MapNodeVO>[];

			this._startNode.g = 0;
			this._startNode.h = this.diagonalHeuristic( this._startNode );
			this._startNode.f = this._startNode.g + this._startNode.h;

			var routeVO:RouteVO = new RouteVO();
			routeVO.route = this.calculateRoute();
			routeVO.route.push( routeRequestVO.endPosition );

			return routeVO;
		}

		private function getNodeByPosition( map:Vector.<Vector.<MapNodeVO>>, position:SimplePoint ):MapNodeVO
		{
			var xIndex:int = Math.floor( position.x / CMapSize.NODE_SIZE );
			var yIndex:int = Math.floor( position.y / CMapSize.NODE_SIZE );

			return map[ xIndex ][ yIndex ];
		}

		private function diagonalHeuristic( node:MapNodeVO ):Number
		{
			var dx:Number = node.x - this._endNode.x;
			var dy:Number = node.y - this._endNode.y;
			var distance:Number = Math.abs( dx + dy );

			var A_axis:Number = ( Math.abs( dx - dy ) - distance ) / 2;
			if( A_axis > 0 )
			{
				distance += A_axis;
			}

			return distance * this._straightCost;
		}

		private function calculateRoute():Vector.<SimplePoint>
		{
			var node:MapNodeVO = _startNode;
			while( node != _endNode )
			{
				var startX:int = Math.max( 0, node.x - 1 );
				var endX:int = Math.min( _mapNodes.length - 1, node.x + 1 );
				var startY:int = Math.max( 0, node.y - 1 );
				var endY:int = Math.min( _mapNodes[0] .length - 1, node.y + 1 );

				for( var i:int = startX; i <= endX; i++ )
				{
					for( var j:int = startY; j <= endY; j++ )
					{
						var test:MapNodeVO = _mapNodes[i][j];
						if( ( i - node.x ) * ( j - node.y ) > 0 )
						{
							continue;
						}
						if( test == node || !test.isWalkable )
						{
							continue;
						}

						var cost:Number = _straightCost;
						var g:Number = node.g + cost;
						var h:Number = diagonalHeuristic( test );
						var f:Number = g + h;
						if( isOpen( test ) || isClosed( test ) )
						{
							if( test.f > f )
							{
								test.f = f;
								test.g = g;
								test.h = h;
								test.parent = node;
							}
						}
						else
						{
							test.f = f;
							test.g = g;
							test.h = h;
							test.parent = node;
							this._openedRouteNodes.push( test );
						}
					}
				}
				this._closedRouteNodes.push( node );

				if( this._openedRouteNodes.length == 0 )
				{
					trace( "no path found" );
					return new <SimplePoint>[];
				}
				this._openedRouteNodes.sort( sortNodes );
				node = this._openedRouteNodes.shift() as MapNodeVO;
			}
			buildPath();

			return this.pathToPointVector();

		}

		private function sortNodes( $a:MapNodeVO, $b:MapNodeVO ):int
		{

			return $a.f > $b.f ? 1 : $a.f == $b.f ? 0 : -1;

		}

		private function pathToPointVector():Vector.<SimplePoint>
		{
			var result:Vector.<SimplePoint> = new <SimplePoint>[];

			for ( var i:int = 1; i < this._path.length - 1; i++ )
			{
				result.push( new SimplePoint( this._path[i].x * CMapSize.NODE_SIZE + CMapSize.NODE_SIZE / 2, this._path[i].y * CMapSize.NODE_SIZE + CMapSize.NODE_SIZE / 2 ) );
			}
			return result;
		}

		private function buildPath():void
		{
			_path = new <MapNodeVO>[];
			_path.length = 0;
			var node:MapNodeVO = _endNode;
			_path.push( node );
			while( node != _startNode )
			{
				node = node.parent;
				_path.unshift( node );
			}

		}

		private function isOpen( $node:MapNodeVO ):Boolean
		{

			for each ( var selectedNode:MapNodeVO in this._openedRouteNodes )
			{
				if( selectedNode == $node )
				{
					return true
				}
			}

			return false;

		}

		private function isClosed( $node:MapNodeVO ):Boolean
		{

			for each ( var selectedNode:MapNodeVO in this._closedRouteNodes )
			{
				if( selectedNode == $node )
				{
					return true
				}
			}

			return false;

		}
	}
}