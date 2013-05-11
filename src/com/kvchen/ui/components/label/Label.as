package com.kvchen.ui.components.label
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class Label extends Sprite
	{
		protected var _width:int = 0;
		protected var _tf:TextField = null;

		public function Label(text:String, width:int = 75, textFormatAlign:String = "right", textColor:uint = 0x0)
		{
			_width = width;
			
			var textFormat:TextFormat = new TextFormat("Arial", 11.5, textColor, null, null, null, null, null, textFormatAlign);
			
			_tf = new TextField();
			_tf.defaultTextFormat = textFormat;
			_tf.text = text;
			_tf.width = width;
			_tf.wordWrap = false;
			_tf.selectable = false;
			_tf.mouseEnabled = false;
			switch(textFormatAlign){
				case TextFormatAlign.LEFT:
					_tf.autoSize = TextFieldAutoSize.LEFT;
					break;
				case TextFormatAlign.RIGHT:
					_tf.autoSize = TextFieldAutoSize.RIGHT;
					break;
				case TextFormatAlign.CENTER:
					_tf.autoSize = TextFieldAutoSize.CENTER;
					break;
			}
			_tf.y = 2;
			this.mouseChildren = false;
			this.addChild(_tf);
		}
		
		public function set textWidth(value:Number):void{
			if(_width != value){
				_tf.width = value;
				_width = value;
			}
		}
		
		public function set text(t:String):void
		{
			_tf.text = t;
		}
		public function get text():String
		{
			return _tf.text;
		}
		
		public function set indent(value:Number):void{
			var textFormat:TextFormat = _tf.defaultTextFormat;
			textFormat.indent = value;
			_tf.defaultTextFormat = textFormat;
		}
		
		public function get indent():Number{
			return Number(_tf.defaultTextFormat.indent);
		}
		
		public function set textColor(color:uint):void{
			_tf.textColor = color;
		}
		
		public function get textColor():uint{
			return _tf.textColor;
		}
		
		public function get textField():TextField
		{
			return _tf;
		}

		override public function get width():Number{
			return _width;
		}
		
		override public function get height():Number{
			return 22;
		}
	}

}