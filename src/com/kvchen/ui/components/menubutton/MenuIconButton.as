package com.kvchen.ui.components.menubutton
{
	import com.kvchen.ui.components.toolbutton.ToolButton;
	import com.kvchen.ui.fillstyle.ShapeFillStyle;
	import com.kvchen.ui.fillstyle.data.GradientFillData;
	import com.kvchen.ui.fillstyle.data.SolidFillData;
	import com.kvchen.ui.shape.RoundFrameRect;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.geom.Point;
	
	public class MenuIconButton extends Sprite implements MenuDelegate
	{
		protected var _items:Array;
		protected var _width:Number;
		protected var _height:Number = 22;
		
		protected var _menuBtn:ToolButton;
		protected var _menuCon:Sprite;
		protected var _menu:Menu;
		protected var _triangle:Bitmap;
		
		public var delegate:MenuIconButtonDelegate = null;
		
		public function MenuIconButton(icon:BitmapData, items:Array, iconOffsetX:Number = 0, iconOffsetY:Number = 0, width:Number = 22, menuWidth:Number = 100)
		{
			_menuBtn = new ToolButton(icon, onClickButton, iconOffsetX, iconOffsetY, width);
			_items = items;
			_width = width;
			_menuCon = new Sprite();
			_menu = new Menu(items, menuWidth);
			_menu.delegate = this;
			_menuCon.addChild(_menu);
			
			_triangle = new Bitmap(createTriangleIcon());
			_triangle.x = _width-4;
			_triangle.y = _height-4;
			
			addChild(_menuBtn);
			addChild(_triangle);
		}
		
		public function menuDidSelectMenuItem(menuItem:MenuItem):void{

			if(delegate != null){
				delegate.menuIconButtonDidSelectMenuItem(this, menuItem.label);
			}
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
				
		protected function onClickButton(e:MouseEvent):void{
			
			var globalPos:Point = this.localToGlobal(new Point());
			
			_menu.x = 0;
			_menu.y = Math.round(_height/2);
			_menuCon.x = globalPos.x;
			_menuCon.y = globalPos.y;
			stage.addChild(_menuCon);
			
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		protected function onMouseUp(e:MouseEvent):void{
			if(_menuCon.parent)_menuCon.parent.removeChild(_menuCon);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		protected function createTriangleIcon():BitmapData
		{
			var bmpd:BitmapData = new BitmapData(3, 2, true, 0x00ffffff);
			bmpd.setPixel32(0, 0, 0xff000000);
			bmpd.setPixel32(1, 0, 0xff000000);
			bmpd.setPixel32(2, 0, 0xff000000);
			bmpd.setPixel32(1, 1, 0xff000000);
			return bmpd;
		}
	}
}