package com.kvchen.ui.shape.utils
{
	import com.kvchen.ui.math.Math2D;
	
	import flash.display.Graphics;
	import flash.geom.Point;

	public class DrawUtils
	{
		public static const CIRCLE_CTL_MULTIPLY:Number = 1.0823922002923938;
		
		public static const CBR0:Number = 0.455877279275103; //CUBIC_BEZIER_ROUND_RATIO_0
		public static const CBR1:Number = 0.544122720724897; //CUBIC_BEZIER_ROUND_RATIO_1
		
		//for cubic bezier
		public static const tlCubicData:Array = [0,1,0,CBR0,CBR0,0,1,0];
		public static const trCubicData:Array = [0,0,CBR1,0,1,CBR0,1,1];
		public static const brCubicData:Array = [1,0,1,CBR1,CBR1,1,0,1];
		public static const blCubicData:Array = [1,1,CBR0,1,0,CBR1,0,0];
		
		//for bezier
		public static const tlData:Array = [0,1,0,0.58579,0.29289,0.29289,0.58579,0,1,0];
		public static const trData:Array = [0,0,0.41421,0,0.70711,0.29289,1,0.58579,1,1];
		public static const brData:Array = [1,0,1,0.41421,0.70711,0.70711,0.41421,1,0,1];
		public static const blData:Array = [1,1,0.58579,1,0.29289,0.70711,0,0.41421,0,0];
		
		public static function drawHDashLine(g:Graphics, yPos:Number, startX:Number, endX:Number, thickness:Number = 1, fillDashLength:Number = 5, dashPadLength:Number = 1):void
		{
			var width:int = endX - startX;
			var dashWidth:int = fillDashLength+dashPadLength;
			var lastDashWidth:int = width % dashWidth;
			var i:int = 0;
			for(i=0; i<width; i+= fillDashLength){
				g.drawRect(i, yPos, fillDashLength, thickness);
			}
			if(lastDashWidth != 0){
				g.drawRect(endX-lastDashWidth, yPos, lastDashWidth, thickness);
			}
		}
		
		public static function drawVDashLine(g:Graphics, xPos:Number, startY:Number, endY:Number, color:uint = 0x0, thickness:Number = 1, fillDashLength:Number = 5, dashPadLength:Number = 1):void
		{
			var height:int = endY - startY;
			var dashHeight:int = fillDashLength+dashPadLength;
			var lastDashHeight:int = height % dashHeight;
			var i:int = 0;
			for(i=0; i<height; i+= fillDashLength){
				g.drawRect(i, xPos, fillDashLength, thickness);
			}
			if(lastDashHeight != 0){
				g.drawRect(endY-lastDashHeight, xPos, lastDashHeight, thickness);
			}
		}
		
		private static function pushRoundCorner(data:Vector.<Number>, corner:Array, size:Number, offsetX:Number, offsetY:Number):void
		{
			var len:int = corner.length;
			for(var i:int=0; i<len; i+=2){
				data.push(corner[i] * size + offsetX);
				data.push(corner[i+1] * size + offsetY);
			}
		}
		
		private static function pushReverseRoundCorner(data:Vector.<Number>, corner:Array, size:Number, offsetX:Number, offsetY:Number):void
		{
			var len:int = corner.length;
			for(var i:int=len-1; i>=0; i-=2){
				data.push(corner[i-1] * size + offsetX);
				data.push(corner[i] * size + offsetY);
			}
		}
		
		public static function drawRoundRect(g:Graphics, x:Number, y:Number, width:Number, height:Number, TLRadius:Number, TRRadius:Number, BRRadius:Number, BLRadius:Number):void
		{
			TLRadius = TLRadius < 0 ? 0 : TLRadius;
			TRRadius = TRRadius < 0 ? 0 : TRRadius;
			BRRadius = BRRadius < 0 ? 0 : BRRadius;
			BLRadius = BLRadius < 0 ? 0 : BLRadius;
			
			var data:Vector.<Number> = new Vector.<Number>();
			var commands:Vector.<int> = new Vector.<int>();

			if(TLRadius > 0){
				pushRoundCorner(data, tlData, TLRadius, x, y);
				commands.push(1, 3, 3);
			}else{
				data.push(x, y);
				commands.push(1);
			}
			
			if(TRRadius > 0){
				pushRoundCorner(data, trData, TRRadius, x+(width-TRRadius), y);
				commands.push(2, 3, 3);
			}else{
				data.push(x+width, y);
				commands.push(2);
			}
			
			if(BRRadius > 0){
				pushRoundCorner(data, brData, BRRadius, x+(width-BRRadius), y+(height-BRRadius));
				commands.push(2, 3, 3);
			}else{
				data.push(x+width, y+height);
				commands.push(2);
			}
			
			if(BLRadius > 0){
				pushRoundCorner(data, blData, BLRadius, x, y+(height-BLRadius));
				commands.push(2, 3, 3);
			}else{
				data.push(x, y+height);
				commands.push(2);
			}
			
			data.push(data[0], data[1]);
			commands.push(2);
			
			g.drawPath(commands, data);
		}
		
		public static function drawReverseRoundRect(g:Graphics, x:Number, y:Number, width:Number, height:Number, TLRadius:Number, TRRadius:Number, BRRadius:Number, BLRadius:Number):void
		{
			TLRadius = TLRadius < 0 ? 0 : TLRadius;
			TRRadius = TRRadius < 0 ? 0 : TRRadius;
			BRRadius = BRRadius < 0 ? 0 : BRRadius;
			BLRadius = BLRadius < 0 ? 0 : BLRadius;
			
			var data:Vector.<Number> = new Vector.<Number>();
			var commands:Vector.<int> = new Vector.<int>();
			if(TLRadius > 0){
				pushReverseRoundCorner(data, tlData, TLRadius, x, y);
				commands.push(1, 3, 3);
			}else{
				data.push(x, y);
				commands.push(1);
			}
			
			if(BLRadius > 0){
				pushReverseRoundCorner(data, blData, BLRadius, x, height-BLRadius+y);
				commands.push(2, 3, 3);
			}else{
				data.push(x, height-BLRadius+y);
				commands.push(2);
			}
			
			if(BRRadius > 0){
				pushReverseRoundCorner(data, brData, BRRadius, width-BRRadius+x, height-BRRadius+y);
				commands.push(2, 3, 3);
			}else{
				data.push(width-BRRadius+x, height-BRRadius+y);
				commands.push(2);
			}
			
			if(TRRadius > 0){
				pushReverseRoundCorner(data, trData, TRRadius, width-TRRadius+x, y);
				commands.push(2, 3, 3);
			}else{
				data.push(width-TRRadius+x, y);
				commands.push(2);
			}
			
			data.push(data[0], data[1]);
			commands.push(2);
			
			g.drawPath(commands, data);
		}

		public static function drawRoundCorner(g:Graphics, start:Point, control:Point, end:Point):void
		{
			if((start.x == control.x && start.x == end.x) && (start.y == control.y && start.y == end.y))
				return;
			
			var center:Point = new Point();
			if(control.x == start.x && control.y == end.y){
				center = new Point(end.x, start.y);
			}else{
				center = new Point(start.x, end.y);
			}
			
			var curveCenter:Point = Math2D.rotatePoint(start, center, 45);
			var control1:Point = Math2D.rotatePoint(control, curveCenter, -90);
			var control2:Point = Math2D.rotatePoint(control, curveCenter, 90);
			//g.moveTo(start.x, start.y);
			g.curveTo(control1.x, control1.y, curveCenter.x, curveCenter.y);
			g.curveTo(control2.x, control2.y, end.x, end.y);
		}
		
		public static function drawReverseRoundCorner(g:Graphics, start:Point, control:Point, end:Point):void
		{
			if((start.x == control.x && start.x == end.x) && (start.y == control.y && start.y == end.y))
				return;
			
			var center:Point = new Point();
			if(control.x == start.x && control.y == end.y){
				center = new Point(end.x, start.y);
			}else{
				center = new Point(start.x, end.y);
			}
			
			var curveCenter:Point = Math2D.rotatePoint(start, center, -45);
			var control1:Point = Math2D.rotatePoint(control, curveCenter, 90);
			var control2:Point = Math2D.rotatePoint(control, curveCenter, -90);
			g.curveTo(control1.x, control1.y, curveCenter.x, curveCenter.y);
			g.curveTo(control2.x, control2.y, end.x, end.y);
		}
		
		public static function drawArc(g:Graphics, radius:Number, fromAngle:Number, toAngle:Number, CW:Boolean = true):void
		{
			var distAngle:Number = toAngle - fromAngle;
			distAngle = distAngle < 0 ? distAngle+360 : distAngle;
			var numSegments:Number = distAngle/22.5;
			numSegments = numSegments > int(numSegments) ? int(numSegments)+1 : int(numSegments);
			if(!CW){
				distAngle = distAngle - 360;
			}
			var segLen:Number = (distAngle/numSegments)/2;
			var i:int = 0;
			var orig:Point = new Point(radius, 0);
			var center:Point = new Point(0, 0);
			var start:Point = Math2D.rotatePoint(orig, center, fromAngle);
			var crv:Point;
			var ctl:Point;
			var end:Point;
			g.moveTo(start.x, start.y);
			for(i=0; i<numSegments; ++i){
				crv = Math2D.rotatePoint(start, center, segLen);
				end = Math2D.rotatePoint(crv, center, segLen);
				ctl = Math2D.getCtlPoint(start, crv, end);
				g.curveTo(ctl.x, ctl.y, end.x, end.y);
				start = end;
			}
		}
		
		public static function drawReverseCircle(g:Graphics, radius:Number):void
		{
			var points:Array = new Array();
			var controls:Array = new Array();
			var startPnt:Point = new Point(radius, 0);
			var i:int = 0;
			var len:int = 8;
			var pnt:Point;
			var center:Point = new Point(0, 0);
			points.push(startPnt);
			for(i=1; i<len; ++i){
				points.push(Math2D.rotatePoint(startPnt, center, i * -45));
			}
			
			//calculate the controls
			startPnt = new Point(radius*CIRCLE_CTL_MULTIPLY, 0);
			startPnt = Math2D.rotatePoint(startPnt, center, -22.5);
			controls.push(startPnt);
			for(i=1; i<len; ++i){
				controls.push(Math2D.rotatePoint(startPnt, center, i*-45));
			}
			
			//draw graphics
			g.moveTo(points[0].x, points[0].y);
			for(i=0; i<len; ++i){
				if(i == len-1){
					pnt = points[0];
				}else{
					pnt = points[i+1];
				}
				g.curveTo(controls[i].x, controls[i].y, pnt.x, pnt.y);
			}
		}

	}
}