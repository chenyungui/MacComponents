package com.kvchen.ui.components.segmentedcontrol
{
	import com.kvchen.ui.components.label.Label;
	import com.kvchen.ui.fillstyle.ShapeFillStyle;
	import com.kvchen.ui.fillstyle.data.GradientFillData;
	import com.kvchen.ui.fillstyle.data.SolidFillData;
	import com.kvchen.ui.shape.Circle;
	import com.kvchen.ui.shape.RingCircle;
	import com.kvchen.ui.shape.RoundFrameRect;
	
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.text.TextFormatAlign;
	
	public class SegmentedButton extends Sprite
	{
		public static const SIDE_LEFT:int = 0;
		public static const SIDE_MIDDLE:int = 1;
		public static const SIDE_RIGHT:int = 2;
		
		protected var _selected:Boolean = false;
		protected var _selectedSkin:DisplayObject = null;
		protected var _deselectedSkin:DisplayObject = null;
		protected var _selectedLabel:Label = null;
		protected var _deselectedLabel:Label = null;
		
		protected var _width:Number = 0;
		protected var _label:String = "";
		
		public function SegmentedButton(label:String = "", width:Number=60, side:int = 1, selected:Boolean = false)
		{
			_label = label;
			_width = width;
			_selectedSkin = createDownSkin(_width, side);
			_deselectedSkin = createUpSkin(_width, side);
			_selectedLabel = new Label(label, _width, TextFormatAlign.CENTER, 0xffffff);
			_deselectedLabel = new Label(label, _width, TextFormatAlign.CENTER);
			_selected = selected;
			updateState(_selected);
			buttonMode = true;
			useHandCursor = true;
		}
		
		public function get label():String{
			return _label;
		}
		
		override public function get width():Number
		{
			return _width;
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
		
		public function set selected(s:Boolean):void
		{
			if(s != _selected){
				_selected = s;
				updateState(_selected);
			}
		}
		
		public function get selected():Boolean
		{
			return _selected;
		}

		protected function updateState(selected:Boolean):void{
			
			this.removeChildren();
			switch(selected){
				case true:
					this.addChild(_selectedSkin);
					this.addChild(_selectedLabel);
					break;
				case false:
					this.addChild(_deselectedSkin);
					this.addChild(_deselectedLabel);
					break;
			}
		}
		
		protected function createUpSkin(width:Number, side:int):DisplayObject{
			var tl:Number = 0, tr:Number = 0, bl:Number = 0, br:Number = 0;
			switch(side){
				case SIDE_LEFT:
					tl = bl = 4;
					break;
				case SIDE_MIDDLE:
					break;
				case SIDE_RIGHT:
					tr = br = 4;
					break;
			}
			var solidFillData:SolidFillData = new SolidFillData(0x858585, 1);
			var borderFillStyle:ShapeFillStyle = ShapeFillStyle.createBySolidFillData(solidFillData);
			var gradientFillData:GradientFillData = new GradientFillData(GradientType.LINEAR, [0xffffff,0xf0f0f0,0xe7e7e7,0xefefef],[1.00,1.00,1.00,1.00],[0,128,129,255],90);
			var shapeFillStyle:ShapeFillStyle = ShapeFillStyle.createByGradientFillData(gradientFillData);
			var dropShadowFilter:DropShadowFilter = new DropShadowFilter(1, 90, 0, 0.2, 0, 1);
			var roundFrameRect:RoundFrameRect = new RoundFrameRect(width, 21, tl, tr, bl, br, 1, null, borderFillStyle, shapeFillStyle);
			roundFrameRect.filters = [dropShadowFilter];
			return roundFrameRect;
		}
		
		protected function createDownSkin(width:Number, side:int):DisplayObject{
			var tl:Number = 0, tr:Number = 0, bl:Number = 0, br:Number = 0;
			switch(side){
				case SIDE_LEFT:
					tl = bl = 4;
					break;
				case SIDE_MIDDLE:
					break;
				case SIDE_RIGHT:
					tr = br = 4;
					break;
			}
			var solidFillData0:SolidFillData = new SolidFillData(0x7a7a7a, 1);
			var borderFillStyle:ShapeFillStyle = ShapeFillStyle.createBySolidFillData(solidFillData0);
			var solidFillData:SolidFillData = new SolidFillData(0x808080, 1);
			var shapeFillStyle:ShapeFillStyle = ShapeFillStyle.createBySolidFillData(solidFillData);
			var glowFilter:GlowFilter = new GlowFilter(0, 0.2980392156862745, 3, 3, 2, 5, true);
			var roundFrameRect:RoundFrameRect = new RoundFrameRect(width, 21, tl, tr, bl, br, 1, null, borderFillStyle, shapeFillStyle);
			roundFrameRect.filters = [glowFilter];
			return roundFrameRect;
		}
	}
}