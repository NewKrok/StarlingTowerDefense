package net.fpp.starlingtowerdefense.util
{

	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Point;

	import net.fpp.common.geom.SimplePoint;

	public class BrushPattern extends Sprite
	{

		private var linePoints:Array = new Array();
		private var linePointsInput:Array = new Array();
		private var holderS:Sprite = new Sprite();
		private var g:Graphics;
		private var _fillBack:Sprite = new Sprite;
		private var vertices:Vector.<Number>;
		private var indices:Vector.<int>;
		private var uvtData:Vector.<Number>;
		private var lastLength:Number = 0;
		private var segLength:Number = 0;
		private var _terrainTexture:BitmapData;
		private var _terrainContentTexture:BitmapData;

		public function BrushPattern( groundPoints:Vector.<SimplePoint>, texture:BitmapData, $terrainContentTexture:BitmapData, textureMaxWidth:Number, textureHeight:Number )
		{

			var map:String = '';
			for( i = 0; i < groundPoints.length - 1; i++ )
			{
				map += groundPoints[ i ].x + '<' + groundPoints[ i ].y + '<' + groundPoints[ i + 1 ].x + '<' + groundPoints[ i + 1 ].y + '&';
			}

			LinePoint.lw = textureHeight;
			_terrainTexture = texture;
			_terrainContentTexture = $terrainContentTexture;
			map = renderPreProcess( map, texture ? texture.width : textureMaxWidth, textureMaxWidth );
			g = holderS.graphics;
			_fillBack.graphics.lineStyle( 0, 0, 0 );
			//_fillBack.x = -$textureMaxWidth / 2;
			_fillBack.y = textureHeight / 4;
			addChild( _fillBack );
			addChild( holderS );
			var mapPieces:Array = map.split( "|" );

			var savedGroundPoints:Vector.<Point> = new Vector.<Point>;

			for( var j:int = 0; j < mapPieces.length; j++ )
			{
				if( mapPieces[ j ] == "" )
				{
					break;
				}
				var tmp:Array = mapPieces[ j ].split( "&" );

				if ( this._terrainContentTexture )
				{
					this._fillBack.graphics.beginBitmapFill( this._terrainContentTexture );
				}
				for( var i:uint = 0; i < tmp.length - 1; i++ )
				{
					var tmp2:Array = tmp[ i ].split( "<" );
					if( j == 0 && i == 0 )
					{
						_fillBack.graphics.moveTo( Number( tmp2[ 0 ] ), Number( tmp2[ 1 ] ) )
						_fillBack.graphics.lineTo( Number( tmp2[ 0 ] ), Number( tmp2[ 1 ] ) );
					}
					else
					{
						_fillBack.graphics.lineTo( Number( tmp2[ 2 ] ), Number( tmp2[ 3 ] ) );
					}
					if( i == 0 )
					{
						var lp:LinePoint = new LinePoint( Number( tmp2[ 0 ] ), Number( tmp2[ 1 ] ) );
						linePointsInput.push( lp );
					}
					else
					{
						lp = new LinePoint( Number( tmp2[ 0 ] ), Number( tmp2[ 1 ] ), linePointsInput[ linePointsInput.length - 1 ] );
						linePointsInput.push( lp );
						calculate();
						render();
					}
					if( i == tmp.length - 2 )
					{
						lp = new LinePoint( Number( tmp2[ 2 ] ), Number( tmp2[ 3 ] ), linePointsInput[ linePointsInput.length - 1 ] );
						linePointsInput.push( lp );
						calculate();
						render();
					}
				}
				i -= 2;

				_fillBack.graphics.endFill();
			}
		}

		private function renderPreProcess( $map:String, $textureWidth:Number, $textureMaxWidth:Number ):String
		{
			var blockSize:Number = $textureWidth;
			var convertedMap:String = "";
			var mapPieces:Array = $map.split( "|" );
			for( var j:uint = 0; j < mapPieces.length; j++ )
			{
				blockSize = $textureWidth;
				var tmp:Array = mapPieces[ j ].split( "&" );
				for( var i:uint = 0; i < tmp.length - 1; i++ )
				{
					var tmp2:Array = tmp[ i ].split( "<" );
					tmp2[ 0 ] = Number( tmp2[ 0 ] ) * 2;
					tmp2[ 1 ] = Number( tmp2[ 1 ] ) * 2;
					tmp2[ 2 ] = Number( tmp2[ 2 ] ) * 2;
					tmp2[ 3 ] = Number( tmp2[ 3 ] ) * 2;
					var lineLength:Number = Math.sqrt( Math.pow( tmp2[ 2 ] - tmp2[ 0 ], 2 ) + Math.pow( tmp2[ 3 ] - tmp2[ 1 ], 2 ) );
					if( lineLength < $textureMaxWidth )
					{
						convertedMap += tmp2[ 0 ] + "<" + tmp2[ 1 ] + "<" + tmp2[ 2 ] + "<" + tmp2[ 3 ] + "&";
					}
					else
					{
						var angle:Number = Math.atan2( tmp2[ 3 ] - tmp2[ 1 ], tmp2[ 2 ] - tmp2[ 0 ] );
						var pieces:uint = Math.ceil( lineLength / ( $textureWidth < $textureMaxWidth ? $textureWidth : $textureMaxWidth ) );
						blockSize = lineLength / pieces;
						var newX:Number = tmp2[ 0 ];
						var newY:Number = tmp2[ 1 ];
						for( var k:uint = 1; k < pieces + 1; k++ )
						{
							var newX2:Number = tmp2[ 0 ] + blockSize * k * Math.cos( angle );
							var newY2:Number = tmp2[ 1 ] + blockSize * k * Math.sin( angle );
							convertedMap += newX + "<" + newY + "<" + newX2 + "<" + newY2 + "&";
							newX = newX2;
							newY = newY2;
						}
					}
				}
				convertedMap += "|"
			}
			return convertedMap;
		}

		private function calculate():void
		{
			segLength = 1;
			lastLength = 0;
			linePoints = [];
			linePoints.push( linePointsInput[ 0 ] );
			vertices = new Vector.<Number>;
			indices = new Vector.<int>;
			uvtData = new Vector.<Number>;
			for( var i:int = 1; i < linePointsInput.length; i++ )
			{
				var lp:LinePoint = linePointsInput[ i ];
				if( lp.currentLength > lastLength + segLength )
				{
					lastLength = lp.currentLength;
					linePoints.push( lp );
				}
			}
			var count:int = 0;
			var uvStep:Number = .5;
			var currentUV:Number = 0
			for( i = 0; i < linePoints.length - 1; i += 2 )
			{
				lp = linePoints[ i ];
				vertices.push( lp.xL, lp.yL, lp.xR, lp.yR );
				if( i == linePoints.length - 1 )
				{
					lp = linePoints[ i ];
				}
				else
				{
					lp = linePoints[ i + 1 ];
				}
				vertices.push( lp.xL, lp.yL, lp.xR, lp.yR );
				indices.push( count, count + 1, count + 2, count + 1, count + 2, count + 3 );
				indices.push( count + 2, count + 3, count + 4, count + 3, count + 4, count + 5 );
				uvtData.push( currentUV, 0, currentUV, 1, currentUV + uvStep, 0, currentUV + uvStep, 1 );
				count += 4;
				currentUV += uvStep;
				currentUV += uvStep;
			}
		}

		private function render():void
		{
			this.g.clear();

			if( this._terrainTexture )
			{
				this.g.beginBitmapFill( this._terrainTexture, null, true, true );
				this.g.drawTriangles( this.vertices, this.indices, this.uvtData );
			}
		}

		private function clear():void
		{
			g.clear();
			LinePoint.fullLength = 0;
			linePointsInput = [];
			linePoints = [];
		}

		public function dispose():void
		{
			clear();
			linePointsInput = null;
			linePoints = null;
			g = null;
		}

	}

}