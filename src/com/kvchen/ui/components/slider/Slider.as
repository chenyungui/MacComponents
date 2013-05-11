package com.kvchen.ui.components.slider
{
	import com.kvchen.ui.fillstyle.ShapeFillStyle;
	import com.kvchen.ui.fillstyle.data.GradientFillData;
	import com.kvchen.ui.fillstyle.data.SolidFillData;
	import com.kvchen.ui.shape.RingCircle;
	import com.kvchen.ui.shape.RoundFrameRect;
	
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	
	public class Slider extends Sprite
	{
		protected var _minX:Number = 0;
		protected var _maxX:Number = 0;
		protected var _offsetX:Number = 0;
		
		protected var _width:Number;
		
		protected var _handle:DisplayObject;
		protected var _track:DisplayObject;
		
		protected var _min:Number = 0;
		protected var _max:Number = 0;
		protected var _value:Number = 0;
		protected var _snapInterval:Number = 0;
		
		protected var _isDragging:Boolean = false;

		public function Slider(value:Number = 0, min:Number = 0, max:Number = 100, snapInterval:Number = 0.01, width:Number = 100)
		{
			this._value = value;
			this._min = min;
			this._max = max;
			this._snapInterval = snapInterval;
			this._width = width;
			
			_track = createTrackSkin(_width);
			_handle = createHandleSkin();
			
			_minX = 0;
			_maxX = _width;
			_handle.x = int(getRelValue(_min, _value, _max, _minX, _maxX));
			
			addChild(_track);
			addChild(_handle);
			
			this.addEventListener(Event.ADDED_TO_STAGE, initEvent);
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
		
		public function get minValue():Number
		{
			return _min;
		}
		
		public function set minValue(value:Number):void
		{
			this._min = value;
			this.value = _value;
		}
		
		public function get maxValue():Number
		{
			return _max;
		}
		
		public function set maxValue(value:Number):void
		{
			this._max = value;
			this.value = _value;
		}
		
		public function set value(val:Number):void
		{
			if(_isDragging)return;
			_value = val < _min ? _min : val;
			_value = val > _max ? _max : val;
			_handle.x = int(getRelValue(_min, val, _max, _minX, _maxX));
		}
		
		public function get value():Number
		{
			return _value;
		}
		
		private function getNearestValue(value:Number, snapInterval:Number):Number
		{
			var leave:Number = value % snapInterval;
			var result:Number = 0;
			if(leave > (snapInterval * 0.5)){
				result = value + snapInterval - leave;
			}else if(leave < (snapInterval * 0.5)){
				result = value - leave;
			}else{
				result =  value;
			}
			return Number(result.toFixed(2));
		}
		
		private function initEvent(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, initEvent);
			_handle.addEventListener(MouseEvent.MOUSE_DOWN, onPressHandle);
		}
		
		private function onPressHandle(e:MouseEvent):void
		{
			_isDragging = true;
			
			_offsetX = stage.mouseX - e.currentTarget.x;
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onDragHandle);
			stage.addEventListener(MouseEvent.MOUSE_UP, onReleaseHandle);
		}
		
		private function onDragHandle(e:MouseEvent):void
		{
			var xpos:Number = stage.mouseX - _offsetX;
			xpos = xpos < _minX ? _minX : xpos;
			xpos = xpos > _maxX ? _maxX : xpos;
			_handle.x = xpos;
			
			_value = getRelValue(_minX, xpos, _maxX, _min, _max);
			_value = getNearestValue(_value, _snapInterval);
			dispatchEvent(new Event(Event.CHANGE));
			e.updateAfterEvent();
		}
		
		private function onReleaseHandle(e:MouseEvent):void
		{
			_isDragging = false;
			
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onDragHandle);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onReleaseHandle);
		}
		
		public static function getRelValue(min1:Number, val1:Number, max1:Number, min2:Number, max2:Number):Number
		{
			return min2 + (max2 - min2) * (val1 - min1)/(max1 - min1);
		}
		
		public function destroy():void
		{
			_handle.removeEventListener(MouseEvent.MOUSE_DOWN, onPressHandle);
			if(stage){
				stage.removeEventListener(MouseEvent.MOUSE_MOVE, onDragHandle);
				stage.removeEventListener(MouseEvent.MOUSE_UP, onReleaseHandle);
			}
			
			_handle = null;
			_track = null;
		}

		protected function createTrackSkin(width:Number):DisplayObject{
			var con:Sprite = new Sprite();
			var gradientFillData0:GradientFillData = new GradientFillData(GradientType.LINEAR, [0x616161,0x9e9e9e],[1.00,1.00],[0,255],90);
			var borderFillStyle:ShapeFillStyle = ShapeFillStyle.createByGradientFillData(gradientFillData0);
			var gradientFillData:GradientFillData = new GradientFillData(GradientType.LINEAR, [0x9a9a9a,0xc2c2c2],[1.00,1.00],[0,255],90);
			var shapeFillStyle:ShapeFillStyle = ShapeFillStyle.createByGradientFillData(gradientFillData);
			var roundFrameRect:RoundFrameRect = new RoundFrameRect(width, 5, 2, 2, 2, 2, 1, null, borderFillStyle, shapeFillStyle);
			roundFrameRect.y = 9;
			con.addChild(roundFrameRect);
			return con;
		}
		
		protected function createHandleSkin():DisplayObject{
			var con:Sprite = new Sprite();
			var solidFillData:SolidFillData = new SolidFillData(0x434343, 0.6536585365853659);
			var borderFillStyle:ShapeFillStyle = ShapeFillStyle.createBySolidFillData(solidFillData);
			var gradientFillData:GradientFillData = new GradientFillData(GradientType.LINEAR, [0xe6e6e6,0xf1f1f1,0xe7e7e7,0xebebeb],[1.00,1.00,1.00,1.00],[0,129,129,255],90);
			var shapeFillStyle:ShapeFillStyle = ShapeFillStyle.createByGradientFillData(gradientFillData);
			var dropShadowFilter:DropShadowFilter = new DropShadowFilter(1, 90, 0, 0.3, 0, 1, 1, 2);
			var ringCircle:RingCircle = new RingCircle(8, 1, null, borderFillStyle, shapeFillStyle);
			ringCircle.filters = [dropShadowFilter];
			ringCircle.y = 11;
			con.addChild(ringCircle);
			return con;
		}
	}
}
