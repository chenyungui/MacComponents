package com.kvchen.ui.components.adjustfield
{
	import com.kvchen.ui.fillstyle.ShapeFillStyle;
	import com.kvchen.ui.fillstyle.data.GradientFillData;
	import com.kvchen.ui.fillstyle.data.SolidFillData;
	import com.kvchen.ui.shape.RoundFrameRect;
	
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.text.TextField;
	
	[Event(name="change", type="flash.events.Event")]
	
	public class AdjustField extends Sprite
	{
		private var _inputBg:DisplayObject;
		private var _input:DraggableTextInput;
		private var _leftBtn:SimpleButton;
		private var _rightBtn:SimpleButton;
		
		private var _minX:Number = 0;
		private var _maxX:Number = 0;
		private var _valueX:Number = 0;
		
		private var _min:Number = 0;
		private var _max:Number = 0;
		private var _value:Number = 0;
		private var _dragStep:Number = 0;
		private var _adjustStep:Number = 0;
		private var _infinityMin:Boolean = true;
		private var _infinityMax:Boolean = true;
		
		private var _bindObject:Object = null;
		private var _bindAttribute:String = "";
		
		private var _setFunc:Function = null;
		
		//infinityMin or infinityMax only happen when user type a value smaller than min or bigger than max(once user do that the min and max will be reset, the type value will be in the center of the slider)
		public function AdjustField(value:Number = 50, minValue:Number = 0, maxValue:Number = 100, dragStep:Number = 1, adjustStep:Number = 0.25, infinityMin:Boolean = true, infinityMax:Boolean = true)
		{
			_value = value;
			_min = minValue;
			_max = maxValue;
			_dragStep = dragStep;
			_adjustStep = adjustStep;
			_infinityMin = infinityMin;
			_infinityMax = infinityMax;
			
			_inputBg = createInputBgSkin(70);
			_inputBg.x = 0;
			_inputBg.y = 2;
			
			_input = new DraggableTextInput();
			_input.x = 10;
			_input.y = 1;
			_input.minimum = _min;
			_input.maximum = _max;
			_input.value = _value;
			_input.snapInterval = _dragStep;
			_input.addEventListener(Event.CHANGE, onTextInputValueChange);
			
			_leftBtn = new AdjustButton(true);
			_leftBtn.x = 8;
			_leftBtn.y = 11.5;
			_leftBtn.addEventListener(MouseEvent.CLICK, onClickLeftBtn);
			
			_rightBtn = new AdjustButton(false);
			_rightBtn.x = 62;
			_rightBtn.y = 11.5;
			_rightBtn.addEventListener(MouseEvent.CLICK, onClickRightBtn);
			
			addChild(_inputBg);
			addChild(_input);
			addChild(_leftBtn);
			addChild(_rightBtn);
		}
		
		public function bindAttribute(target:Object, attribute:String):void
		{
			_bindObject = target;
			_bindAttribute = attribute;
			
			var v:Number = _bindObject[_bindAttribute];
			_input.value = v;
		}
		
		public function bindFunction(attribute:String, setFunc:Function):void
		{
			_bindAttribute = attribute;
			_setFunc = setFunc;
		}
		
		override public function get width():Number
		{
			return 70;
		}
		override public function get height():Number
		{
			return 22;
		}
		public function get value():Number
		{
			return _input.value;
		}
		public function set value(v:Number):void
		{
			_input.value = v;
		}
		
		private function onClickLeftBtn(e:MouseEvent):void
		{
			var value:Number = _input.value - _adjustStep;
			_input.value = value;
			handleValueChange();
		}
		
		private function onClickRightBtn(e:MouseEvent):void
		{
			var value:Number = _input.value + _adjustStep;
			_input.value = value;
			handleValueChange();
		}
		
		private function onTextInputValueChange(e:Event):void
		{
			//********* add for check infinity properties ***********
			handleValueChange();
		}
		
		private function handleValueChange():void
		{
			if((_bindObject != null) && (_bindAttribute != "")){
				try{
					_bindObject[_bindAttribute] = value;
				}catch(error:Error){
					trace(error);
				}
			}else if(_bindAttribute != "" && _setFunc != null){
				_setFunc.apply(null, [_bindAttribute, value]);
			}
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		protected function createInputBgSkin(width:Number):DisplayObject{
			var gradientFillData:GradientFillData = new GradientFillData(GradientType.LINEAR, [0xbbbbbb,0xcdcdcd],[1.00,1.00],[0,255],90);
			var borderFillStyle:ShapeFillStyle = ShapeFillStyle.createByGradientFillData(gradientFillData);
			var solidFillData:SolidFillData = new SolidFillData(0xffffff, 1);
			var shapeFillStyle:ShapeFillStyle = ShapeFillStyle.createBySolidFillData(solidFillData);
			var dropShadowFilter:DropShadowFilter = new DropShadowFilter(3, 90, 0, 0.2, 2, 2, 1, 5, true);
			var roundFrameRect:RoundFrameRect = new RoundFrameRect(width, 18, 9, 9, 9, 9, 1, null, borderFillStyle, shapeFillStyle);
			roundFrameRect.filters = [dropShadowFilter];
			return roundFrameRect;
		}
	}
}

import flash.display.DisplayObject;
import flash.display.Graphics;
import flash.display.SimpleButton;

internal class AdjustButton extends SimpleButton
{
	private var leftSide:Boolean = false;
	private var circleOffsetX:Number = 0;
	
	public function AdjustButton(left:Boolean = true)
	{
		leftSide = left;
		if(leftSide){
			circleOffsetX = 1;
		}else{
			circleOffsetX = -1;
		}
		var up:DisplayObject = getUp();
		var over:DisplayObject = getOver();
		var down:DisplayObject = getDown();
		var hit:DisplayObject = getHitTest();
		
		super(up, over, down, hit);
	}
	private function getUp():DisplayObject
	{
		var arrow:Shape = new Shape();
		arrow.graphics.beginFill(0x9b9b9b);
		drawArrow(arrow.graphics, 6);
		return arrow;
	}
	private function getOver():DisplayObject
	{
		var arrow:Shape = new Shape();
		arrow.graphics.beginFill(0xcccccc);
		arrow.graphics.drawCircle(circleOffsetX, 0, 6);
		arrow.graphics.beginFill(0x9b9b9b);
		drawArrow(arrow.graphics, 6);
		return arrow;
	}
	private function getDown():DisplayObject
	{
		var arrow:Shape = new Shape();
		arrow.graphics.beginFill(0xcccccc);
		arrow.graphics.drawCircle(circleOffsetX, 0, 6);
		arrow.graphics.beginFill(0x9b9b9b);
		drawArrow(arrow.graphics, 6);
		arrow.y = 1;
		return arrow;
	}
	private function getHitTest():DisplayObject
	{
		var arrow:Shape = new Shape();
		arrow.graphics.beginFill(0x9b9b9b);
		arrow.graphics.drawCircle(circleOffsetX, 0, 6);
		return arrow;
	}
	
	private function drawArrow(g:Graphics, h:Number):void
	{
		var h2:Number = h/2;
		var w:Number = Math.tan(60*Math.PI/180) * h2;
		var w2:Number = w/2;
		if(leftSide){
			g.moveTo(w - w2, -h2);
			g.lineTo(w - w2, h-h2);
			g.lineTo(-w2, h2-h2);
		}else{
			g.moveTo(-w2, -h2);
			g.lineTo(w - w2, h2-h2);
			g.lineTo(-w2, h-h2);
		}
	}
}

import flash.text.TextFieldAutoSize;
import flash.text.TextFormatAlign;

internal class Label extends TextField
{
	protected static const TEXTFORMAT_DEFAUT:TextFormat = new TextFormat("Arial", 11.5, 0x000000, null, null, null, null, null, TextFormatAlign.RIGHT);
	
	protected var _width:int = 0;
	
	public function Label(text:String, width:int = 75)
	{
		_width = width;
		
		this.defaultTextFormat = TEXTFORMAT_DEFAUT;
		this.text = text;
		this.width = width;
		this.wordWrap = false;
		this.selectable = false;
		this.autoSize = TextFieldAutoSize.RIGHT;
	}
	
	override public function get width():Number{
		return _width;
	}
}

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.system.Capabilities;
import flash.system.IME;
import flash.text.TextField;
import flash.text.TextFieldType;
import flash.text.TextFormat;
import flash.ui.Keyboard;
import flash.ui.Mouse;

[Event(name="change", type="flash.events.Event")]

internal class DraggableTextInput extends Sprite
{
	protected static const TEXTFORMAT_DEFAUT:TextFormat = new TextFormat("Arial", 11, 0x000000, true, null, false, null, null, TextFormatAlign.CENTER);
	protected static const TEXTFORMAT_SLIDING:TextFormat = new TextFormat("Arial", 11, 0xFFFFFF, true, null, false, null, null, TextFormatAlign.CENTER);
	protected static const TEXTFORMAT_INPUT:TextFormat = new TextFormat("Arial", 11, 0x000000, true, null, false, null, null, TextFormatAlign.CENTER);
	protected static const TEXTFIELD_HEIGHT:Number = 21;
	protected static const TEXTFIELD_WIDTH:Number = 50;
	
	private var _infinityMin:Boolean = false;
	private var _infinityMax:Boolean = false;
	
	public function DraggableTextInput(infinityMin:Boolean = true, infinityMax:Boolean = true)
	{
		_infinityMin = infinityMin;
		_infinityMax = infinityMax;
		initialize();
	}
	
	public function get snapInterval():Number
	{
		return _snapInterval;
	}
	
	public function set snapInterval(value:Number):void
	{
		if (value == 0)
			throw new Error();
		
		_snapInterval = value;
	}
	
	public function get maximum():Number
	{
		return _maximum;
	}
	
	public function set maximum(value:Number):void
	{
		_maximum = value;
		_value = Math.min(_maximum, _value);
	}
	
	public function get minimum():Number
	{
		return _minimum;
	}
	
	public function set minimum(value:Number):void
	{
		_minimum = value;
		_value = Math.max(_minimum, _value);
	}
	
	public function get value():Number
	{
		return Number(_label.text);
	}
	
	public function set value(value:Number):void
	{
		_value = Math.max(_minimum, Math.min(_maximum, value));
		
		_label.text = format(_value);
	}
	
	public var formatRatio:int = -2;
	
	protected var _value:Number;
	protected var _label:TextField;
	protected var _bg:Shape;
	protected var _pointDown:Point;
	protected var _focusShape:Shape;
	protected var _valueOld:Number;
	protected var _minimum:Number = int.MIN_VALUE;
	protected var _maximum:Number = int.MAX_VALUE;
	protected var _snapInterval:Number = 1;
	protected var _isMouseDown:Boolean;
	protected var _isMouseMove:Boolean;
	private var _arrow:Bitmap;
	
	public function finalize():void
	{
		_label.removeEventListener(Event.CHANGE, onLabelChange);
		removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		removeEventListener(MouseEvent.CLICK, onClick);
	}
	
	protected function initialize():void
	{
		_bg = new Shape();
		addChild(_bg);
		
		_focusShape = new Shape();
		_focusShape.graphics.beginFill(0x53b6f9);
		_focusShape.graphics.drawRect(0, 0, 5, 5);
		_focusShape.graphics.endFill();
		_focusShape.graphics.beginFill(0x737373);
		_focusShape.graphics.drawRect(1, 1, 3, 3);
		_focusShape.graphics.endFill();
		_focusShape.graphics.beginFill(0xFFFFFF);
		_focusShape.graphics.drawRect(2, 2, 1, 1);
		_focusShape.graphics.endFill();
		_focusShape.scale9Grid = new Rectangle(2, 2, 1, 1);
		addChild(_focusShape);
		
		_focusShape.width = TEXTFIELD_WIDTH;
		_focusShape.height = TEXTFIELD_HEIGHT;
		_focusShape.visible = false;
		
		_label = new TextField();
		_label.type = TextFieldType.DYNAMIC;
		_label.selectable = false;
		_label.x = 2;
		_label.y = 2;
		_label.width = TEXTFIELD_WIDTH - 4;
		_label.height = TEXTFIELD_HEIGHT - 4;
		_label.restrict = "0-9.\\-";
		_label.addEventListener(Event.CHANGE, onLabelChange);
		addChild(_label);
		
		// use http://wonderfl.net/c/8TK2
		var arr:Array = [
			[0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0],
			[0, 0, 2, 1, 2, 0, 0, 0, 0, 0, 2, 1, 2, 0, 0],
			[0, 2, 1, 1, 2, 2, 2, 0, 2, 2, 2, 1, 1, 2, 0],
			[2, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 2],
			[0, 2, 1, 1, 2, 2, 2, 0, 2, 2, 2, 1, 1, 2, 0],
			[0, 0, 2, 1, 2, 0, 0, 0, 0, 0, 2, 1, 2, 0, 0],
			[0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0]
		];
		var bmd:BitmapData = new BitmapData(15, 7, true, 0x0);
		bmd.lock();
		for (var i:int = 0; i < arr.length; i++)
		{
			for (var j:int = 0; j < arr[i].length; j++)
			{
				bmd.setPixel32(j, i, arr[i][j] == 0 ? 0x0 : arr[i][j] == 1 ? 0xFF000000 : 0xFFFFFFFF);
			}
		}
		bmd.unlock();
		
		_arrow = new Bitmap(bmd);
		
		_label.defaultTextFormat = TEXTFORMAT_DEFAUT;
		
		addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		addEventListener(MouseEvent.CLICK, onClick);
	}
	
	protected function onClick(event:MouseEvent):void
	{
		if (_isMouseDown)
			return;
		
		if (_focusShape.visible == true)
			return;
		
		if (Capabilities.hasIME)
		{
			try
			{
				IME.enabled = false;
			}
			catch (error:Error)
			{
			}
		}
		
		_valueOld = Number(_label.text);
		_label.type = TextFieldType.INPUT;
		_label.selectable = true;
		_label.setSelection(0, _label.length);
		_label.defaultTextFormat = TEXTFORMAT_INPUT;
		_label.text = _label.text;
		
		_focusShape.visible = true;
		
		stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownForCommit);
		stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
	}
	
	protected function onKeyDown(event:KeyboardEvent):void
	{
		switch (event.keyCode)
		{
			case Keyboard.ENTER:
				//********* add for check infinity properties ***********
				var valueNew:Number = Number(_label.text);
				if(_infinityMin){
					if(valueNew < minimum){
						this.minimum = valueNew - (maximum - valueNew);
					}
				}
				if(_infinityMax){
					if(valueNew > maximum){
						this.maximum = valueNew + (valueNew - minimum);
					}
				}
				//********* end ***********
				commitProperties();
				break;
			case Keyboard.ESCAPE:
				_label.text = _valueOld.toString(10);
				commitProperties();
				break;
			case Keyboard.UP:
				updateValue(Number(_label.text) + _snapInterval);
				_label.setSelection(0, _label.length);
				break;
			case Keyboard.DOWN:
				updateValue(Number(_label.text) - _snapInterval);
				_label.setSelection(0, _label.length);
				break;
		}
	}
	
	protected function onMouseDownForCommit(event:MouseEvent):void
	{
		if (event.target == _label)
			return;
		
		commitProperties();
	}
	
	protected function commitProperties():void
	{
		var valueNew:Number = Number(_label.text);
		if (valueNew < _minimum || valueNew > _maximum)
		{
			valueNew = _valueOld;
		}
		
		stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		stage.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDownForCommit);
		
		_label.defaultTextFormat = TEXTFORMAT_DEFAUT;
		_label.selectable = false;
		_label.type = TextFieldType.DYNAMIC;
		_label.text = format(valueNew)
		
		_focusShape.visible = false;
		
		dispatchChangeEvent();
	}
	
	protected function onMouseDown(event:MouseEvent):void
	{
		if (_label.type == TextFieldType.INPUT)
			return;
		
		stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		
		_label.defaultTextFormat = TEXTFORMAT_SLIDING;
		
		_label.text = _label.text;
		_pointDown = new Point(mouseX, mouseY);
		
		_valueOld = Number(_label.text);
		
		_bg.graphics.clear();
		_bg.graphics.beginFill(0x157bbe);
		//_bg.graphics.drawRect(0, 0, _label.textWidth + 8, TEXTFIELD_HEIGHT);
		//_bg.graphics.drawRect((TEXTFIELD_WIDTH - _label.textWidth - 8)/2, 0, _label.textWidth + 8, TEXTFIELD_HEIGHT);
		_bg.graphics.drawRect((TEXTFIELD_WIDTH - _label.textWidth - 8)/2, (TEXTFIELD_HEIGHT - _label.textHeight - 4)/2, _label.textWidth + 8, _label.textHeight + 4);
		
		Mouse.hide();
		stage.addChild(_arrow);
		_arrow.x = stage.mouseX　- int( _arrow.width / 2 );
		_arrow.y = stage.mouseY　- int( _arrow.height / 2);
		
		_isMouseDown = false;
		_isMouseMove = false;
	}
	
	protected function onMouseMove(event:MouseEvent):void
	{
		_isMouseMove = true;
		
		var vx:Number = +1 * (mouseX - _pointDown.x);
		var vy:Number = -1 * (mouseY - _pointDown.y);
		
		var d:Number = (vx + vy) * _snapInterval;
		
		updateValue(_valueOld + d);
		
		_bg.graphics.clear();
		_bg.graphics.beginFill(0x157bbe);
		//_bg.graphics.drawRect(0, 0, _label.textWidth + 8, TEXTFIELD_HEIGHT);
		//_bg.graphics.drawRect((TEXTFIELD_WIDTH - _label.textWidth - 8)/2, 0, _label.textWidth + 8, TEXTFIELD_HEIGHT);
		_bg.graphics.drawRect((TEXTFIELD_WIDTH - _label.textWidth - 8)/2, (TEXTFIELD_HEIGHT - _label.textHeight - 4)/2, _label.textWidth + 8, _label.textHeight + 4);
		
		dispatchChangeEvent();
		
		_arrow.x = stage.mouseX　- int( _arrow.width / 2 );
		_arrow.y = stage.mouseY　- int( _arrow.height / 2);
	}
	
	protected function updateValue(valueNew:Number):void
	{
		valueNew = Math.max(_minimum, Math.min(_maximum, valueNew));
		_label.text = format(valueNew);
	}
	
	protected function onMouseUp(event:MouseEvent):void
	{
		_bg.graphics.clear();
		stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		
		_label.defaultTextFormat = TEXTFORMAT_DEFAUT;
		_label.text = _label.text;
		
		if (event.target == _label && _isMouseMove)
			_isMouseDown = true;
		
		Mouse.show();
		stage.removeChild(_arrow);
	}
	
	protected function format(val:Number):String
	{
		var nn:Number = Math.pow(10, formatRatio);
		var valueNew:Number = Math.round(val / nn) * nn;
		
		var str:String = valueNew.toString(10);
		var arr:Array = str.split(".");
		
		var decimal:String = arr[1] || "00";
		var ratio:Number = Math.abs(formatRatio);
		if (decimal.length < ratio)
		{
			while (decimal.length < ratio)
			{
				decimal = decimal + "0";
			}
		}
		else
		{
			decimal = decimal.substr(0, ratio);
		}
		if (ratio == 0)
			decimal = "0";
		return arr[0] + "." + decimal;
	}
	
	protected function dispatchChangeEvent():void
	{
		dispatchEvent(new Event(Event.CHANGE));
	}
	
	private function onLabelChange(event:Event):void
	{
		event.stopPropagation();
	}
}





