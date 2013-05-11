package com.kvchen.ui.components.panel
{
	import com.kvchen.ui.components.label.Label;
	import com.kvchen.ui.fillstyle.ShapeFillStyle;
	import com.kvchen.ui.fillstyle.data.GradientFillData;
	import com.kvchen.ui.fillstyle.data.SolidFillData;
	import com.kvchen.ui.shape.RingCircle;
	import com.kvchen.ui.shape.RoundFrameRect;
	
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.text.TextFormatAlign;
	
	public class PanelCloseButton extends SimpleButton
	{
		public function PanelCloseButton()
		{
			var upSkin:DisplayObject = createUpSkin();
			var overSkin:DisplayObject = createOverSkin();
			var downSkin:DisplayObject = createDownSkin();
			var hitSkin:DisplayObject = createUpSkin();
			super(upSkin, overSkin, downSkin, hitSkin);
		}
		
		protected function createUpSkin():DisplayObject
		{
			var gradientFillData0:GradientFillData = new GradientFillData(GradientType.LINEAR, [0x562727,0xa3605f],[0.80,0.80],[0,255],90);
			var borderFillStyle:ShapeFillStyle = ShapeFillStyle.createByGradientFillData(gradientFillData0);
			var gradientFillData:GradientFillData = new GradientFillData(GradientType.LINEAR, [0xfce9de,0xf17672,0xf43a39,0xfc7a76,0xf9acac],[1.00,1.00,1.00,1.00,1.00],[15,75,110,170,223],90);
			var shapeFillStyle:ShapeFillStyle = ShapeFillStyle.createByGradientFillData(gradientFillData);
			var dropShadowFilter:DropShadowFilter = new DropShadowFilter(1, 90, 16777215, 1, 2, 2, 1, 5);
			var ringCircle:RingCircle = new RingCircle(6, 1, null, borderFillStyle, shapeFillStyle);
			ringCircle.filters = [dropShadowFilter];
			return ringCircle;
		}
		
		protected function createOverSkin():DisplayObject
		{
			var con:Sprite = new Sprite();
			var gradientFillData0:GradientFillData = new GradientFillData(GradientType.LINEAR, [0x562727,0xa3605f],[0.80,0.80],[0,255],90);
			var borderFillStyle:ShapeFillStyle = ShapeFillStyle.createByGradientFillData(gradientFillData0);
			var gradientFillData:GradientFillData = new GradientFillData(GradientType.LINEAR, [0xfce9de,0xf17672,0xf43a39,0xfc7a76,0xf9acac],[1.00,1.00,1.00,1.00,1.00],[15,75,110,170,223],90);
			var shapeFillStyle:ShapeFillStyle = ShapeFillStyle.createByGradientFillData(gradientFillData);
			var dropShadowFilter:DropShadowFilter = new DropShadowFilter(1, 90, 16777215, 1, 2, 2, 1, 5);
			var ringCircle:RingCircle = new RingCircle(6, 1, null, borderFillStyle, shapeFillStyle);
			ringCircle.filters = [dropShadowFilter];
			con.addChild(ringCircle);
			con.addChild(createCloseIcon(0xa90300));
			return con;
		}
		
		protected function createDownSkin():DisplayObject{
			var con:Sprite = new Sprite();
			var gradientFillData0:GradientFillData = new GradientFillData(GradientType.LINEAR, [0x3b1d1b,0x724444],[1.00,1.00],[0,255],90);
			var borderFillStyle:ShapeFillStyle = ShapeFillStyle.createByGradientFillData(gradientFillData0);
			var gradientFillData:GradientFillData = new GradientFillData(GradientType.LINEAR, [0xaea09a,0xa22322,0x976e6e],[1.00,1.00,1.00],[0,90,220],90);
			var shapeFillStyle:ShapeFillStyle = ShapeFillStyle.createByGradientFillData(gradientFillData);
			var dropShadowFilter:DropShadowFilter = new DropShadowFilter(1, 90, 16777215, 1, 2, 2, 1, 5);
			var ringCircle:RingCircle = new RingCircle(6, 1, null, borderFillStyle, shapeFillStyle);
			ringCircle.filters = [dropShadowFilter];
			con.addChild(ringCircle);
			con.addChild(createCloseIcon(0x5c0002));
			return con;
		}
		
		protected function createCloseIcon(color:uint):DisplayObject{
			var data:Vector.<Number> = new Vector.<Number>();
			data.push(2.060,-3.122,2.559,-3.441,2.778,-3.222,2.997,-3.003,3.215,-2.785,3.433,-2.567,3.113,-2.067,2.793,-1.566,1.935,-0.783,1.506,-0.391,1.077,0.000,1.077,0.000,1.077,0.000,1.077,0.000,1.077,0.000,1.495,0.400,1.914,0.801,2.751,1.602,3.071,2.102,3.391,2.601,3.194,2.799,2.997,2.997,2.799,3.194,2.601,3.391,2.102,3.071,1.602,2.751,0.801,1.914,0.400,1.495,0.000,1.077,0.000,1.077,0.000,1.077,0.000,1.077,0.000,1.077,-0.397,1.500,-0.795,1.923,-1.590,2.769,-2.091,3.089,-2.591,3.409,-2.797,3.203,-3.003,2.997,-3.210,2.790,-3.417,2.583,-3.098,2.084,-2.778,1.584,-1.932,0.792,-1.509,0.396,-1.086,0.000,-1.086,0.000,-1.086,0.000,-1.086,0.000,-1.086,0.000,-1.510,-0.396,-1.934,-0.793,-2.782,-1.586,-3.102,-2.087,-3.421,-2.587,-3.212,-2.795,-3.003,-3.003,-2.795,-3.212,-2.587,-3.421,-2.087,-3.102,-1.586,-2.782,-0.793,-1.934,-0.396,-1.510,0.000,-1.086,0.000,-1.086,0.000,-1.086,0.000,-1.086,0.000,-1.086,0.390,-1.515,0.780,-1.944,1.560,-2.802,2.060,-3.122);
			var command:Vector.<int> = new Vector.<int>();
			command.push(1,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6);
			var s:Shape = new Shape();
			s.graphics.beginFill(color, 1);
			s.graphics.drawPath(command, data);
			s.graphics.endFill();
			var glowFilter:GlowFilter = new GlowFilter(0x0, .3, 1, 1, 2, 5, true);
			s.filters = [glowFilter];
			return s;
		}
	}
}