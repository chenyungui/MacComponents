package com.kvchen.ui.components.toolbutton
{
	import com.kvchen.ui.fillstyle.ShapeFillStyle;
	import com.kvchen.ui.fillstyle.data.GradientFillData;
	import com.kvchen.ui.fillstyle.data.SolidFillData;
	import com.kvchen.ui.shape.RoundFrameRect;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class ToolButton extends Sprite
	{
		protected var _toolIcon:BitmapData;
		
		public static const STATE_UP:int = 0;
		public static const STATE_OVER:int = 1;
		public static const STATE_DOWN:int = 2;
		public static const STATE_DISABLE:int = 3;
		
		private var _shapeOffsetX:Number = 1;
		private var _shapeOffsetY:Number = 1;
		
		protected var _iconOffsetX:Number = 0;
		protected var _iconOffsetY:Number = 0;
		
		protected var _upState:DisplayObject;
		protected var _overState:DisplayObject;
		protected var _downState:DisplayObject;
		protected var _disableState:DisplayObject;
		
		protected var _width:Number = 20;
		protected var _height:Number = 20;
		
		protected var _enabled:Boolean = true;
		protected var _addedEvents:Boolean = false;
		protected var _state:int = 0;
		
		protected var _stateCon:Sprite;
		protected var _hitArea:Sprite;
		
		public function ToolButton(toolIcon:BitmapData, clickHandler:Function = null, iconOffsetX:Number = 0, iconOffsetY:Number = 0, width:Number = 22, height:Number = 22)
		{
			_toolIcon = toolIcon;
			_width = width;
			_height = height;
			_iconOffsetX = iconOffsetX;
			_iconOffsetY = iconOffsetY;
			init();
			initEvent();
			if(clickHandler != null){
				addEventListener(MouseEvent.CLICK, clickHandler);
			}
		}
		
		protected function init():void{
			
			buttonMode = true;
			useHandCursor = true;
			
			_state = STATE_UP;
			_upState = createUpSkin(_width, _height);
			_overState = createOverSkin(_width, _height);
			_downState = createDownSkin(_width, _height);
			_disableState = createDisableSkin(_width, _height);
			
			_stateCon = new Sprite();
			_hitArea = createHitArea(_shapeOffsetX, _shapeOffsetY, _width, _height);
			
			this.addChild(_stateCon);
			this.addChild(_hitArea);
			
			updateState(_state);
		}
		
		protected function initEvent():void{
			addEvents();
		}
		
		protected function addEvents():void{
			if(! _addedEvents){
				addEventListener(MouseEvent.MOUSE_DOWN, onMouseGoDown);
				addEventListener(MouseEvent.ROLL_OVER, onMouseOver);
				_addedEvents = true;
			}
		}
		
		protected function removeEvents():void{
			if(_addedEvents){
				removeEventListener(MouseEvent.MOUSE_DOWN, onMouseGoDown);
				removeEventListener(MouseEvent.ROLL_OVER, onMouseOver);
				_addedEvents = false;
			}
		}
		
		protected function onMouseOver(event:MouseEvent):void
		{
			updateState(STATE_OVER);
			addEventListener(MouseEvent.ROLL_OUT, onMouseOut);
		}
		
		protected function onMouseOut(event:MouseEvent):void
		{
			updateState(STATE_UP);
			removeEventListener(MouseEvent.ROLL_OUT, onMouseOut);
		}
		
		protected function onMouseGoDown(event:MouseEvent):void
		{
			updateState(STATE_DOWN);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseGoUp);
		}
		
		protected function onMouseGoUp(event:MouseEvent):void
		{
			updateState(STATE_UP);
			if(stage != null){
				stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseGoUp);
			}
		}
		
		override public function get width():Number
		{
			return _width;
		}
		override public function get height():Number
		{
			return _height;
		}
		
		override public function set width(value:Number):void
		{
			
		}
		override public function set height(value:Number):void
		{
			
		}
		
		public function set enabled(value:Boolean):void{
			_enabled = value;
			if(_enabled){
				buttonMode = true;
				useHandCursor = true;
				
				updateState(STATE_UP);
				addEvents();
			}else{
				buttonMode = false;
				useHandCursor = false;
				
				updateState(STATE_DISABLE);
				removeEvents();
			}
		}
		
		public function get enabled():Boolean{
			return _enabled;
		}
		
		protected function updateState(state:int):void{
			_stateCon.removeChildren();
			switch(state){
				case STATE_UP:
					_stateCon.addChild(_upState);
					break;
				case STATE_OVER:
					_stateCon.addChild(_overState);
					break;
				case STATE_DOWN:
					_stateCon.addChild(_downState);
					break;
				case STATE_DISABLE:
					_stateCon.addChild(_disableState);
					break;
			}
		}
		
		protected function createHitArea(x:Number, y:Number, width:Number, height:Number):Sprite{
			var s:Sprite = new Sprite();
			s.graphics.beginFill(0x0, 0.01);
			s.graphics.drawRect(x, y, width, height);
			s.graphics.endFill();
			return s;
		}
		
		protected function createOverBg(width:Number, height:Number):DisplayObject{
			var solidFillData:SolidFillData = new SolidFillData(0x787878, 1);
			var borderFillStyle:ShapeFillStyle = ShapeFillStyle.createBySolidFillData(solidFillData);
			var gradientFillData:GradientFillData = new GradientFillData(GradientType.LINEAR, [0xffffff,0xf2f2f2,0xe7e7e7,0xefefef],[1.00,1.00,1.00,1.00],[0,126,127,255],90);
			var shapeFillStyle:ShapeFillStyle = ShapeFillStyle.createByGradientFillData(gradientFillData);
			var roundFrameRect:RoundFrameRect = new RoundFrameRect(width, height, 3, 3, 3, 3, 1, null, borderFillStyle, shapeFillStyle);
			return roundFrameRect;
		}
		
		protected function createDownBg(width:Number, height:Number):DisplayObject{
			var solidFillData:SolidFillData = new SolidFillData(0x3c3f9c, 1);
			var borderFillStyle:ShapeFillStyle = ShapeFillStyle.createBySolidFillData(solidFillData);
			var gradientFillData:GradientFillData = new GradientFillData(GradientType.LINEAR, [0xaecceb,0x568de4,0x387de3,0x9cc9eb],[1.00,1.00,1.00,1.00],[0,128,129,255],90);
			var shapeFillStyle:ShapeFillStyle = ShapeFillStyle.createByGradientFillData(gradientFillData);
			var roundFrameRect:RoundFrameRect = new RoundFrameRect(width, height, 4, 4, 4, 4, 1, null, borderFillStyle, shapeFillStyle);
			return roundFrameRect;
		}
		
		protected function createIcon():DisplayObject{
			var icon:DisplayObject = new Bitmap(_toolIcon);
			icon.x = Math.round((_width-_toolIcon.width)/2.0) + _iconOffsetX;
			icon.y = Math.round((_height-_toolIcon.height)/2.0) + _iconOffsetY;
			return icon;
		}
		
		protected function createUpSkin(width:Number, height:Number):DisplayObject
		{
			var container:Sprite = new Sprite();
			var icon:DisplayObject = createIcon();
			container.addChild(icon);
			
			return container;
		}
		
		protected function createOverSkin(width:Number, height:Number):DisplayObject
		{
			var container:Sprite = new Sprite();
			var roundFrameRect:DisplayObject = createOverBg(width, height);
			roundFrameRect.x += _shapeOffsetX;
			roundFrameRect.y += _shapeOffsetY;
			
			var icon:DisplayObject = createIcon();
			
			container.addChild(roundFrameRect);
			container.addChild(icon);
			
			return container;
		}
		
		protected function createDownSkin(width:Number, height:Number):DisplayObject
		{
			var container:Sprite = new Sprite();
			var roundFrameRect:DisplayObject = createDownBg(width, height);
			roundFrameRect.x += _shapeOffsetX;
			roundFrameRect.y += _shapeOffsetY;
			
			var icon:DisplayObject = createIcon();
			
			container.addChild(roundFrameRect);
			container.addChild(icon);
			
			return container;
		}
		
		protected function createDisableSkin(width:Number, height:Number):DisplayObject
		{
			var container:Sprite = new Sprite();
			var icon:DisplayObject = createIcon();
			icon.alpha = 0.5;
			container.addChild(icon);
			
			return container;
		}
	}
}