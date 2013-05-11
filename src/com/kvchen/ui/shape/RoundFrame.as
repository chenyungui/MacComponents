package com.kvchen.ui.shape
{
	import com.kvchen.ui.fillstyle.LineFillStyle;
	import com.kvchen.ui.fillstyle.ShapeFillStyle;
	import com.kvchen.ui.shape.utils.DrawUtils;
	import com.kvchen.ui.math.Math2D;
	
	import flash.display.Graphics;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class RoundFrame extends ShapeBase
	{
		public static const SQRT2:Number = 1.4142135623730951;
		
		private var _TLRadius:Number = 0;
		private var _TRRadius:Number = 0;
		private var _BLRadius:Number = 0;
		private var _BRRadius:Number = 0;
		private var _innerRect:Rectangle;
		private var _InTLRadius:Number = 0;
		private var _InTRRadius:Number = 0;
		private var _InBLRadius:Number = 0;
		private var _InBRRadius:Number = 0;
		
		public function RoundFrame(width:Number = 100, height:Number = 100, TLRadius:Number = 5, TRRadius:Number = 5, BLRadius:Number = 5, BRRadius:Number = 5, 
									 innerRect:Rectangle = null, InTLRadius:Number = 0, InTRRadius:Number = 0, InBLRadius:Number = 0, InBRRadius:Number = 0,
									 lineStyle:LineFillStyle = null, fillStyle:ShapeFillStyle = null)
		{
			this._width = width;
			this._height = height;
			this._TLRadius = TLRadius;
			this._TRRadius = TRRadius;
			this._BLRadius = BLRadius;
			this._BRRadius = BRRadius;
			
			this._innerRect = innerRect;
			this._InTLRadius = InTLRadius;
			this._InTRRadius = InTRRadius;
			this._InBLRadius = InBLRadius;
			this._InBRRadius = InBRRadius;
			
			this._lineStyle = lineStyle;
			this._fillStyle = fillStyle;
			
			if(_innerRect == null){
				_innerRect = new Rectangle(5, 5, _width-10, _height-10);
			}
			
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
		
		public function set innerX(value:Number):void
		{
			this._innerRect.x = value;
			updateShape();
		}
		
		public function set innerY(value:Number):void
		{
			this._innerRect.y = value;
			updateShape();
		}
		
		public function set innerWidth(value:Number):void
		{
			this._innerRect.width = value;
			updateShape();
		}
		
		public function set innerHeight(value:Number):void
		{
			this._innerRect.height = value;
			updateShape();
		}
		
		public function get innerX():Number{ return _innerRect.x; }
		public function get innerY():Number{ return _innerRect.y; }
		public function get innerWidth():Number{ return _innerRect.width; }
		public function get innerHeight():Number{ return _innerRect.height; }
		
		public function set uniformRadius(value:Number):void
		{
			this._TLRadius = value;
			this._TRRadius = value;
			this._BLRadius = value;
			this._BRRadius = value;
			updateShape();
		}
		
		public function set innerUniformRadius(value:Number):void
		{
			this._InTLRadius = value;
			this._InTRRadius = value;
			this._InBLRadius = value;
			this._InBRRadius = value;
			updateShape();
		}
		
		public function get uniformRadius():Number{ return this._TLRadius; }
		public function get innerUniformRadius():Number{ return this._InTLRadius; }
		
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
		
		public function get TLRadius():Number{ return this._TLRadius; }
		public function get TRRadius():Number{ return this._TRRadius; }
		public function get BLRadius():Number{ return this._BLRadius; }
		public function get BRRadius():Number{ return this._BRRadius; }
		
		public function set innerRect(value:Rectangle):void
		{
			this._innerRect = value;
			updateShape();
		}
		
		public function set InTLRadius(value:Number):void
		{
			this._InTLRadius = value;
			updateShape();
		}
		
		public function set InTRRadius(value:Number):void
		{
			this._InTRRadius = value;
			updateShape();
		}
		
		public function set InBLRadius(value:Number):void
		{
			this._InBLRadius = value;
			updateShape();
		}
		
		public function set InBRRadius(value:Number):void
		{
			this._InBRRadius = value;
			updateShape();
		}
		
		public function get innerRect():Rectangle{ return this._innerRect; }
		public function get InTLRadius():Number{ return this._InTLRadius; }
		public function get InTRRadius():Number{ return this._InTRRadius; }
		public function get InBLRadius():Number{ return this._InBLRadius; }
		public function get InBRRadius():Number{ return this._InBRRadius; }
		
		//set easier way to adjust the out corner
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
		
		//set easier way to adjust the inner corner
		public function set innerTopRadius(value:Number):void{
			this._InTLRadius = value;
			this._InTRRadius = value;
			updateShape();
		}
		public function set innerBottomRadius(value:Number):void{
			this._InBLRadius = value;
			this._InBRRadius = value;
			updateShape();
		}
		public function set innerLeftRadius(value:Number):void{
			this._InTLRadius = value;
			this._InBLRadius = value;
			updateShape();
		}
		public function set innerRightRadius(value:Number):void{
			this._InTRRadius = value;
			this._InBRRadius = value;
			updateShape();
		}
		
		public function get innerTopRadius():Number{return _InTLRadius;}
		public function get innerBottomRadius():Number{return _InBLRadius;}
		public function get innerLeftRadius():Number{return _InTLRadius;}
		public function get innerRightRadius():Number{return _InTRRadius;}

		override public function updateShape():void
		{
			this.graphics.clear();
			if((!_lineStyle) && (!_fillStyle)) return;
			super.updateShape();
			
			DrawUtils.drawRoundRect(this.graphics, 0, 0, _width, _height, _TLRadius, _TRRadius, _BRRadius, _BLRadius);
			DrawUtils.drawReverseRoundRect(this.graphics, _innerRect.x, _innerRect.y, _innerRect.width, _innerRect.height, _InTLRadius, _InTRRadius, _InBRRadius, _InBLRadius);
			this.graphics.endFill();
		}
	}
}