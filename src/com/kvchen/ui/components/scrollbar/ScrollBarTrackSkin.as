package com.kvchen.ui.components.scrollbar
{
	import com.kvchen.ui.fillstyle.ShapeFillStyle;
	import com.kvchen.ui.fillstyle.data.SolidFillData;
	import com.kvchen.ui.shape.RoundFrameRect;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class ScrollBarTrackSkin extends RoundFrameRect
	{
		protected var _orientation:String;
		protected var _size:Number;
		
		public function ScrollBarTrackSkin(orientation:String = "vertical", size:Number = 100)
		{
			_orientation = orientation;
			_size = size;
			
			var solidFillData0:SolidFillData = new SolidFillData(0xa9a9a9, 1);
			var borderFillStyle:ShapeFillStyle = ShapeFillStyle.createBySolidFillData(solidFillData0);
			var solidFillData:SolidFillData = new SolidFillData(0xe3e3e3, 0.8);
			var shapeFillStyle:ShapeFillStyle = ShapeFillStyle.createBySolidFillData(solidFillData);
			var w:Number = 17, h:Number = 17;
			if(orientation == ScrollBar.HORIZONTAL){
				w = _size;
			}else if(orientation == ScrollBar.VERTICAL){
				h = _size;
			}
			super(w, h, 0, 0, 0, 0, 1, null, borderFillStyle, shapeFillStyle);
		}
		
		public function set size(value:Number):void{
			_size = value;
			if(_orientation == ScrollBar.HORIZONTAL){
				this.width = _size;
			}else if(_orientation == ScrollBar.VERTICAL){
				this.height = _size;
			}
		}
		
		public function get size():Number
		{
			return _size;
		}
	}
}