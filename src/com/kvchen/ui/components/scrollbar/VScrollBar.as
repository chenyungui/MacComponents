package com.kvchen.ui.components.scrollbar
{
	import flash.events.MouseEvent;

	public class VScrollBar extends ScrollBar
	{
		protected var _minY:Number;
		protected var _maxY:Number;
		protected var _offsetY:Number;
		
		protected var _scrollContent:IVerticalScrollContent;
		
		public function VScrollBar(scrollContent:IVerticalScrollContent, scrollSize:Number=100, autoHide:Boolean=true)
		{
			super(VERTICAL, scrollSize, autoHide);
			_scrollContent = scrollContent;
			updateScrollBar();
		}
		
		override public function get width():Number
		{
			return 17;
		}
		override public function get height():Number
		{
			return _scrollSize;
		}
		
		public function set scrollContent(value:IVerticalScrollContent):void{
			_scrollContent = value;
			updateScrollBar();
		}
		
		override protected function initEvent():void{
			_scrollSkin.addEventListener(MouseEvent.MOUSE_DOWN, onPressScroll);
		}
		
		protected function onPressScroll(e:MouseEvent):void{
			_offsetY = stage.mouseY - _scrollSkin.y;
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMoving);
			stage.addEventListener(MouseEvent.MOUSE_UP, onRelease);
		}
		
		protected function onMoving(e:MouseEvent):void
		{
			var ypos:Number = stage.mouseY - _offsetY;
			ypos = ypos < _minY ? _minY : ypos;
			ypos = ypos > _maxY ? _maxY : ypos;
			_scrollSkin.y = ypos;
			_scrollContent.ypos = getRelValue(_maxY, ypos, _minY, _scrollContent.minY, _scrollContent.maxY);
			e.updateAfterEvent();
		}
		
		public static function getRelValue(min1:Number, val1:Number, max1:Number, min2:Number, max2:Number):Number
		{
			return min2 + (max2 - min2) * (val1 - min1)/(max1 - min1);
		}
		
		protected function onRelease(e:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMoving);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onRelease);
		}
		
		override public function updateScrollBar():void{
			
			var scrollHeight:Number = (_scrollContent.visibleHeight * _scrollSize)/_scrollContent.contentHeight;
			scrollHeight = scrollHeight < MIN_SCROLL_SIZE ? MIN_SCROLL_SIZE : scrollHeight;
			_minY = 2;
			_maxY = _scrollSize - scrollHeight - 2;
			_scrollSkin.size = scrollHeight;
			_scrollSkin.y = getRelValue(_scrollContent.maxY, _scrollContent.ypos, _scrollContent.minY, _minY, _maxY);
			
			if(_scrollContent.visibleHeight >= _scrollContent.contentHeight && autoHide == true){
				this.visible = false;
			}else{
				this.visible = true;
			}
		}
	}
}