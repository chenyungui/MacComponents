package com.kvchen.ui.shape
{
	import com.kvchen.ui.fillstyle.LineFillStyle;
	import com.kvchen.ui.fillstyle.ShapeFillStyle;
	import com.kvchen.ui.shape.utils.DrawUtils;
	
	import flash.geom.Point;
	
	public class Handle extends ShapeBase
	{
		public static const SQRT2:Number = 1.4142135623730951;
		
		private var _TLRadius:Number = 0;
		private var _TRRadius:Number = 0;
		private var _arrowHeight:Number = 0;
		
		public function Handle(width:Number = 16, height:Number = 11, TLRadius:Number = 3, TRRadius:Number = 3, arrowHeight:Number = 7, lineStyle:LineFillStyle = null, fillStyle:ShapeFillStyle = null)
		{
			this._width = width;
			this._height = height;
			this._TLRadius = TLRadius;
			this._TRRadius = TRRadius;
			this._arrowHeight = arrowHeight;
			this._lineStyle = lineStyle;
			this._fillStyle = fillStyle;
			updateShape();
		}
		
		override public function set width(value:Number):void
		{
			if(this._width == value) return;
			this._width = value;
			updateShape();
		}
		
		override public function set height(value:Number):void
		{
			if(this._height == value) return;
			this._height = value;
			updateShape();
		}
		
		public function set TLRadius(value:Number):void
		{
			this._TLRadius = value;
			updateShape();
		}
		
		public function set TRRadius(value:Number):void
		{
			this._TRRadius = value;
			updateShape();
		}
		
		public function set arrowHeight(value:Number):void
		{
			this._arrowHeight = value;
			updateShape();
		}
		
		override public function updateShape():void
		{
			this.graphics.clear();
			if((!_lineStyle) && (!_fillStyle)) return;
			super.updateShape();
			
			var startPoint:Point = new Point(0, _TLRadius);
			var controlPoint:Point = new Point();
			var endPoint:Point = new Point(_TLRadius, 0);
			
			this.graphics.moveTo(0, _TLRadius);
			DrawUtils.drawRoundCorner(this.graphics, startPoint, controlPoint, endPoint);
			
			startPoint.x = _width-_TRRadius;
			startPoint.y = 0;
			controlPoint.x = _width;
			controlPoint.y = 0;
			endPoint.x = _width;
			endPoint.y = _TRRadius;
			
			this.graphics.lineTo(startPoint.x, startPoint.y);
			DrawUtils.drawRoundCorner(this.graphics, startPoint, controlPoint, endPoint);
			
			this.graphics.lineTo(_width, _height);
			this.graphics.lineTo(_width/2, _height+_arrowHeight);
			this.graphics.lineTo(0, _height);
			this.graphics.lineTo(0, _TLRadius);
			
			this.graphics.endFill();
		}
	}
}