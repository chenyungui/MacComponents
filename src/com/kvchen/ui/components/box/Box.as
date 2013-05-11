package com.kvchen.ui.components.box
{
	import com.kvchen.ui.fillstyle.ShapeFillStyle;
	import com.kvchen.ui.fillstyle.data.SolidFillData;
	import com.kvchen.ui.shape.RoundFrameRect;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	
	public class Box extends RoundFrameRect
	{
		public function Box(width:Number = 200, height:Number = 200)
		{
			var solidFillData0:SolidFillData = new SolidFillData(0xb5b5b5, 1);
			var borderFillStyle:ShapeFillStyle = ShapeFillStyle.createBySolidFillData(solidFillData0);
			var solidFillData:SolidFillData = new SolidFillData(0xdddddd, 1);
			var shapeFillStyle:ShapeFillStyle = ShapeFillStyle.createBySolidFillData(solidFillData);
			var glowFilter:GlowFilter = new GlowFilter(12303291, 1, 3, 3, 2, 5, true);
			super(width, height, 5, 5, 5, 5, 1, null, borderFillStyle, shapeFillStyle);
			this.filters = [glowFilter];
		}
	}
}