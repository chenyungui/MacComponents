package com.kvchen.ui.shape
{
	import com.kvchen.ui.fillstyle.LineFillStyle;
	import com.kvchen.ui.fillstyle.ShapeFillStyle;
	import com.kvchen.ui.shape.utils.DrawUtils;
	
	public class RoundFrameRect extends ShapeBase
	{
		private var _TLRadius:Number = 0;
		private var _TRRadius:Number = 0;
		private var _BLRadius:Number = 0;
		private var _BRRadius:Number = 0;
		private var _border:Number;
		
		private var _shapeFillStyle:ShapeFillStyle;
		
		public function RoundFrameRect(width:Number, height:Number, TLRadius:Number = 5, TRRadius:Number = 5, BLRadius:Number = 5, BRRadius:Number = 5, border:Number = 2, lineStyle:LineFillStyle = null, borderFillStyle:ShapeFillStyle=null, shapeFillStyle:ShapeFillStyle = null)
		{
			this._width = width;
			this._height = height;
			this._TLRadius = TLRadius;
			this._TRRadius = TRRadius;
			this._BLRadius = BLRadius;
			this._BRRadius = BRRadius;
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
		
		public function set border(value:Number):void
		{
			this._border = value;
			updateShape();
		}
		
		//getters
		
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
		
		public function get border():Number
		{
			return this._border;
		}
		
		//for simplfy
		
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


		override public function updateShape():void
		{
			this.graphics.clear();
			if((!_lineStyle) && (!_fillStyle)) return;
			super.updateShape();
						
			DrawUtils.drawRoundRect(this.graphics, 0, 0, _width, _height, _TLRadius, _TRRadius, _BRRadius, _BLRadius);
			DrawUtils.drawReverseRoundRect(this.graphics, _border, _border, _width-2*_border, _height-2*_border, _TLRadius-_border, _TRRadius-_border, _BRRadius-_border, _BLRadius-_border);

			this.graphics.endFill();
			
			if(_shapeFillStyle != null){
				setFillStyle(_shapeFillStyle);
				DrawUtils.drawRoundRect(this.graphics, _border, _border, _width-2*_border, _height-2*_border, _TLRadius-_border, _TRRadius-_border, _BRRadius-_border, _BLRadius-_border);
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
			
			result += "var roundFrameRect:RoundFrameRect = new RoundFrameRect(";
			result += this._width + ", "; 
			result += this._height + ", "; 
			result += this._TLRadius + ", "; 
			result += this._TRRadius + ", "; 
			result += this._BLRadius + ", "; 
			result += this._BRRadius + ", "; 
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
			result += getFiltersApplyString("roundFrameRect");
			
			return result;
		}
	}
}