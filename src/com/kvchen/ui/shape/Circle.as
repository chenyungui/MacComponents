package com.kvchen.ui.shape
{
	import com.kvchen.ui.fillstyle.LineFillStyle;
	import com.kvchen.ui.fillstyle.ShapeFillStyle;
	import com.kvchen.ui.shape.ShapeBase;
	
	public class Circle extends ShapeBase
	{
		private var _radius:Number;
		
		public function Circle(radius:Number, lineStyle:LineFillStyle = null, fillStyle:ShapeFillStyle = null)
		{
			this.radius = radius;
			this._lineStyle = lineStyle;
			this._fillStyle = fillStyle;
			updateShape();
		}
		
		public function set radius(value:Number):void
		{
			this._radius = value;
			this._x = -_radius;
			this._y = -_radius;
			this._width = _radius * 2;
			this._height = _radius * 2;
			updateShape();
		}
		
		public function get radius():Number
		{
			return _radius;
		}
		
		override public function updateShape():void
		{
			this.graphics.clear();
			if((!_lineStyle) && (!_fillStyle)) return;
			super.updateShape();
			
			this.graphics.drawCircle(0, 0, _radius);
			this.graphics.endFill();
		}
	}
}