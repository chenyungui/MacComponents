package com.kvchen.ui.components.panel
{
	import com.kvchen.ui.components.label.Label;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class Panel extends Sprite
	{
		protected var _label:Label;
		
		protected var _panelBar:PanelHeadSkin;
		protected var _panelBg:PanelBodySkin;
		protected var _closeBtn:PanelCloseButton;
		protected var _container:Sprite;
		
		protected var _width:Number;
		protected var _barHeight:Number;
		protected var _bgHeight:Number;
		protected var _offsetX:Number;
		protected var _offsetY:Number;
		
		public function Panel(width:Number = 300, barHeight:Number = 23, bgHeight:Number = 250, title:String = "")
		{
			this._width = width;
			this._barHeight = barHeight;
			this._bgHeight = bgHeight;
			this._label = new Label(title, _width, TextFormatAlign.CENTER);
			this._label.mouseChildren = false;
			this._label.mouseEnabled = false;
			init();
		}
		
		override public function get width():Number{
			return _width;
		}
		override public function get height():Number{
			return _barHeight + _bgHeight;
		}
		
		public function set draggable(value:Boolean):void
		{
			if(value){
				if(!_panelBar.hasEventListener(MouseEvent.MOUSE_DOWN)){
					_panelBar.addEventListener(MouseEvent.MOUSE_DOWN, onPressBar);
				}
			}else{
				if(_panelBar.hasEventListener(MouseEvent.MOUSE_DOWN)){
					_panelBar.removeEventListener(MouseEvent.MOUSE_DOWN, onPressBar);
				}
			}
		}
		
		public function set title(value:String):void{
			_label.text = value;
		}
		
		public function get title():String{
			return _label.text;
		}
		
		public function set content(value:DisplayObject):void
		{
			while(_container.numChildren) _container.removeChildAt(0);
			_container.addChild(value);
		}
		
		public function set enableShadow(value:Boolean):void
		{
			if(value){
				this.filters = [new DropShadowFilter(5, 90, 0x0, .3, 5, 5, 2, 5)];
			}else{
				this.filters = null;
			}
		}
		
		public function removeFromParent():void{
			if(this.parent != null){
				this.parent.removeChild(this);
			}
		}
		
		private function onPressBar(e:MouseEvent):void
		{
			_offsetX = stage.mouseX - this.x;
			_offsetY = stage.mouseY - this.y;
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onDragBar);
			stage.addEventListener(MouseEvent.MOUSE_UP, onReleaseBar);
		}
		
		private function onDragBar(e:MouseEvent):void
		{
			this.x = stage.mouseX - _offsetX;
			this.y = stage.mouseY - _offsetY;
			e.updateAfterEvent();
		}
		
		private function onReleaseBar(e:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onDragBar);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onReleaseBar);
		}
		
		private function init():void
		{
			_panelBar = new PanelHeadSkin(_width, _barHeight);
			_panelBg = new PanelBodySkin(_width, _bgHeight+1);
			_panelBg.y = _barHeight-1;
			_closeBtn = new PanelCloseButton();
			_closeBtn.x = 11;
			_closeBtn.y = 11;
			_container = new Sprite();
			_container.y = _barHeight;
			
			addChild(_panelBg);
			addChild(_panelBar);
			addChild(_closeBtn);
			addChild(_label);
			addChild(_container);
		}
				
	}
}