package com.kvchen.ui.components.popupbutton
{
	import com.kvchen.ui.components.label.Label;
	import com.kvchen.ui.fillstyle.ShapeFillStyle;
	import com.kvchen.ui.fillstyle.data.GradientFillData;
	import com.kvchen.ui.fillstyle.data.SolidFillData;
	import com.kvchen.ui.shape.RoundFrameRect;
	
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextFormatAlign;
	
	public class PopupListItem extends Sprite
	{
		protected var _overSkin:DisplayObject;
		protected var _outSkin:DisplayObject;
		protected var _overCheckIcon:DisplayObject;
		protected var _outCheckIcon:DisplayObject;
		protected var _overLabel:Label;
		protected var _outLabel:Label;
		
		protected var _labelText:String = "";
		protected var _width:Number = 0;
		protected var _selected:Boolean = false;
		protected var _over:Boolean = false;
		
		public var index:int = 0;
		public var delegate:PopupListItemDelegate;
		
		public function PopupListItem(label:String = "", selected:Boolean = false, width:Number = 100)
		{
			_labelText = label;
			_width = width;
			_selected = selected;
			_outSkin = createOutSkin(_width);
			_overSkin = createOverSkin(_width);
			_outLabel = new Label(label, _width, TextFormatAlign.LEFT, 0x0);
			_overLabel = new Label(label, _width, TextFormatAlign.LEFT, 0xffffff);
			
			_overLabel.x = _outLabel.x = 20;
			_overLabel.y = _outLabel.y = -1;
			
			_outCheckIcon = createCheckIcon(0x0);
			_overCheckIcon = createCheckIcon(0xffffff);
			
			_overCheckIcon.x = _outCheckIcon.x = 9;
			_overCheckIcon.y = _outCheckIcon.y = 10;
			
			_over = false;
			updateState(_over);
			initEvent();
		}
		
		public function set selected(value:Boolean):void{
			_selected = value;
			updateState(_over);
		}
		
		public function get selected():Boolean{
			return _selected;
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
				delegate.popupListItemDidSelected(this);
			} 
			removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}

		protected function updateState(over:Boolean):void{
			this.removeChildren();
			if(over){
				this.addChild(_overSkin);
				if(_selected){
					this.addChild(_overCheckIcon);
				}
				this.addChild(_overLabel);
			}else{
				this.addChild(_outSkin);
				if(_selected){
					this.addChild(_outCheckIcon);
				}
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
		
		protected function createCheckIcon(color:uint):DisplayObject
		{
			var data:Vector.<Number> = new Vector.<Number>();
			data.push(-3.062,-1.325,-2.784,-1.503,-2.368,-1.467,-1.892,-1.113,-1.415,-0.759,-0.876,-0.087,-0.607,0.249,-0.337,0.585,-0.337,0.585,-0.337,0.585,-0.337,0.585,-0.337,0.585,0.075,-0.382,0.487,-1.350,1.313,-3.285,2.152,-4.493,2.992,-5.700,3.848,-6.180,4.421,-6.274,4.995,-6.368,5.288,-6.075,5.220,-5.723,5.153,-5.370,4.725,-4.957,4.148,-4.279,3.570,-3.600,2.842,-2.655,2.246,-1.373,1.650,-0.090,1.185,1.530,0.742,2.340,0.300,3.150,-0.120,3.150,-0.535,2.835,-0.949,2.520,-1.359,1.890,-1.873,1.305,-2.386,0.720,-3.005,0.180,-3.243,-0.287,-3.482,-0.753,-3.340,-1.146,-3.062,-1.325);
			var command:Vector.<int> = new Vector.<int>();
			command.push(1,6,6,6,6,6,6,6,6,6,6,6,6,6,6);
			var obj:Shape = new Shape();
			obj.graphics.beginFill(color, 1);
			obj.graphics.drawPath(command, data);
			obj.graphics.endFill();
			return obj;
		}

	}
}