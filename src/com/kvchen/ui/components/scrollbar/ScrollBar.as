package com.kvchen.ui.components.scrollbar
{
	import com.kvchen.ui.fillstyle.ShapeFillStyle;
	import com.kvchen.ui.fillstyle.data.SolidFillData;
	import com.kvchen.ui.shape.RoundFrameRect;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	public class ScrollBar extends Sprite
	{
		public static const HORIZONTAL:String = "horizontal";
		public static const VERTICAL:String = "vertical";
		
		public static const MIN_SCROLL_SIZE:Number = 11;
		
		protected var _orientation:String = "";
		protected var _scrollSize:Number = 0;
		protected var _autoHide:Boolean = true;
		protected var _trackSkin:ScrollBarTrackSkin;
		protected var _scrollSkin:ScrollBarScrollSkin;
		
		public function ScrollBar(orientation:String = "vertical", scrollSize:Number = 100, autoHide:Boolean = true)
		{
			_orientation = orientation;
			_scrollSize = scrollSize;
			_autoHide = autoHide;
			_trackSkin = new ScrollBarTrackSkin(_orientation, _scrollSize);
			_scrollSkin = new ScrollBarScrollSkin(_orientation, _scrollSize);
			
			if(_orientation == ScrollBar.HORIZONTAL){
				_scrollSkin.y = 3;
			}else if(_orientation == ScrollBar.VERTICAL){
				_scrollSkin.x = 3;
			}
			this.addChild(_trackSkin);
			this.addChild(_scrollSkin);
			initEvent();
		}
		
		protected function initEvent():void{
			
		}
				
		public function set scrollSize(value:Number):void{
			_scrollSize = value;
			_trackSkin.size = _scrollSize;
			updateScrollBar();
		}
		
		public function get scrollSize():Number{
			return _scrollSize;
		}
		
		public function set autoHide(value:Boolean):void
		{
			_autoHide = value;
			updateScrollBar();
		}
		
		public function get autoHide():Boolean
		{
			return _autoHide;
		}
		
		public function updateScrollBar():void{
			
			
			
		}
	}
}
















