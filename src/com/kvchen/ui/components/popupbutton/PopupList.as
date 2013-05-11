package com.kvchen.ui.components.popupbutton
{
	import com.kvchen.ui.fillstyle.ShapeFillStyle;
	import com.kvchen.ui.fillstyle.data.GradientFillData;
	import com.kvchen.ui.fillstyle.data.SolidFillData;
	import com.kvchen.ui.shape.RoundFrameRect;
	
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.display.Sprite;
	
	public class PopupList extends Sprite implements PopupListItemDelegate
	{
		public static const LIST_ITEM_HEIGHT:int = 18;
		
		protected var _bg:DisplayObject;
		protected var _items:Array = null;
		protected var _listItems:Array = null;
		protected var _selectedIndex:int = 0;
		protected var _width:Number;
		
		public var delegate:PopupListDelegate = null;
		
		public function PopupList(items:Array, selectedIndex:int = 0, width:Number = 100)
		{
			_items = items;
			_selectedIndex = selectedIndex;
			_width = width;
			
			_bg = createListBg(_width, items.length*LIST_ITEM_HEIGHT+10);
			
			this.addChild(_bg);
			
			_listItems = new Array();
			for (var i:int = 0; i < items.length; i++) 
			{
				var selected:Boolean = (_selectedIndex == i);
				var item:PopupListItem = new PopupListItem(items[i], selected, _width);
				item.y = 5 + i * LIST_ITEM_HEIGHT;
				item.index = i;
				item.delegate = this;
				addChild(item);
				_listItems.push(item);
			}
		}
		
		public function set selectedIndex(value:int):void{
			_selectedIndex = value;
			for (var i:int = 0; i < _listItems.length; i++) 
			{
				var item:PopupListItem = _listItems[i];
				if(i == _selectedIndex){
					item.selected = true;
				}else{
					if(item.selected == true){
						item.selected = false;
					}
				}
			}
		}
		
		public function popupListItemDidSelected(popupListItem:PopupListItem):void{
			if(delegate != null){
				delegate.popupListDidSelectItem(popupListItem);
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