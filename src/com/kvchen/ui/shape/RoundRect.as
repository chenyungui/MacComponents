package com.kvchen.ui.shape
{
	import com.kvchen.ui.fillstyle.LineFillStyle;
	import com.kvchen.ui.fillstyle.ShapeFillStyle;
	import com.kvchen.ui.shape.utils.DrawUtils;
	import com.kvchen.ui.math.Math2D;
	
	import flash.display.Graphics;
	import flash.geom.Point;
	
	public class RoundRect extends ShapeBase
	{
		public static const SQRT2:Number = 1.4142135623730951;
		
		private var _TLRadius:Number = 0;
		private var _TRRadius:Number = 0;
		private var _BLRadius:Number = 0;
		private var _BRRadius:Number = 0;
		
		public function RoundRect(width:Number = 100, height:Number = 100, TLRadius:Number = 5, TRRadius:Number = 5, BLRadius:Number = 5, BRRadius:Number = 5, lineStyle:LineFillStyle = null, fillStyle:ShapeFillStyle = null)
		{
			this._width = width;
			this._height = height;
			this._TLRadius = TLRadius;
			this._TRRadius = TRRadius;
			this._BLRadius = BLRadius;
			this._BRRadius = BRRadius;
			this._lineStyle = lineStyle;
			this._fillStyle = fillStyle;
			updateShape();
		}
		
		public function setSize(width:Number, height:Number):void
		{
			if(_width == width && _height == height){
				return;
			}
			this._width = width;
			this._height = height;
			updateShape();
		}
		
		override public function set width(value:Number):void
		{
			if(value != _width){
				this._width = value;
				updateShape();
			}
		}
		
		override public function set height(value:Number):void
		{
			if(value != _height){
				this._height = value;
				updateShape();
			}
		}

		
		public function set uniformRadius(value:Number):void
		{
			this._TLRadius = value;
			this._TRRadius = value;
			this._BLRadius = value;
			this._BRRadius = value;
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
		
		public function set BLRadius(value:Number):void
		{
			this._BLRadius = value;
			updateShape();
		}
		
		public function set BRRadius(value:Number):void
		{
			this._BRRadius = value;
			updateShape();
		}
		
		public function set topRadius(value:Number):void{
			this._TLRadius = value;
			this._TRRadius = value;
			updateShape();
		}
		public function set bottomRadius(value:Number):void{
			this._BLRadius = value;
			this._BRRadius = value;
			updateShape();
		}
		public function set leftRadius(value:Number):void{
			this._TLRadius = value;
			this._BLRadius = value;
			updateShape();
		}
		public function set rightRadius(value:Number):void{
			this._TRRadius = value;
			this._BRRadius = value;
			updateShape();
		}
		
		public function get topRadius():Number{return _TLRadius;}
		public function get bottomRadius():Number{return _BLRadius;}
		public function get leftRadius():Number{return _TLRadius;}
		public function get rightRadius():Number{return _TRRadius;}
		
		public function get uniformRadius():Number
		{
			return this._TLRadius;
		}
		
		public function get TLRadius():Number
		{
			return this._TLRadius;
		}
		
		public function get TRRadius():Number
		{
			return this._TRRadius;
		}
		
		public function get BLRadius():Number
		{
			return this._BLRadius;
		}
		
		public function get BRRadius():Number
		{
			return this._BRRadius;
		}
		
		override public function updateShape():void
		{
			this.graphics.clear();
			if((!_lineStyle) && (!_fillStyle)) return;
			super.updateShape();
			
			DrawUtils.drawRoundRect(this.graphics, 0, 0, _width, _height, _TLRadius, _TRRadius, _BRRadius, _BLRadius);
			
			this.graphics.endFill();
		}
		
		override public function toString():String
		{
			var result:String = "";
			
			if(lineStyle != null){
				result += _lineStyle.toString() + "\n";
			}
			if(fillStyle != null){
				result += _fillStyle.toString() + "\n";
			}
			
			result += "var roundRect:RoundRect = new RoundRect(";
			result += this._width + ", "; 
			result += this._height + ", "; 
			result += this._TLRadius + ", "; 
			result += this._TRRadius + ", "; 
			result += this._BLRadius + ", "; 
			result += this._BRRadius + ", "; 
			
			if(lineStyle != null){
				result += "lineFillStyle, ";
			}else{
				result += "null, ";
			}
			if(fillStyle != null){
				result += "shapeFillStyle);";
			}else{
				result += "null);";
			}
			return result;
		}
	}
}