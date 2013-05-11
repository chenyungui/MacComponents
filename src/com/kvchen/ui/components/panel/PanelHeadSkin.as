package com.kvchen.ui.components.panel
{
	import com.kvchen.ui.fillstyle.ShapeFillStyle;
	import com.kvchen.ui.fillstyle.data.GradientFillData;
	import com.kvchen.ui.shape.RoundFrameRect;
	
	import flash.display.GradientType;
	
	public class PanelHeadSkin extends RoundFrameRect
	{
		public function PanelHeadSkin(width:Number, height:Number = 23)
		{
			var gradientFillData0:GradientFillData = new GradientFillData(GradientType.LINEAR, [0xb1b1b1,0x575757],[1.00,1.00],[228,255],90);
			var borderFillStyle:ShapeFillStyle = ShapeFillStyle.createByGradientFillData(gradientFillData0);
			var gradientFillData:GradientFillData = new GradientFillData(GradientType.LINEAR, [0xededed,0xb1b0b2],[1.00,1.00],[0,255],90);
			var shapeFillStyle:ShapeFillStyle = ShapeFillStyle.createByGradientFillData(gradientFillData);
			super(width, height, 5, 5, 0, 0, 1, null, borderFillStyle, shapeFillStyle);
		}
	}
}