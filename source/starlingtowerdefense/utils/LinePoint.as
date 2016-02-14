package starlingtowerdefense.utils {
	
	import flash.geom.Point;

	public class LinePoint extends Point {
		
		public static var fullLength:	Number = 0;
		public var currentLength:		Number
		public var l: 					Number;
		public var xL: 					Number;
		public var yL: 					Number;
		public var xR: 					Number;
		public var yR: 					Number;
		public var angle: 				Number = 0;
		public var angleT: 				Number = 0;
		public static var lw:			Number = 25;
		public var prevPoint:			LinePoint;
		
		public function LinePoint ( xPos:Number, yPos:Number, prevPoint:LinePoint = null ) {
			super ( xPos, yPos );
			this.prevPoint = prevPoint;
			if ( prevPoint ) {
				l = Point.distance ( this, prevPoint );
				fullLength += l;
				currentLength = fullLength;
				angleT = Math.atan2 ( this.y - prevPoint.y, this.x - prevPoint.x );
				angle = angleT;
				var pR:Point = Point.polar ( lw, angle + Math.PI / 2 );
				xR = pR.x + x;
				yR = pR.y + y;
				var pL:Point = Point.polar ( lw, angle - Math.PI / 2 );
				xL = pL.x + x;
				yL = pL.y + y;
				if ( prevPoint.prevPoint )
					prevPoint.setAngel ( this );
			} else {
				xR = x;
				yR = y;
				xL = x;
				yL = y;
			}
		}

		private function setAngel ( nextPoint:LinePoint ) :void {
			angle = Math.atan2 ( nextPoint.y - prevPoint.y, nextPoint.x - prevPoint.x );
			var ll:Number= l + prevPoint.l + nextPoint.l
			var pR:Point = Point.polar ( lw, angle + Math.PI / 2 );
			xR = pR.x + x;
			yR = pR.y + y;
			var pL:Point = Point.polar ( lw, angle - Math.PI / 2 );
			xL = pL.x + x;
			yL = pL.y + y;
		}

		private function intersect ( p1:Point, p2:Point, p3:Point, p4:Point ) :Boolean  {
			var nx:Number, ny:Number, dn:Number;
			var x4_x3:Number = p4.x - p3.x;
			var pre2:Number = p4.y - p3.y;
			var pre3:Number = p2.x - p1.x;
			var pre4:Number = p2.y - p1.y;
			var pre5:Number = p1.y - p3.y;
			var pre6:Number = p1.x - p3.x;
			nx = x4_x3 * pre5 - pre2 * pre6;
			ny = pre3 * pre5 - pre4 * pre6;
			dn = pre2 * pre3 - x4_x3 * pre4;
			nx /= dn;
			ny /= dn;
			if ( nx >= 0 && nx <= 1 && ny >= 0 && ny <= 1 )
				return true;
			return false;
		}		

	}
	
}