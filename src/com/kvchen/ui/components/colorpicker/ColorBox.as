package com.kvchen.ui.components.colorpicker
{
	import com.kvchen.ui.fillstyle.ShapeFillStyle;
	import com.kvchen.ui.fillstyle.data.SolidFillData;
	import com.kvchen.ui.shape.RoundFrameRect;
	
	import flash.display.Sprite;
	
	public class ColorBox extends RoundFrameRect
	{
		protected var _selected:Boolean = false;
		protected var _color:uint;
		
		public function ColorBox(color:uint, width:Number, height:Number)
		{
			_color = color;
			var borderFill:SolidFillData = new SolidFillData(0x0);
			var fill:SolidFillData = new SolidFillData(color);
			super(width, height, 0, 0, 0, 0, 1, null, ShapeFillStyle.createBySolidFillData(borderFill), ShapeFillStyle.createBySolidFillData(fill));
		}
		
		public function get color():uint
		{
			return _color;
		}
		
		public function get selected():Boolean
		{
			return _selected;
		}

		public function set selected(value:Boolean):void
		{
			_selected = value;
			var borderColor:uint = _selected ? 0xffffff : 0x000000;
			var borderFill:SolidFillData = new SolidFillData(borderColor);
			borderFillStyle = ShapeFillStyle.createBySolidFillData(borderFill);
		}
	}
}