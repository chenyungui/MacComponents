package com.kvchen.ui.components.radiobutton
{
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
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	
	public class RadioButton extends Sprite
	{
		protected static var buttons:Array = null;
		
		private var _shapeOffsetX:Number = 11;
		private var _shapeOffsetY:Number = 11;
		
		protected var _selected:Boolean = false;
		protected var _groupName:String = "defaultRadioGroup";
		
		protected var _onSkin:DisplayObject;
		protected var _offSkin:DisplayObject;
		
		public function RadioButton(selected:Boolean = false, clickHandler:Function = null)
		{
			RadioButton.addButton(this);
			
			_selected = selected;
			_onSkin = createOnSkin();
			_offSkin = createOffSkin();
			buttonMode = true;
			useHandCursor = true;
			updateState(_selected);
			initEvent();
			if(clickHandler != null){
				addEventListener(MouseEvent.CLICK, clickHandler);
			}
		}
		
		protected static function addButton(rb:RadioButton):void
		{
			if(buttons == null)
			{
				buttons = new Array();
			}
			buttons.push(rb);
		}
		
		protected static function refreshState(rb:RadioButton):void
		{
			for(var i:uint = 0; i < buttons.length; i++)
			{
				if(buttons[i] != rb && buttons[i].groupName == rb.groupName)
				{
					buttons[i].selected = false;
				}
			}
		}
		
		protected function initEvent():void{
			addEventListener(MouseEvent.CLICK, onClick);
		}
		
		protected function onClick(e:MouseEvent):void{
			
			this.selected = true;
		}
		
		protected function updateState(selected:Boolean):void{
			
			this.removeChildren();
			switch(selected){
				case true:
					this.addChild(_onSkin);
					break;
				case false:
					this.addChild(_offSkin);
					break;
			}
		}
		
		public function set selected(s:Boolean):void
		{
			if(s != _selected){
				_selected = s;
				updateState(_selected);
				if(_selected)
				{
					RadioButton.refreshState(this);
				}
			}
		}
		
		public function get selected():Boolean
		{
			return _selected;
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
		
		public function set groupName(name:String):void{
			_groupName = name;
		}
		
		public function get groupName():String{
			return _groupName;
		}
		
		protected function createOnSkin():DisplayObject
		{
			var con:Sprite = new Sprite();
			
			var solidFillData:SolidFillData = new SolidFillData(0x4f51a3, 0.8);
			var borderFillStyle:ShapeFillStyle = ShapeFillStyle.createBySolidFillData(solidFillData);
			var gradientFillData:GradientFillData = new GradientFillData(GradientType.LINEAR, [0xd1eaf7,0x97c8f7,0x75b6f7,0xbbe6f2],[1.00,1.00,1.00,1.00],[38,122,123,255],90);
			var shapeFillStyle:ShapeFillStyle = ShapeFillStyle.createByGradientFillData(gradientFillData);
			var dropShadowFilter:DropShadowFilter = new DropShadowFilter(1, 90, 0, 0.2, 0, 1);
			var ringCircle:RingCircle = new RingCircle(8, 1, null, borderFillStyle, shapeFillStyle);
			ringCircle.filters = [dropShadowFilter];
			ringCircle.x = _shapeOffsetX;
			ringCircle.y = _shapeOffsetY;
			var dotFillData:SolidFillData = new SolidFillData(0x0, 1);
			var dot:Circle = new Circle(2, null, ShapeFillStyle.createBySolidFillData(dotFillData));
			dot.x = _shapeOffsetX;
			dot.y = _shapeOffsetY;
			con.addChild(ringCircle);
			con.addChild(dot);
			return con;
		}
		
		protected function createOffSkin():DisplayObject
		{
			var solidFillData:SolidFillData = new SolidFillData(0x7c7c7c, 1);
			var borderFillStyle:ShapeFillStyle = ShapeFillStyle.createBySolidFillData(solidFillData);
			var gradientFillData:GradientFillData = new GradientFillData(GradientType.LINEAR, [0xf4f4f4,0xf2f2f2,0xe7e7e7,0xe4e4e4],[1.00,1.00,1.00,1.00],[0,122,123,255],90);
			var shapeFillStyle:ShapeFillStyle = ShapeFillStyle.createByGradientFillData(gradientFillData);
			var dropShadowFilter:DropShadowFilter = new DropShadowFilter(1, 90, 0, 0.2, 0, 1);
			var ringCircle:RingCircle = new RingCircle(8, 1, null, borderFillStyle, shapeFillStyle);
			ringCircle.filters = [dropShadowFilter];
			ringCircle.x = _shapeOffsetX;
			ringCircle.y = _shapeOffsetY;
			return ringCircle;
		}
	}
}