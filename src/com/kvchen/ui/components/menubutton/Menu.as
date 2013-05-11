package com.kvchen.ui.components.menubutton
{
	import com.kvchen.ui.fillstyle.ShapeFillStyle;
	import com.kvchen.ui.fillstyle.data.SolidFillData;
	import com.kvchen.ui.shape.RoundFrameRect;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class Menu extends Sprite implements MenuItemDelegate
	{
		public static const MENU_ITEM_HEIGHT:int = 18;
		
		protected var _bg:DisplayObject;
		protected var _items:Array = null;
		protected var _listItems:Array = null;
		protected var _width:Number;
		
		public var delegate:MenuDelegate = null;
		
		public function Menu(items:Array, width:Number = 100)
		{
			_items = items;
			_width = width;
			
			_bg = createListBg(_width, items.length*MENU_ITEM_HEIGHT+10);
			
			this.addChild(_bg);
			
			_listItems = new Array();
			for (var i:int = 0; i < items.length; i++) 
			{
				var item:MenuItem = new MenuItem(items[i], _width);
				item.y = 5 + i * MENU_ITEM_HEIGHT;
				item.index = i;
				item.delegate = this;
				addChild(item);
				_listItems.push(item);
			}
		}
		
		public function menuItemDidSelected(menuItem:MenuItem):void{
			if(delegate != null){
				delegate.menuDidSelectMenuItem(menuItem);
			}
		}
		
		protected function createListBg(width:Number, height:Number):DisplayObject{
			var solidFillData0:SolidFillData = new SolidFillData(0x949494, 0.54);
			var borderFillStyle:ShapeFillStyle = ShapeFillStyle.createBySolidFillData(solidFillData0);
			var solidFillData:SolidFillData = new SolidFillData(0xfefefe, 1);
			var shapeFillStyle:ShapeFillStyle = ShapeFillStyle.createBySolidFillData(solidFillData);
			var roundFrameRect:RoundFrameRect = new RoundFrameRect(width, height, 5, 5, 5, 5, 1, null, borderFillStyle, shapeFillStyle);
			return roundFrameRect;
		}
	}
}