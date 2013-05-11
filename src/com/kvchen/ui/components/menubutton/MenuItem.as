package com.kvchen.ui.components.menubutton
{
	import com.kvchen.ui.components.label.Label;
	import com.kvchen.ui.fillstyle.ShapeFillStyle;
	import com.kvchen.ui.fillstyle.data.GradientFillData;
	import com.kvchen.ui.fillstyle.data.SolidFillData;
	import com.kvchen.ui.shape.RoundFrameRect;
	
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextFormatAlign;
	
	public class MenuItem extends Sprite
	{
		protected var _overSkin:DisplayObject;
		protected var _outSkin:DisplayObject;
		protected var _overLabel:Label;
		protected var _outLabel:Label;
		
		protected var _labelText:String = "";
		protected var _width:Number = 0;
		protected var _over:Boolean = false;
		
		public var index:int = 0;
		public var delegate:MenuItemDelegate;
		
		public function MenuItem(label:String = "", width:Number = 100)
		{
			_labelText = label;
			_width = width;
			_outSkin = createOutSkin(_width);
			_overSkin = createOverSkin(_width);
			_outLabel = new Label(label, _width, TextFormatAlign.LEFT, 0x0);
			_overLabel = new Label(label, _width, TextFormatAlign.LEFT, 0xffffff);
			
			_overLabel.x = _outLabel.x = 10;
			_overLabel.y = _outLabel.y = -1;
			
			_over = false;
			updateState(_over);
			initEvent();
		}
				
		public function get label():String
		{
			return _labelText;
		}
		
		protected function initEvent():void{
			addEventListener(MouseEvent.ROLL_OVER, onMouseOver);
		}
		
		protected function onMouseOver(event:MouseEvent):void
		{
			_over = true;
			updateState(true);
			addEventListener(MouseEvent.ROLL_OUT, onMouseOut);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		protected function onMouseOut(event:MouseEvent):void
		{
			_over = false;
			updateState(false);
			removeEventListener(MouseEvent.ROLL_OUT, onMouseOut);
		}
		
		protected function onMouseUp(e:MouseEvent):void
		{
			if(delegate != null){
				delegate.menuItemDidSelected(this);
			} 
			removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		protected function updateState(over:Boolean):void{
			this.removeChildren();
			if(over){
				this.addChild(_overSkin);
				this.addChild(_overLabel);
			}else{
				this.addChild(_outSkin);
				this.addChild(_outLabel);
			}
		}
		
		protected function createOutSkin(width:Number):DisplayObject{
			var s:Sprite = new Sprite();
			s.graphics.beginFill(0xffffff, 0.01);
			s.graphics.drawRect(0, 0, width, 18);
			s.graphics.endFill();
			return s;
		}
		
		protected function createOverSkin(width:Number):DisplayObject{
			var solidFillData:SolidFillData = new SolidFillData(0x4767eb, 1);
			var borderFillStyle:ShapeFillStyle = ShapeFillStyle.createBySolidFillData(solidFillData);
			var gradientFillData:GradientFillData = new GradientFillData(GradientType.LINEAR, [0x5170f6,0x3055f5,0x1a44f4],[1.00,1.00,1.00],[0,123,255],90);
			var shapeFillStyle:ShapeFillStyle = ShapeFillStyle.createByGradientFillData(gradientFillData);
			var roundFrameRect:RoundFrameRect = new RoundFrameRect(width, 18, 0, 0, 0, 0, 1, null, borderFillStyle, shapeFillStyle);
			return roundFrameRect;
		}
	}
}