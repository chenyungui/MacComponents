package com.kvchen.ui.components.checkbox
{
	import com.kvchen.ui.components.togglebutton.ToggleButton;
	import com.kvchen.ui.fillstyle.ShapeFillStyle;
	import com.kvchen.ui.fillstyle.data.GradientFillData;
	import com.kvchen.ui.fillstyle.data.SolidFillData;
	import com.kvchen.ui.shape.RoundFrameRect;
	
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	
	public class CheckBox extends ToggleButton
	{
		private var _shapeOffsetX:Number = 4;
		private var _shapeOffsetY:Number = 4;
		
		protected var _onState:DisplayObject;
		protected var _offState:DisplayObject;
		
		public function CheckBox(selected:Boolean = false, clickHandler:Function = null)
		{
			_onState = createCheckOnSkin();
			_offState = createCheckOffSkin();
			
			super(_onState, _offState, selected, clickHandler);
		}
		
		override public function get width():Number
		{
			return 22;
		}
		override public function get height():Number
		{
			return 22;
		}
		
		override public function set width(value:Number):void
		{
			
		}
		override public function set height(value:Number):void
		{
			
		}
		
		protected function createCheckOnSkin():DisplayObject
		{
			var con:Sprite = new Sprite();
			var solidFillData:SolidFillData = new SolidFillData(0x46489e, 1);
			var borderFillStyle:ShapeFillStyle = ShapeFillStyle.createBySolidFillData(solidFillData);
			var gradientFillData:GradientFillData = new GradientFillData(GradientType.LINEAR, [0xdef9ff,0x97c8f7,0x74b5f7,0xc5f4fe],[1.00,1.00,1.00,1.00],[21,126,127,234],90);
			var shapeFillStyle:ShapeFillStyle = ShapeFillStyle.createByGradientFillData(gradientFillData);
			var dropShadowFilter:DropShadowFilter = new DropShadowFilter(1, 95, 0, 0.14901960784313725, 0, 1);
			var roundFrameRect:RoundFrameRect = new RoundFrameRect(14, 14, 3, 3, 3, 3, 1, null, borderFillStyle, shapeFillStyle);
			roundFrameRect.filters = [dropShadowFilter];
			var icon:DisplayObject = createIcon();
			icon.x = icon.y = 7;
			roundFrameRect.x += _shapeOffsetX;
			roundFrameRect.y += _shapeOffsetY;
			icon.x += _shapeOffsetX;
			icon.y += _shapeOffsetY;
			con.addChild(roundFrameRect);
			con.addChild(icon);
			return con;
		}
		
		protected function createIcon():DisplayObject
		{
			var data:Vector.<Number> = new Vector.<Number>();
			data.push(-3.925,-2.933,-3.758,-3.233,-3.354,-3.463,-3.011,-3.454,-2.667,-3.445,-2.383,-3.198,-2.242,-3.074,-2.100,-2.950,-2.100,-2.950,-2.100,-2.950,-2.100,-2.950,-2.100,-2.950,-1.692,-2.424,-1.283,-1.897,-0.467,-0.843,-0.058,-0.317,0.350,0.210,0.350,0.210,0.350,0.210,0.350,0.210,0.350,0.210,1.388,-1.353,2.427,-2.917,4.503,-6.043,5.542,-7.607,6.580,-9.170,6.580,-9.170,6.580,-9.170,6.580,-9.170,6.580,-9.170,6.732,-9.298,6.883,-9.427,7.187,-9.683,7.537,-9.660,7.887,-9.637,8.283,-9.333,8.423,-9.007,8.563,-8.680,8.447,-8.330,8.388,-8.155,8.330,-7.980,8.330,-7.980,8.330,-7.980,8.330,-7.980,8.330,-7.980,7.187,-6.183,6.043,-4.387,3.757,-0.793,2.613,1.003,1.470,2.800,1.470,2.800,1.470,2.800,1.470,2.800,1.470,2.800,1.353,2.870,1.237,2.940,1.003,3.080,0.770,3.080,0.537,3.080,0.303,2.940,0.187,2.870,0.070,2.800,0.070,2.800,0.070,2.800,0.070,2.800,0.070,2.800,-0.601,2.018,-1.272,1.236,-2.613,-0.329,-3.284,-1.111,-3.955,-1.894,-3.955,-1.894,-3.955,-1.894,-3.955,-1.894,-3.955,-1.894,-3.989,-2.078,-4.024,-2.263,-4.093,-2.633,-3.925,-2.933);
			var command:Vector.<int> = new Vector.<int>();
			command.push(1,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6);
			var s:Shape = new Shape();
			s.graphics.beginFill(0x0);
			s.graphics.drawPath(command, data);
			return s;
		}
		
		protected function createCheckOffSkin():DisplayObject
		{
			var solidFillData:SolidFillData = new SolidFillData(0x787878, 1);
			var borderFillStyle:ShapeFillStyle = ShapeFillStyle.createBySolidFillData(solidFillData);
			var gradientFillData:GradientFillData = new GradientFillData(GradientType.LINEAR, [0xffffff,0xf2f2f2,0xe7e7e7,0xefefef],[1.00,1.00,1.00,1.00],[0,126,127,255],90);
			var shapeFillStyle:ShapeFillStyle = ShapeFillStyle.createByGradientFillData(gradientFillData);
			var dropShadowFilter:DropShadowFilter = new DropShadowFilter(1, 95, 0, 0.14901960784313725, 0, 1);
			var roundFrameRect:RoundFrameRect = new RoundFrameRect(14, 14, 3, 3, 3, 3, 1, null, borderFillStyle, shapeFillStyle);
			roundFrameRect.filters = [dropShadowFilter];
			roundFrameRect.x += _shapeOffsetX;
			roundFrameRect.y += _shapeOffsetY;
			return roundFrameRect;
		}
	}
}