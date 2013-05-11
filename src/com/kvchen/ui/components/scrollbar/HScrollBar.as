package com.kvchen.ui.components.scrollbar
{
	import flash.events.MouseEvent;
	
	public class HScrollBar extends ScrollBar
	{
		protected var _minX:Number;
		protected var _maxX:Number;
		protected var _offsetX:Number;
		
		protected var _scrollContent:IHorizontalScrollContent;
		
		public function HScrollBar(scrollContent:IHorizontalScrollContent, scrollSize:Number=100, autoHide:Boolean=true)
		{
			super(HORIZONTAL, scrollSize, autoHide);
			_scrollContent = scrollContent;
			updateScrollBar();
		}
		
		override public function get width():Number
		{
			return _scrollSize;
		}
		
		override public function get height():Number
		{
			return 17;
		}
		
		public function set scrollContent(value:IHorizontalScrollContent):void{
			_scrollContent = value;
			updateScrollBar();
		}
		
		override protected function initEvent():void{
			_scrollSkin.addEventListener(MouseEvent.MOUSE_DOWN, onPressScroll);
		}
		
		protected function onPressScroll(e:MouseEvent):void{
			_offsetX = stage.mouseX - _scrollSkin.x;
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMoving);
			stage.addEventListener(MouseEvent.MOUSE_UP, onRelease);
		}
		
		protected function onMoving(e:MouseEvent):void
		{
			var xpos:Number = stage.mouseX - _offsetX;
			xpos = xpos < _minX ? _minX : xpos;
			xpos = xpos > _maxX ? _maxX : xpos;
			_scrollSkin.x = xpos;
			_scrollContent.xpos = getRelValue(_maxX, xpos, _minX, _scrollContent.minX, _scrollContent.maxX);
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
			
			var scrollWidth:Number = (_scrollContent.visibleWidth * _scrollSize)/_scrollContent.contentWidth;
			scrollWidth = scrollWidth < MIN_SCROLL_SIZE ? MIN_SCROLL_SIZE : scrollWidth;
			_minX = 2;
			_maxX = _scrollSize - scrollWidth -2;
			_scrollSkin.size = scrollWidth;
			_scrollSkin.x = getRelValue(_scrollContent.maxX, _scrollContent.xpos, _scrollContent.minX, _minX, _maxX);
			
			if(_scrollContent.visibleWidth >= _scrollContent.contentWidth && autoHide == true){
				this.visible = false;
			}else{
				this.visible = true;
			}
		}
	}
}