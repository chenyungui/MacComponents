package com.kvchen.ui.components.inputfield
{
	import com.kvchen.ui.fillstyle.ShapeFillStyle;
	import com.kvchen.ui.fillstyle.data.GradientFillData;
	import com.kvchen.ui.fillstyle.data.SolidFillData;
	import com.kvchen.ui.shape.RoundFrameRect;
	
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class InputField extends Sprite
	{
		public static const COLOR_RESTRICT:String = "[0-9]+[A-F]+[a-f]";
		
		protected var _borderSkin:DisplayObject;
		protected var _tf:TextField;
		protected var _width:Number = 0;
		
		protected var _changeHandler:Function;
		
		public function InputField(text:String = "", width:Number = 80, changeHandler:Function = null)
		{
			_width = width;
			_changeHandler = changeHandler;
			_borderSkin = createBorderSkin(_width);
			_tf = createTextField(_width);
			_tf.text = text;
			_tf.x = 2;
			_tf.y = 2;
			addChild(_borderSkin);
			addChild(_tf);
			initEvent();
		}
		
		protected function initEvent():void{
			_tf.addEventListener(Event.CHANGE, onTextChange);
		}
		
		protected function onTextChange(e:Event):void{
			if(_changeHandler != null){
				_changeHandler();
			}
		}
		
		public function selectAllText():void{
			_tf.setSelection(0, _tf.length);
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
		
		public function set text(t:String):void
		{
			_tf.text = t;
		}
		public function get text():String
		{
			return _tf.text;
		}
		
		public function get textField():TextField
		{
			return _tf;
		}

		public function set restrict(str:String):void
		{
			_tf.restrict = str;
		}
		public function get restrict():String
		{
			return _tf.restrict;
		}
		
		public function set maxChars(max:int):void
		{
			_tf.maxChars = max;
		}
		public function get maxChars():int
		{
			return _tf.maxChars;
		}
		
		public function set password(b:Boolean):void
		{
			_tf.displayAsPassword = b;
		}
		public function get password():Boolean
		{
			return _tf.displayAsPassword;
		}

		protected function createTextField(width:Number):TextField
		{
			var textFormat:TextFormat = new TextFormat("Arial", 11.5, 0x000000, true, null, false, null, null, TextFormatAlign.CENTER);
			//var textFormat:TextFormat = new TextFormat("Arial", 11.5, 0x0, null, null, null, null, null, TextFormatAlign.LEFT);
			var tf:TextField = new TextField();
			tf = new TextField();
			tf.width = width;
			tf.height = 22;
			tf.defaultTextFormat = textFormat;
			tf.selectable = true;
			tf.type = TextFieldType.INPUT;
			return tf;
		}
		
		protected function createBorderSkin(width:Number):DisplayObject
		{
			var gradientFillData:GradientFillData = new GradientFillData(GradientType.LINEAR, [0x898989,0xacacac],[1.00,1.00],[0,135],90);
			var borderFillStyle:ShapeFillStyle = ShapeFillStyle.createByGradientFillData(gradientFillData);
			var solidFillData:SolidFillData = new SolidFillData(0xffffff, 1);
			var shapeFillStyle:ShapeFillStyle = ShapeFillStyle.createBySolidFillData(solidFillData);
			var dropShadowFilter:DropShadowFilter = new DropShadowFilter(2, 90, 0, 0.2, 0, 2, 1, 1, true);
			var roundFrameRect:RoundFrameRect = new RoundFrameRect(width, 22, 0, 0, 0, 0, 1, null, borderFillStyle, shapeFillStyle);
			roundFrameRect.filters = [dropShadowFilter];
			return roundFrameRect;
		}
	}
}