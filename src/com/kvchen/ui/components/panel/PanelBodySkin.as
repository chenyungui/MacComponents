package com.kvchen.ui.components.panel
{
	import com.kvchen.ui.fillstyle.ShapeFillStyle;
	import com.kvchen.ui.fillstyle.data.SolidFillData;
	import com.kvchen.ui.shape.RoundFrameRect;
	
	public class PanelBodySkin extends RoundFrameRect
	{
		public function PanelBodySkin(width:Number, height:Number)
		{
			var solidFillData0:SolidFillData = new SolidFillData(0xb0b0b0, 0.9);
			var borderFillStyle:ShapeFillStyle = ShapeFillStyle.createBySolidFillData(solidFillData0);
			var solidFillData:SolidFillData = new SolidFillData(0xe8e9e8, 1);
			var shapeFillStyle:ShapeFillStyle = ShapeFillStyle.createBySolidFillData(solidFillData);
			super(width, height, 0, 0, 5, 5, 1, null, borderFillStyle, shapeFillStyle);
		}
	}
}