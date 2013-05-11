package com.kvchen.ui.math
{
	import __AS3__.vec.Vector;
	
	import flash.display.*;
	import flash.geom.*;
	import flash.system.Capabilities;
	
	public class Math2D
	{
		public static var toRadian:Function = function toRadian(degree:Number):Number{return degree*Math.PI/180};
		public static var toDegree:Function = function toDegree(radian:Number):Number{return radian*180/Math.PI};
		
		public static function expandRect(rect:Rectangle, borderWidth:Number, borderHeight:Number):void
		{
			rect.x -= borderWidth;
			rect.y -= borderHeight;
			rect.width += borderWidth  * 2;
			rect.height+= borderHeight * 2;
		}
		
		/**
		 * after flash become fullscreen, and flash align is default, this function will return the screen rectangle relative to flash with no scale, you can use this return rectangle to layout you content
		 * @param stageWidth flash stage width
		 * @param stageHeight flash stage height
		 * @return the rectangle relative to flash stage with no scale
		 * 
		 */		
		public static function getStageRect(stageWidth:int = 1024, stageHeight:int = 768):Rectangle
		{
			var screenW:Number = Capabilities.screenResolutionX;
			var screenH:Number = Capabilities.screenResolutionY;
			var stageRect:Rectangle = fitToScreen(stageWidth, stageHeight, screenW, screenH);
			var screenRect:Rectangle = getScreenRect(stageWidth, stageHeight);
			var scaleRev:Number = stageWidth / stageRect.width;
			var resultRect:Rectangle = new Rectangle();
			resultRect.x = screenRect.x * scaleRev;
			resultRect.y = screenRect.y * scaleRev;
			resultRect.width  = screenRect.width * scaleRev;
			resultRect.height = screenRect.height * scaleRev;
			return resultRect;
		}
		
		/**
		 * after flash become fullscreen, and flash align is default, this function will return the screen rectangle relative to flash
		 * @param stageWidth flash stage width
		 * @param stageHeight flash stage height
		 * @return the rectangle relative to flash stage
		 * 
		 */		
		public static function getScreenRect(stageWidth:int = 1024, stageHeight:int = 768):Rectangle
		{
			var screenW:Number = Capabilities.screenResolutionX;
			var screenH:Number = Capabilities.screenResolutionY;
			var stageRect:Rectangle = Math2D.fitToScreen(stageWidth, stageHeight, screenW, screenH);
			var screenRect:Rectangle = new Rectangle();
			screenRect.x = -stageRect.x;
			screenRect.y = -stageRect.y;
			screenRect.width = screenW;
			screenRect.height= screenH;
			return screenRect;
		}
		
		/**
		 * after flash turn to fullscreen, and flash align is default, this function will return the rectangle on the screen based on input local rectangle(relative to stage)
		 * @param localRect local rectangle relative to stage
		 * @param stageWidth flash stage width
		 * @param stageHeight flash stage height
		 * @return the rectangle in screen after transform
		 * 
		 */		
		public static function localRectToMonitor(localRect:Rectangle, stageWidth:int = 1024, stageHeight:int = 768):Rectangle
		{
			var screenW:Number = Capabilities.screenResolutionX;
			var screenH:Number = Capabilities.screenResolutionY;
			var stageRect:Rectangle = fitToScreen(stageWidth, stageHeight, screenW, screenH);
			var scale:Number = stageRect.width / stageWidth;
			var globalRect:Rectangle = new Rectangle();
			globalRect.x      = localRect.x * scale + stageRect.x;
			globalRect.y      = localRect.y * scale + stageRect.y;
			globalRect.width  = localRect.width * scale;
			globalRect.height = localRect.height * scale;
			return globalRect;
		}
		
		public static function fitObjToRect(obj:DisplayObject, targetRect:Rectangle):void
		{
			var objWidth:Number = obj.width;
			var objHeight:Number = obj.height;
			var widthRate:Number = targetRect.width/objWidth;
			var heightRate:Number = targetRect.height/objHeight;
			var scaleRate:Number = (widthRate < heightRate) ? widthRate : heightRate;
			var useWidth:Boolean = (widthRate < heightRate) ? true : false;
			
			var xPos:Number = 0;
			var yPos:Number = 0;
			
			if(useWidth){
				yPos = (targetRect.height - objHeight*scaleRate)/2;
			}else{
				xPos = (targetRect.width - objWidth*scaleRate)/2;
			}
			
			obj.x = xPos+targetRect.x;
			obj.y = yPos+targetRect.y;
			obj.scaleX = scaleRate;
			obj.scaleY = scaleRate;
		}
		
		/**
		 * This function calculate flash after fullscreen, the rectangle in screen
		 * @param flashW flash width
		 * @param flashH flash height
		 * @param screenW screen width
		 * @param screenH screen height
		 * @return the rectangle in monitor
		 * 
		 */		
		public static function fitToScreen(flashW:Number, flashH:Number, screenW:Number, screenH:Number):Rectangle
		{
			var wRate:Number = screenW/flashW, hRate:Number = screenH/flashH;
			var x:Number = 0, y:Number = 0, w:Number = 0, h:Number = 0;
			
			if(wRate < hRate){
				w = flashW * wRate;
				h = flashH * wRate;
				y = (screenH - h)/2;
			}else{
				w = flashW * hRate;
				h = flashH * hRate;
				x = (screenW - flashW * hRate)/2;
			}
			return new Rectangle(x, y, w, h);
		}
		
		public static function splitSpace(width:int, height:int, xAmount:int, yAmount:int, xSpace:int, ySpace:int):Object
		{
			var w:int = Math.floor((width-(xAmount-1)*xSpace)/xAmount);
			var h:int = Math.floor((height-(yAmount-1)*ySpace)/yAmount);
			return {width:w, height:h};
		}
		
		/**
		 * 
		 * @param pnt0 point for first vector original
		 * @param pnt1 point for first vector target
		 * @param pnt2 point for second vector original
		 * @param pnt3 point for second vector target
		 * @return the radians between two vectors given
		 * 
		 */
		public static function getAngleBetweenTwoVector(pnt0:Point, pnt1:Point, pnt2:Point, pnt3:Point):Number
		{
			var vc:Point = pnt1.subtract(pnt0);
			var vb:Point = pnt3.subtract(pnt2);
			var a:Number = Point.distance(vc, vb);
			var aa:Number = a * a;
			var bb:Number = vb.x * vb.x + vb.y * vb.y;
			var b:Number = Math.sqrt(bb);
			var cc:Number = vc.x * vc.x + vc.y * vc.y;
			var c:Number = Math.sqrt(cc);
			return Math.acos((bb + cc - aa)/(2 * b * c));
		}
		
		/**
		 * Get distance square between two points (for improve performance)
		 * @param pnt0
		 * @param pnt1
		 * @return 
		 * 
		 */		
		public static function getDistSqrt(pnt0:Point, pnt1:Point):Number
		{
			return (pnt1.x - pnt0.x) * (pnt1.x - pnt0.x) + (pnt1.y - pnt0.y) * (pnt1.y - pnt0.y);
		}
		
		public static function containsPoint(rect:Rectangle, rotation:Number, point:Point):Boolean
		{
			var orig:Point = new Point(rect.x, rect.y);
			point = rotatePoint(point, orig, -rotation);
			return rect.contains(point.x, point.y);
		}
		
		public static function clamp(value:Number, min:Number = 0, max:Number = 1):Number
		{
			if(min < max){
				value = value < min ? min : value;
				value = value > max ? max : value;
			}else{
				value = value < max ? max : value;
				value = value > min ? min : value;
			}
			return value;
		}
		
		public static function getRelValue(min1:Number, val1:Number, max1:Number, min2:Number, max2:Number):Number
		{
			return min2 + (max2 - min2) * (val1 - min1)/(max1 - min1);
		}
		
		/**
		 * Use cosines to calculate the center position between two segments
		 * @param startPnt start point
		 * @param endPnt end point ik to reach
		 * @param firstSegLen first segment length
		 * @param secondSegLen second segment length
		 * @param bendToLeft the center position bend to left or right
		 * @return the result, (such as: two leg return the knee position)
		 * 
		 */		
		public static function getKnee(startPnt:Point, endPnt:Point, firstSegLen:Number, secondSegLen:Number, bendToLeft:Boolean = true):Point
		{
			var dx:Number = endPnt.x - startPnt.x;
			var dy:Number = endPnt.y - startPnt.y;
			var dist:Number = Math.sqrt(dx * dx + dy * dy);
			var c:Number = Math.min(dist, firstSegLen+secondSegLen);
			var B:Number = Math.acos(( secondSegLen * secondSegLen - firstSegLen * firstSegLen - c * c)/(-2 * firstSegLen * c));
			var D:Number = Math.atan2(dy, dx);
			
			if(bendToLeft){
				return Math2D.rotatePointAtOrignal2(new Point(firstSegLen, 0), (B+D)).add(startPnt);
			}else{
				return Math2D.rotatePointAtOrignal2(new Point(firstSegLen, 0), (D-B)).add(startPnt);
			}
		}
		
		public static function cosines(startPnt:Point, endPnt:Point, firstSegLen:Number, secondSegLen:Number, bendToLeft:Boolean = true):Object
		{
			var dx:Number = endPnt.x - startPnt.x;
			var dy:Number = endPnt.y - startPnt.y;
			var dist:Number = Math.sqrt(dx * dx + dy * dy);
			
			var c:Number = Math.min(dist, firstSegLen+secondSegLen);
			
			var B:Number = Math.acos(( secondSegLen * secondSegLen - firstSegLen * firstSegLen - c * c)/(-2 * firstSegLen * c));
			var C:Number = Math.acos(( c * c - firstSegLen * firstSegLen - secondSegLen * secondSegLen)/(-2 * firstSegLen * secondSegLen));
			var D:Number = Math.atan2(dy, dx);
			var E:Number;
			if(bendToLeft)
				E = D + B + Math.PI + C; //center left side
			else
				E = D - B + Math.PI - C; //center right side
			
			var rotStart:Number = (B+D) * 180/Math.PI;
			var rotEnd:Number = E * 180/Math.PI;
			var posEnd:Point;
			if(bendToLeft)
				posEnd = Math2D.rotatePointAtOrignal2(new Point(firstSegLen, 0), B+D).add(startPnt);
			else 
				posEnd = Math2D.rotatePointAtOrignal2(new Point(firstSegLen, 0), D-B).add(startPnt);
			
			return {rotStart:rotStart, rotEnd:rotEnd, posEnd:posEnd};
		}
		
		//check if two line segment is intersected
		public static function getSegIntersected(x1:Number,y1:Number,x2:Number,y2:Number,x3:Number,y3:Number,x4:Number,y4:Number):Boolean
		{
			var d:Number = (y2-y1)*(x4-x3)-(y4-y3)*(x2-x1);
			if(d!=0){
				var x0:Number = ((x2-x1)*(x4-x3)*(y3-y1)+(y2-y1)*(x4-x3)*x1-(y4-y3)*(x2-x1)*x3)/d;
				var y0:Number = ((y2-y1)*(y4-y3)*(x3-x1)+(x2-x1)*(y4-y3)*y1-(x4-x3)*(y2-y1)*y3)/(-d);
				if((x0-x1)*(x0-x2)<=0&& (x0-x3)*(x0-x4)<=0&&(y0-y1)*(y0-y2)<=0&&(y0-y3)*(y0-y4)<=0){
					return true;
				}
			}
			return false;
		}
		
		//calculate the nearest distance from point to line segment
		public static function getNearestDist(x1:Number, y1:Number, x2:Number, y2:Number, pntx:Number, pnty:Number):Number
		{
			var px:Number = x2 - x1;
			var py:Number = y2 - y1;
			var som:Number = px * px + py * py;
			var u:Number =  ((pntx - x1) * px + (pnty - y1) * py) / som;
			if (u > 1) {
				u = 1;
			}
			if (u < 0) {
				u = 0;
			}
			//the closest point
			var x:Number = x1 + u * px;
			var y:Number = y1 + u * py;
			var dx:Number = x - pntx;
			var dy:Number = y - pnty;
			var dist:Number = Math.sqrt(dx*dx + dy*dy);
			return dist;
		}
		
		//calculate the nearest point from point to line segment
		public static function getNearestPoint(x1:Number, y1:Number, x2:Number, y2:Number, pntx:Number, pnty:Number):Point
		{
			var px:Number = x2 - x1;
			var py:Number = y2 - y1;
			var som:Number = px * px + py * py;
			var u:Number =  ((pntx - x1) * px + (pnty - y1) * py) / som;
			if (u > 1) {
				u = 1;
			}
			if (u < 0) {
				u = 0;
			}
			//the closest point
			var x:Number = x1 + u * px;
			var y:Number = y1 + u * py;
			return new Point(x, y);
		}
		
		//start for bezier
		public static function getCtlPoint(st:Point, crv:Point, ed:Point):Point
		{
			var x:Number = 2*crv.x - st.x/2 - ed.x/2;
			var y:Number = 2*crv.y - st.y/2 - ed.y/2;
			return new Point(x, y);
		}
		
		public static function getCrvPoint(st:Point, ctl:Point, ed:Point):Point
		{
			var x:Number = st.x/4 + ctl.x/2 + ed.x/4;
			var y:Number = st.y/4 + ctl.y/2 + ed.y/4;
			return new Point(x, y);
		}
		//end for bezier
		
		public static function normalizeAngle(angle:Number):Number
		{
			angle = angle%360;
			return angle < 0 ? angle+360 : angle;
		}
		
		public static function getSegments(st:Point, ed:Point, segs:int):Array
		{
			var segLen:Number = 1.0/segs;
			var pos:Array = new Array();
			
			for(var i:int=1; i<segs; i++)
			{
				var pnt:Point = Point.interpolate(ed, st, i*segLen);
				pos.push(pnt);
			}
			
			return pos;
		}
		
		public static function localToGlobal(local:Point, x:Number, y:Number, rotation:Number, scale:Number):Point
		{
			var global:Point = new Point();
			var offsetX:Number = x;
			var offsetY:Number = y;
			var center:Point = new Point(0, 0);
			
			global = scalePoint(local, center, scale);
			global = rotatePoint(global, center, rotation);
			
			global.x += offsetX;
			global.y += offsetY;
			
			return global;
		}
		
		public static function globalToLocal(global:Point, x:Number, y:Number, rotation:Number, scale:Number):Point
		{
			var local:Point = new Point();
			var offsetX:Number = x;
			var offsetY:Number = y;
			var center:Point = new Point(x, y);
			var reverseRot:Number = rotation * -1;
			var reverseScale:Number = 1/scale;
			
			local = rotatePoint(global, center, reverseRot);
			local = scalePoint(local, center, reverseScale);
			local.x -= offsetX;
			local.y -= offsetY;
			
			return local;
		}
		
		public static function calibrate(lEye:Point, rEye:Point, accLEye:Point, accREye:Point):Array
		{
			var eyeDist:Number = Point.distance(lEye, rEye);
			var accEyeDist:Number = Point.distance(accLEye, accREye);
			var scaleFactor:Number = eyeDist/Number(accEyeDist);
			
			var eyeAngle:Number = getAngle(lEye, rEye);
			var accEyeAngle:Number = getAngle(accLEye, accREye);
			var rotateValue:Number = eyeAngle-accEyeAngle;
			
			var accLEyePos:Point;
			accLEyePos = scalePoint(accLEye, new Point(0, 0), scaleFactor);
			accLEyePos = rotatePoint(accLEyePos, new Point(0, 0), rotateValue);
			
			var tx:Number = lEye.x - accLEyePos.x;
			var ty:Number = lEye.y - accLEyePos.y;
			
			return [tx, ty, rotateValue, scaleFactor];
		}
		
		public static function centerAlign(rectBig:Rectangle, rectSmall:Rectangle):Point
		{
			var x:Number = rectBig.x + (rectBig.width - rectSmall.width)/2;
			var y:Number = rectBig.y + (rectBig.height - rectSmall.height)/2;
			return new Point(x, y);
		}
		
		public static function mapRect(srcRect:Rectangle, inSrcRect:Rectangle, tgtRect:Rectangle):Rectangle
		{
			var sx:Number = tgtRect.width/srcRect.width;
			var sy:Number = tgtRect.height/srcRect.height;
			var x:Number = inSrcRect.x * sx;
			var y:Number = inSrcRect.y * sy;
			var w:Number = inSrcRect.width * sx;
			var h:Number = inSrcRect.height * sy;
			return new Rectangle(x, y, w, h);
		}
		
		public static function rectFit(w:Number, h:Number, fitRect:Rectangle):Array
		{
			var wRate:Number = fitRect.width/w;
			var hRate:Number = fitRect.height/h;
			var scaleRate:Number = (wRate < hRate) ? wRate : hRate;
			var useWidth:Boolean = (wRate < hRate) ? true : false;
			
			var xPos:Number = 0;
			var yPos:Number = 0;
			
			if(useWidth)
			{
				yPos = (fitRect.height - h*scaleRate)/2;
			}
			else
			{
				xPos = (fitRect.width - w*scaleRate)/2;
			}
			
			return [xPos, yPos, scaleRate];
		}
		
		public static function transform(from:Object, to:Object, point:Point, weight:Number):Point
		{
			//order is scale -> rotate -> trans
			var st:Point = from.start;
			var ed:Point = from.end;
			var len:Number = Point.distance(st, ed);
			var angle:Number = Math.atan2(ed.y - st.y, ed.x - st.x);
			
			var st1:Point = to.start;
			var ed1:Point = to.end;
			var len1:Number = Point.distance(st1, ed1);
			var angle1:Number = Math.atan2(ed1.y - st1.y, ed1.x - st1.x);
			
			var tx:Number = st1.x - st.x;
			var ty:Number = st1.y - st.y;
			
			var sx:Number = len1/len;
			var sy:Number = 1;
			
			var rotation:Number = angle1 - angle;
			
			var target:Point = new Point(point.x, point.y);
			
			target = Math2D.scalePoint2(target, st, sx, sy);
			target = Math2D.rotatePoint2(target, st, rotation);
			target.x += tx;
			target.y += ty;
			
			return Point.interpolate(target, point, weight);
		}
		
		public static function transform2(from:Object, to:Object, point:Point, weight:Number):Point
		{
			return new Point();
		}
		
		//this function will calculate the distance from a point to a line
		public static function getDistance(pnt:Point, lineA:Point, lineB:Point):Number
		{
			var a:Number = (lineB.y - lineA.y)/(lineA.x - lineB.x);
			var b:Number = 1;
			var c:Number = -a*lineA.x - lineA.y;
			
			return Math.abs(a*pnt.x + b*pnt.y + c)/Math.sqrt(a*a+b*b);
		}
		
		public static function extendPoint(pt1:Point, pt2:Point, f:Number, angle:Number = 180):Point
		{
			var temp:Point = Point.interpolate(pt1, pt2, f);
			var pnt:Point = rotatePoint(temp, pt2, angle);
			return pnt;
		}
		
		public static function getImageBB(tx:Number, ty:Number, rot:Number, w:Number, h:Number):Rectangle
		{
			var pnt0:Point = new Point(tx, ty);
			var pnt1:Point = new Point(tx+w, ty);
			var pnt2:Point = new Point(tx, ty+h);
			var pnt3:Point = new Point(tx+w, ty+h);
			
			pnt1 = rotatePoint(pnt1, pnt0, rot);
			pnt2 = rotatePoint(pnt2, pnt0, rot);
			pnt3 = rotatePoint(pnt3, pnt0, rot);
			
			var pnts:Vector.<Point> = new Vector.<Point>();
				pnts.push(pnt0, pnt1, pnt2, pnt3);
			
			return getBoundingBox(pnts);
		}
		
		public static function getBoundingBox(vector:Vector.<Point>):Rectangle
		{
			var minX:Number = vector[0].x;
			var minY:Number = vector[0].y;
			var maxX:Number = vector[0].x;
			var maxY:Number = vector[0].y;
			
			for(var i:int=1; i<vector.length; i++)
			{
				if(vector[i].x < minX)
				{
					minX = vector[i].x;
				}
				
				if(vector[i].x > maxX)
				{
					maxX = vector[i].x;
				}
				
				if(vector[i].y < minY)
				{
					minY = vector[i].y;
				}
				
				if(vector[i].y > maxY)
				{
					maxY = vector[i].y;
				}
			}
			
			return new Rectangle(minX, minY, maxX-minX, maxY-minY);
		}
		
		public static function getBoundingBox2(points:Array):Rectangle
		{
			var minX:Number = points[0].x;
			var minY:Number = points[0].y;
			var maxX:Number = points[0].x;
			var maxY:Number = points[0].y;
			var len:int = points.length;
			for(var i:int=1; i<len; i++)
			{
				minX = points[i].x < minX ? points[i].x : minX;
				maxX = points[i].x > maxX ? points[i].x : maxX;
				minY = points[i].y < minY ? points[i].y : minY;
				maxY = points[i].y > maxY ? points[i].y : maxY;
			}
			
			return new Rectangle(minX, minY, maxX-minX, maxY-minY);
		}
		
		public static function centerUpright(pt1:Point, pt2:Point, len:Number, direction:String = "up"):Point
		{
			var mid:Point = Point.interpolate(pt1, pt2, 0.5);
			
			var extend:Point = extendPoint(pt1, mid, 0.5, 90);
			var angle1:Number = getAngle(mid, extend);
			var angle2:Number = 180+angle1;
			
			var target1:Point = getTarget(mid, len, angle1);
			var target2:Point = getTarget(mid, len, angle2);
			
			var target:Point;
			
			switch(direction)
			{
				case "up":
					target = target1.y > target2.y ? target2.clone() : target1.clone();
					break;
				case "down":
					target = target1.y > target2.y ? target1.clone() : target2.clone();
					break;
			}
			
			return target;
		}
		
		public static function getTriangleFocus(pnt1:Point, pnt2:Point, pnt3:Point):Point
		{
			return new Point((pnt1.x + pnt2.x + pnt3.x)/3.0, (pnt1.y + pnt2.y + pnt3.y)/3.0);
		}
		
		public static function getQuadrangleFocus(pnt1:Point, pnt2:Point, pnt3:Point, pnt4:Point):Point
		{
			var dab:Point = getTriangleFocus(pnt4, pnt1, pnt2);
			var dcb:Point = getTriangleFocus(pnt4, pnt3, pnt2);
			
			var abc:Point = getTriangleFocus(pnt1, pnt2, pnt3);
			var adc:Point = getTriangleFocus(pnt1, pnt4, pnt3);
			
			var focus:Point = new Point();
			
			findIntersection(dab, dcb, abc, adc, focus);
			
			return focus;
		}
		
		public static function getCenter(left:Point, right:Point, top:Point, bottom:Point):Point
		{
			var hst:Point = new Point();
			var hed:Point = new Point();
			
			var vst:Point = new Point();
			var ved:Point = new Point();
			
			getBisector(left, right, hst, hed);
			getBisector(top, bottom, vst, ved);
			
			var intersect:Point = new Point();
			var num:int = findIntersection(hst, hed, vst, ved, intersect);
			if(num == 1)
			{
				return intersect;
			}
			
			return null;
		}
		
		public static function getBisector(st:Point, ed:Point, pnt1:Point, pnt2:Point):void
		{
			var mid:Point = Point.interpolate(st, ed, 0.5);
			var extend:Point = extendPoint(st, mid, 0.5, 90);
			
			pnt1.x = mid.x; 
			pnt1.y = mid.y;
			
			pnt2.x = extend.x;
			pnt2.y = extend.y;
		}
		
		public static function findIntersection(p0:Point, d0:Point, p1:Point, d1:Point, pnt:Point):int
		{
			if(p0.x == d0.x)
			{
				p0.x += 0.000001;
			}
			
			if(p1.x == d1.x)
			{
				p1.x += 0.000001;
			}
			
			var a1:Number = (d0.y - p0.y)/(p0.x - d0.x);
			var b1:Number = 1;
			var c1:Number = -a1*p0.x - p0.y;
			
			var a2:Number = (d1.y - p1.y)/(p1.x - d1.x);
			var b2:Number = 1;
			var c2:Number = -a2*p1.x - p1.y;
			
			if(a1/a2 != 1)
			{
				pnt.x = (b1*c2-b2*c1)/(a1*b2-a2*b1);
				pnt.y = (c1*a2-c2*a1)/(a1*b2-a2*b1);
				return 1;
			}
			
			if(a1 == a2 && c1 != c2)
			{
				return 0;
			}
			
			return 2;
		}
		
		public static function getTarget(orig:Point, len:Number, angle:Number):Point
		{
			var temp:Point = new Point();
				temp.x = orig.x + len;
				temp.y = orig.y;
			
			return rotatePoint(temp, orig, angle);
		}
		
		public static function getAngle(orig:Point, target:Point):Number
		{
			var dx:Number = target.x - orig.x;
			var dy:Number = target.y - orig.y;
			var radian:Number = Math.atan2(dy, dx);
			return toDegree(radian);
		}
		
		public static function rotatePointAtOrignal(pnt:Point, degree:Number):Point//based on angle
		{
			var rad:Number = degree*Math.PI/180;
			var cos:Number = Math.cos(rad);
			var sin:Number = Math.sin(rad);
			return new Point(cos*pnt.x - sin*pnt.y, cos*pnt.y + sin*pnt.x);
		}
		
		public static function rotatePointAtOrignal2(pnt:Point, radians:Number):Point//based on angle
		{
			var cos:Number = Math.cos(radians);
			var sin:Number = Math.sin(radians);
			return new Point(cos*pnt.x - sin*pnt.y, cos*pnt.y + sin*pnt.x);
		}
		
		public static function rotatePoint(pnt:Point, center:Point, degree:Number):Point//based on angle
		{
			var tx:Number = pnt.x - center.x;
			var ty:Number = pnt.y - center.y;
			
			var rad:Number = degree*Math.PI/180;
			var cos:Number = Math.cos(rad);
			var sin:Number = Math.sin(rad);
			
			var x:Number = cos*tx - sin*ty + center.x;
			var y:Number = cos*ty + sin*tx + center.y;
			
			return new Point(x, y);
		}
		
		public static function rotatePoint2(pnt:Point, center:Point, radians:Number):Point//based on radians
		{
			var tx:Number = pnt.x - center.x;
			var ty:Number = pnt.y - center.y;
			
			var cos:Number = Math.cos(radians);
			var sin:Number = Math.sin(radians);
			
			var x:Number = cos*tx - sin*ty + center.x;
			var y:Number = cos*ty + sin*tx + center.y;
			
			return new Point(x, y);
		}
		
		public static function rotate(obj:DisplayObject, center:Point, angle:Number):void
		{
			var tx:Number = obj.x - center.x;
			var ty:Number = obj.y - center.y;
			obj.rotation += angle;
			
			var rad:Number = toRadian(angle);
			var sin:Number = Math.sin(rad);
			var cos:Number = Math.cos(rad);
			
			obj.x = cos*tx - sin*ty + center.x;
			obj.y = cos*ty + sin*tx + center.y;
		}
		
		public static function scalePoint(pnt:Point, center:Point, value:Number):Point
		{
			var x:Number = center.x+(pnt.x-center.x)*value;
			var y:Number = center.y+(pnt.y-center.y)*value;
			
			return new Point(x, y);
		}
		
		public static function scalePoint2(pnt:Point, center:Point, sx:Number = 1, sy:Number = 1):Point
		{
			var x:Number = center.x+(pnt.x-center.x)*sx;
			var y:Number = center.y+(pnt.y-center.y)*sy;
			
			return new Point(x, y);
		}
		
		public static function scale(obj:DisplayObject, center:Point, value:Number):void
		{
			var sc:Number = obj.scaleX;
			var tx:Number = ((obj.x-center.x)/sc);
			var ty:Number = ((obj.y-center.y)/sc);
			var rs:Number = sc + value;
			
			obj.scaleX = obj.scaleY = rs;
			
			obj.x = tx * rs + center.x;
			obj.y = ty * rs + center.y;
		}
		
		public static function absoluteScale(obj:DisplayObject, center:Point, value:Number):void
		{
			var sc:Number = obj.scaleX;
			var tx:Number = ((obj.x-center.x)/sc);
			var ty:Number = ((obj.y-center.y)/sc);
			var rs:Number = value;
			
			obj.scaleX = obj.scaleY = rs;
			
			obj.x = tx * rs + center.x;
			obj.y = ty * rs + center.y;
		}
	}
}