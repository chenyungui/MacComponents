package com.kvchen.ui.components.button
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
	import flash.filters.DropShadowFilter;
	import flash.text.TextFormatAlign;
	
	public class Button extends Sprite
	{
		public static const STATE_UP:int = 0;
		public static const STATE_DOWN:int = 1;
		protected var _state:int = 0;
		protected var _upState:DisplayObject;
		protected var _downState:DisplayObject;
		protected var _label:Label;
		protected var _labelText:String = "";
		protected var _isActived:Boolean = false;
		protected var _width:Number;
		
		protected var _stateCon:Sprite;
		protected var _hitArea:Sprite;
		
		public function Button(label:String = "", width:Number=100, actived:Boolean = false, clickHandler:Function = null)
		{
			this._labelText = label;
			this._width = width;
			this._isActived = actived;
			if(clickHandler != null){
				addEventListener(MouseEvent.CLICK, clickHandler);
			}
			init();
			initEvent();
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

		protected function init():void{
			buttonMode = true;
			useHandCursor = true;
			
			_state = STATE_UP;
			if(_isActived){
				_upState = createActiveUpSkin(_width);
			}else{
				_upState = createUpSkin(_width);
			}
			_downState = createDownSkin(_width);
			_label = new Label(_labelText, _width, TextFormatAlign.CENTER);
			
			_stateCon = new Sprite();
			_hitArea = createHitArea(_width);
			
			this.addChild(_stateCon);
			this.addChild(_hitArea);
			
			updateState(_state, true);
		}
		
		protected function updateState(state:int = 0, forceUpdate:Boolean = false):void{
			if(state != _state || forceUpdate){
				_stateCon.removeChildren();
				switch(state){
					case STATE_UP:
						_stateCon.addChild(_upState);
						break;
					case STATE_DOWN:
						_stateCon.addChild(_downState);
						break;
				}
				_stateCon.addChild(_label);
				_state = state;
			}
		}
		
		protected function initEvent():void{
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseGoDown);
		}
		
		protected function createHitArea(width:Number):Sprite{
			var s:Sprite = new Sprite();
			s.graphics.beginFill(0x0, 0.01);
			s.graphics.drawRect(0, 0, _width, 21);
			s.graphics.endFill();
			return s;
		}
		
		protected function createActiveUpSkin(width:Number):DisplayObject{
			var solidFillData:SolidFillData = new SolidFillData(0x56579f, 1);
			var borderFillStyle:ShapeFillStyle = ShapeFillStyle.createBySolidFillData(solidFillData);
			var gradientFillData:GradientFillData = new GradientFillData(GradientType.LINEAR, [0xc8e0f2,0x7fb0ee,0x64a2ef,0xb6e0f2],[1.00,1.00,1.00,1.00],[14,128,129,255],90);
			var shapeFillStyle:ShapeFillStyle = ShapeFillStyle.createByGradientFillData(gradientFillData);
			var dropShadowFilter:DropShadowFilter = new DropShadowFilter(1, 90, 0, 0.2, 0, 1);
			var roundFrameRect:RoundFrameRect = new RoundFrameRect(width, 21, 4, 4, 4, 4, 1, null, borderFillStyle, shapeFillStyle);
			roundFrameRect.filters = [dropShadowFilter];
			return roundFrameRect;
		}
		
		protected function createUpSkin(width:Number):DisplayObject{
			var solidFillData:SolidFillData = new SolidFillData(0x858585, 1);
			var borderFillStyle:ShapeFillStyle = ShapeFillStyle.createBySolidFillData(solidFillData);
			var gradientFillData:GradientFillData = new GradientFillData(GradientType.LINEAR, [0xffffff,0xf0f0f0,0xe7e7e7,0xefefef],[1.00,1.00,1.00,1.00],[0,128,129,255],90);
			var shapeFillStyle:ShapeFillStyle = ShapeFillStyle.createByGradientFillData(gradientFillData);
			var dropShadowFilter:DropShadowFilter = new DropShadowFilter(1, 90, 0, 0.2, 0, 1);
			var roundFrameRect:RoundFrameRect = new RoundFrameRect(width, 21, 4, 4, 4, 4, 1, null, borderFillStyle, shapeFillStyle);
			roundFrameRect.filters = [dropShadowFilter];
			return roundFrameRect;
		}
		
		protected function createDownSkin(width:Number):DisplayObject{
			var solidFillData:SolidFillData = new SolidFillData(0x3c3f9c, 1);
			var borderFillStyle:ShapeFillStyle = ShapeFillStyle.createBySolidFillData(solidFillData);
			var gradientFillData:GradientFillData = new GradientFillData(GradientType.LINEAR, [0xaecceb,0x568de4,0x387de3,0x9cc9eb],[1.00,1.00,1.00,1.00],[0,128,129,255],90);
			var shapeFillStyle:ShapeFillStyle = ShapeFillStyle.createByGradientFillData(gradientFillData);
			var dropShadowFilter:DropShadowFilter = new DropShadowFilter(1, 90, 0, 0.2, 0, 1);
			var roundFrameRect:RoundFrameRect = new RoundFrameRect(width, 21, 4, 4, 4, 4, 1, null, borderFillStyle, shapeFillStyle);
			roundFrameRect.filters = [dropShadowFilter];
			return roundFrameRect;
		}
		
		protected function onMouseGoDown(event:MouseEvent):void
		{
			updateState(STATE_DOWN);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseGoUp);
		}
		
		protected function onMouseGoUp(event:MouseEvent):void
		{
			updateState(STATE_UP);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseGoUp);
		}
		
		public function set label(str:String):void
		{
			_label.text = str;
		}
		public function get label():String
		{
			return _label.text;
		}		
	}
}
