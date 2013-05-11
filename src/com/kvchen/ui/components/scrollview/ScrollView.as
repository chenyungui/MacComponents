package com.kvchen.ui.components.scrollview
{
	import com.kvchen.ui.components.scrollbar.HScrollBar;
	import com.kvchen.ui.components.scrollbar.IHorizontalScrollContent;
	import com.kvchen.ui.components.scrollbar.IVerticalScrollContent;
	import com.kvchen.ui.components.scrollbar.VScrollBar;
	import com.kvchen.ui.fillstyle.ShapeFillStyle;
	import com.kvchen.ui.fillstyle.data.GradientFillData;
	import com.kvchen.ui.fillstyle.data.SolidFillData;
	import com.kvchen.ui.shape.RoundFrameRect;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	
	import spark.components.supportClasses.DisplayLayer;
	
	public class ScrollView extends Sprite implements IHorizontalScrollContent, IVerticalScrollContent
	{
		protected var _width:Number = 0;
		protected var _height:Number = 0;
		
		protected var _bgSkin:DisplayObject;
		protected var _cornerSkin:DisplayObject;
		protected var _clipedCon:Sprite;
		protected var _contentCon:Sprite;
		protected var _clipedMask:Shape;
		
		protected var _vScrollBar:VScrollBar;
		protected var _hScrollBar:HScrollBar;
		
		protected var _visibleSizeVarible:Number = 0;
		
		public function ScrollView(width:Number, height:Number)
		{
			_width = width;
			_height = height;
			
			_bgSkin = createBorderSkin(_width, _height);
			_cornerSkin = createCornerSkin();
			_cornerSkin.x = _width-_cornerSkin.width;
			_cornerSkin.y = _height-_cornerSkin.height;
			
			_clipedCon = new Sprite();
			_contentCon = new Sprite();
			_clipedMask = createContentMask(1, 1, _width-2, _height-2);
			_clipedCon.mask = _clipedMask;
			_clipedCon.addChild(_contentCon);
			
			_vScrollBar = new VScrollBar(this, _height);
			_vScrollBar.x = _width - _vScrollBar.width;
			_hScrollBar = new HScrollBar(this, _width);
			_hScrollBar.y = _height - _hScrollBar.height;
			
			addChild(_bgSkin);
			addChild(_clipedCon);
			addChild(_clipedMask);
			addChild(_vScrollBar);
			addChild(_hScrollBar);
			addChild(_cornerSkin);
			
			updateScrollBars();
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

		
		protected function updateScrollBars():void{
			
			if(contentWidth > visibleWidth && contentHeight > visibleHeight){
				_visibleSizeVarible = _hScrollBar.height;
				_vScrollBar.scrollSize = _height-_hScrollBar.height+1;
				_hScrollBar.scrollSize = _width-_vScrollBar.width+1;
				_cornerSkin.visible = true;
			}else if(contentWidth > visibleWidth){
				_visibleSizeVarible = 0;
				_hScrollBar.scrollSize = _width;
				_vScrollBar.updateScrollBar();
				_cornerSkin.visible = false;
			}else if(contentHeight > visibleHeight){
				_visibleSizeVarible = 0;
				_hScrollBar.updateScrollBar();
				_vScrollBar.scrollSize = _height;
				_cornerSkin.visible = false;
			}else{
				_visibleSizeVarible = 0;
				_hScrollBar.updateScrollBar();
				_vScrollBar.updateScrollBar();
				_cornerSkin.visible = false;
			}
		}
		
		public function addChildObject(child:DisplayObject):void{
			_contentCon.addChild(child);
			updateScrollBars();
		}
		
		public function get contentCon():DisplayObjectContainer
		{
			return _contentCon;
		}
		
		public function get visibleWidth():Number
		{
			return _width-2-_visibleSizeVarible;
		}
		
		public function get contentWidth():Number
		{
			return _contentCon.width;
		}
		
		public function get minX():Number
		{
			return _width - _contentCon.width - _visibleSizeVarible;
		}
		
		public function get maxX():Number
		{
			return 1;
		}
		
		public function get xpos():Number
		{
			return _contentCon.x;
		}
		
		public function set xpos(value:Number):void
		{
			_contentCon.x = value;
		}
		
		public function get visibleHeight():Number
		{
			return _height-2-_visibleSizeVarible;
		}
		
		public function get contentHeight():Number
		{
			return _contentCon.height;
		}
		
		public function get minY():Number
		{
			return _height - _contentCon.height - _visibleSizeVarible;
		}
		
		public function get maxY():Number
		{
			return 1;
		}
		
		public function get ypos():Number
		{
			return _contentCon.y;
		}
		
		public function set ypos(value:Number):void
		{
			_contentCon.y = value;
		}
		
		protected function createContentMask(x:Number, y:Number, width:Number, height:Number):Shape
		{
			var s:Shape = new Shape();
			s.graphics.beginFill(0x0);
			s.graphics.drawRect(x, y, width, height);
			s.graphics.endFill();
			return s;
		}
		
		protected function createCornerSkin():DisplayObject
		{
			var solidFillData0:SolidFillData = new SolidFillData(0xa9a9a9, 1);
			var borderFillStyle:ShapeFillStyle = ShapeFillStyle.createBySolidFillData(solidFillData0);
			var solidFillData:SolidFillData = new SolidFillData(0xe3e3e3, 0.9073170731707317);
			var shapeFillStyle:ShapeFillStyle = ShapeFillStyle.createBySolidFillData(solidFillData);
			var w:Number = 17, h:Number = 17;
			var roundFrameRect:RoundFrameRect = new RoundFrameRect(w, h, 0, 0, 0, 0, 1, null, borderFillStyle, shapeFillStyle);
			return roundFrameRect;
		}
		
		protected function createBorderSkin(width:Number, height:Number):DisplayObject
		{
			var gradientFillData:GradientFillData = new GradientFillData(GradientType.LINEAR, [0x898989,0xacacac],[1.00,1.00],[0,135],90);
			var borderFillStyle:ShapeFillStyle = ShapeFillStyle.createByGradientFillData(gradientFillData);
			var solidFillData:SolidFillData = new SolidFillData(0xffffff, 1);
			var shapeFillStyle:ShapeFillStyle = ShapeFillStyle.createBySolidFillData(solidFillData);
			var roundFrameRect:RoundFrameRect = new RoundFrameRect(width, height, 0, 0, 0, 0, 1, null, borderFillStyle, shapeFillStyle);
			return roundFrameRect;
		}
	}
}