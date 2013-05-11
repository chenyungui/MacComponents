package com.kvchen.ui.shape
{
	import com.kvchen.ui.fillstyle.LineFillStyle;
	import com.kvchen.ui.fillstyle.ShapeFillStyle;
	import com.kvchen.ui.shape.utils.DrawUtils;
	
	public class Ring extends ShapeBase
	{
		private var _radiusOut:Number;
		private var _radiusIn:Number;
		
		public function Ring(radiusOut:Number, radiusIn:Number, lineStyle:LineFillStyle = null, fillStyle:ShapeFillStyle = null)
		{
			this._radiusOut = radiusOut;
			this._radiusIn = radiusIn;
			this._lineStyle = lineStyle;
			this._fillStyle = fillStyle;
			updateShape();
		}
		
		public function set radiusOut(value:Number):void
		{
			this._radiusOut = value;
			this._x = -_radiusOut;
			this._y = -_radiusOut;
			this._width = _radiusOut * 2;
			this._height = _radiusOut * 2;
			updateShape();
		}
		
		public function set radiusIn(value:Number):void
		{
			this._radiusIn = value;
			updateShape();
		}
		
		public function get radiusOut():Number
		{
			return _radiusOut;
		}
		
		public function get radiusIn():Number
		{
			return _radiusIn;
		}
		
		override public function updateShape():void
		{
			this.graphics.clear();
			if((!_lineStyle) && (!_fillStyle)) return;
			super.updateShape();
			
			this.graphics.drawCircle(0, 0, _radiusOut);
			DrawUtils.drawReverseCircle(this.graphics, _radiusIn);
			this.graphics.endFill();
		}
	}
}