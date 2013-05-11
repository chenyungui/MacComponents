package com.kvchen.ui.shape
{
	import com.kvchen.ui.fillstyle.LineFillStyle;
	import com.kvchen.ui.fillstyle.ShapeFillStyle;
	import com.kvchen.ui.fillstyle.data.BitmapFillData;
	import com.kvchen.ui.fillstyle.data.GradientFillData;
	import com.kvchen.ui.fillstyle.data.LineStyleData;
	import com.kvchen.ui.fillstyle.data.SolidFillData;
	import com.kvchen.ui.fillstyle.enum.FillType;
	import com.kvchen.ui.filters.DropShadowFilterSetting;
	import com.kvchen.ui.filters.GlowFilterSetting;
	import com.kvchen.ui.shape.protocol.IFillable;
	import com.kvchen.ui.shape.protocol.IFilterable;
	import com.kvchen.ui.utils.ArrayUtils;
	import com.kvchen.ui.math.Math2D;
	
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class ShapeBase extends Sprite implements IFillable, IFilterable
	{
		protected var _x:Number = 0;
		protected var _y:Number = 0;

		protected var _width:Number = 0;
		protected var _height:Number = 0;
		
		protected var _lineStyle:LineFillStyle = null;
		protected var _fillStyle:ShapeFillStyle = null;
		
		protected var _dropShadowFilter:DropShadowFilter = null;
		protected var _glowFilter:GlowFilter = null;
		
		public function ShapeBase()
		{
			
		}
		
		public function get dropShadowFilter():DropShadowFilter{
			return _dropShadowFilter;
		}
		
		public function set dropShadowFilter(value:DropShadowFilter):void{
			this._dropShadowFilter = value;
			updateFilters();
		}
		
		public function get glowFilter():GlowFilter{
			return _glowFilter;
		}
		
		public function set glowFilter(value:GlowFilter):void{
			this._glowFilter = value;
			updateFilters();
		}
		
		public function updateFilters():void{
			var filters:Array = new Array();
			if(_dropShadowFilter != null) filters.push(_dropShadowFilter);
			if(_glowFilter != null) filters.push(_glowFilter);
			this.filters = filters;
		}
		
		public function set lineStyle(style:LineFillStyle):void
		{
			this._lineStyle = style;
			updateShape();
		}
		
		public function set fillStyle(style:ShapeFillStyle):void
		{
			this._fillStyle = style;
			updateShape();
		}
		
		public function get lineStyle():LineFillStyle
		{
			return _lineStyle;
		}
		
		public function get fillStyle():ShapeFillStyle
		{
			return _fillStyle;
		}
		
		public function getFillMatrix(angle:Number):Matrix
		{
			var rectangle:Rectangle = new Rectangle(_x, _y, _width, _height);
			//the boundingBox after rotate the orig rectangle
			var boundingBox:Rectangle = rotateRect(rectangle, -angle);
			//rotate back the start point
			var startPnt:Point = Math2D.rotatePointAtOrignal(boundingBox.topLeft, angle);
			var radians:Number = angle * Math.PI/180;
			var rectCenter:Point = Point.interpolate(rectangle.topLeft, rectangle.bottomRight, 0.5);
			var bbCenter:Point = new Point(boundingBox.width/2, boundingBox.width/2);
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(boundingBox.width, boundingBox.width, radians, rectCenter.x - bbCenter.x, rectCenter.y - bbCenter.y);
			return matrix;
		}
		
		protected function rotateRect(rect:Rectangle, degree:Number):Rectangle
		{
			var pnt0:Point = rect.topLeft;
			var pnt1:Point = new Point(rect.right, rect.y);
			var pnt2:Point = rect.bottomRight;
			var pnt3:Point = new Point(rect.x, rect.bottom);
			pnt0 = Math2D.rotatePointAtOrignal(pnt0, degree);
			pnt1 = Math2D.rotatePointAtOrignal(pnt1, degree);
			pnt2 = Math2D.rotatePointAtOrignal(pnt2, degree);
			pnt3 = Math2D.rotatePointAtOrignal(pnt3, degree);
			return Math2D.getBoundingBox2([pnt0, pnt1, pnt2, pnt3]);
		}
		
		public function updateShape():void
		{
			if(_lineStyle != null) setLineStyle(_lineStyle);
			if(_fillStyle != null) setFillStyle(_fillStyle);
		}
		
		protected function setLineStyle(style:LineFillStyle):void
		{
			switch(style.fillType){
				case FillType.SOLIDE:
					var s:LineStyleData = style.lineStyleData;
					this.graphics.lineStyle(s.thickness, s.color, s.alpha, s.pixelHinting, s.scaleMode, s.caps, s.joints, s.miterLimit);
					break;
				case FillType.GRADIENT:
					var g:GradientFillData = style.gradientFillData;
					var matrix:Matrix = getFillMatrix(g.angle);
					this.graphics.lineGradientStyle(g.type, g.colors, g.alphas, g.ratios, matrix, g.spreadMethod, g.interpolationMethod, g.focalPointRatio);
					break;
				case FillType.BITMPA:
					var b:BitmapFillData = style.bitmapFillData;
					this.graphics.lineBitmapStyle(b.bitmap, b.matrix, b.repeat, b.smooth);
					break;
			}
		}
		
		protected function setFillStyle(style:ShapeFillStyle):void
		{
			switch(style.fillType){
				case FillType.SOLIDE:
					var s:SolidFillData = style.solidFillData;
					this.graphics.beginFill(s.color, s.alpha);
					break;
				case FillType.GRADIENT:
					var g:GradientFillData = style.gradientFillData;
					var matrix:Matrix = getFillMatrix(g.angle);
					this.graphics.beginGradientFill(g.type, g.colors, g.alphas, g.ratios, matrix, g.spreadMethod, g.interpolationMethod, g.focalPointRatio);
					break;
				case FillType.BITMPA:
					var b:BitmapFillData = style.bitmapFillData;
					this.graphics.beginBitmapFill(b.bitmap, b.matrix, b.repeat, b.smooth);
					break;
			}
		}
		
		protected function getFiltersDeclareString():String{
			var result:String = "";
			if(_dropShadowFilter != null){
				result += DropShadowFilterSetting.createFromDropShadowFilter(_dropShadowFilter).toString() + "\n";
			}
			if(_glowFilter != null){
				result += GlowFilterSetting.createFromGlowFilter(_glowFilter).toString();
			}
			return result;
		}
		protected function getFiltersApplyString(objectName:String):String{
			var filters:Array = [_dropShadowFilter, _glowFilter];
			filters = ArrayUtils.removeNullObject(filters);
			if(filters.length == 0){
				return "";
			}
			var result:String = objectName + ".filters = [";
			for (var i:int = 0; i < filters.length; i++) 
			{
					if(filters[i] is DropShadowFilter){
						result += "dropShadowFilter";
					}else if(filters[i] is GlowFilter){
						result += "glowFilter";
					}
				if(i == filters.length-1){
					result += "];";
				}else{
					result += ", ";
				}
			}
			return result;
		}
	}
}