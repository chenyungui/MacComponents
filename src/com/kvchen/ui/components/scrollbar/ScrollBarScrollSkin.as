package com.kvchen.ui.components.scrollbar
{
	import com.kvchen.ui.fillstyle.ShapeFillStyle;
	import com.kvchen.ui.fillstyle.data.SolidFillData;
	import com.kvchen.ui.shape.RoundFrameRect;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class ScrollBarScrollSkin extends RoundFrameRect
	{
		protected var _orientation:String;
		protected var _size:Number;
		
		public function ScrollBarScrollSkin(orientation:String = "vertical", size:Number = 100)
		{
			_orientation = orientation;
			_size = size;
			
			var solidFillData0:SolidFillData = new SolidFillData(0xa9a9a9, 1);
			var borderFillStyle:ShapeFillStyle = ShapeFillStyle.createBySolidFillData(solidFillData0);
			var solidFillData:SolidFillData = new SolidFillData(0x505050, 0.8439024390243902);
			var shapeFillStyle:ShapeFillStyle = ShapeFillStyle.createBySolidFillData(solidFillData);
			var w:Number = 11, h:Number = 11;
			if(orientation == ScrollBar.HORIZONTAL){
				w = _size;
			}else if(orientation == ScrollBar.VERTICAL){
				h = _size;
			}
			super(w, h, 5, 5, 5, 5, 0, null, borderFillStyle, shapeFillStyle);
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