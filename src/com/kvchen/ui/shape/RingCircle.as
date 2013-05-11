package com.kvchen.ui.shape
{
	import com.kvchen.ui.fillstyle.LineFillStyle;
	import com.kvchen.ui.fillstyle.ShapeFillStyle;
	import com.kvchen.ui.shape.utils.DrawUtils;
	
	public class RingCircle extends ShapeBase
	{
		private var _radius:Number;
		private var _border:Number;
		
		private var _shapeFillStyle:ShapeFillStyle;

		public function RingCircle(radius:Number, border:Number, lineStyle:LineFillStyle = null, borderFillStyle:ShapeFillStyle=null, shapeFillStyle:ShapeFillStyle = null)
		{
			this.radius = radius;
			this._border = border;
			this._lineStyle = lineStyle;
			this._fillStyle = borderFillStyle;
			this._shapeFillStyle = shapeFillStyle;
			updateShape();
		}
		
		public function set borderFillStyle(shapeFillStyle:ShapeFillStyle):void{
			this._fillStyle = shapeFillStyle;
			updateShape();
		}
		
		public function set shapeFillStyle(shapeFillStyle:ShapeFillStyle):void{
			this._shapeFillStyle = shapeFillStyle;
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
		
		public function set border(value:Number):void
		{
			this._border = value;
			updateShape();
		}
		
		public function get radius():Number
		{
			return _radius;
		}
		
		public function get border():Number
		{
			return _border;
		}
		
		override public function updateShape():void
		{
			this.graphics.clear();
			if((!_lineStyle) && (!_fillStyle)) return;
			super.updateShape();
			
			this.graphics.drawCircle(0, 0, _radius);
			DrawUtils.drawReverseCircle(this.graphics, _radius-_border);
			this.graphics.endFill();
			
			if(_shapeFillStyle != null){
				setFillStyle(_shapeFillStyle);
				this.graphics.drawCircle(0, 0, _radius-_border);
				this.graphics.endFill();
			}
		}
		
		override public function toString():String
		{
			var result:String = "";
			
			if(lineStyle != null){
				result += _lineStyle.toString() + "\n";
			}
			if(fillStyle != null){
				var borderFill:String = _fillStyle.toString() + "\n";
				//do replace
				var reg:RegExp = new RegExp("shapeFillStyle", "g");
				borderFill = borderFill.replace(reg, "borderFillStyle");
				
				result += borderFill;
			}
			if(_shapeFillStyle != null){
				result += _shapeFillStyle.toString() + "\n";
			}
			
			result += getFiltersDeclareString() + "\n";
			
			result += "var ringCircle:RingCircle = new RingCircle(";
			result += this._radius + ", "; 
			result += this._border + ", "; 
			
			if(lineStyle != null){
				result += "lineFillStyle, ";
			}else{
				result += "null, ";
			}
			if(fillStyle != null){
				result += "borderFillStyle, ";
			}else{
				result += "null, ";
			}
			if(_shapeFillStyle != null){
				result += "shapeFillStyle);";
			}else{
				result += "null);";
			}
			result += "\n";
			
			result += getFiltersApplyString("ringCircle");
			
			return result;
		}
	}
}