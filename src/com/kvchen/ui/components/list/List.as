package com.kvchen.ui.components.list
{
	import com.kvchen.ui.components.scrollview.ScrollView;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.core.IFactory;
	
	public class List extends ScrollView
	{
		protected var _listCellClass:Class = ListCell;
		protected var _items:Array;
		protected var _cells:Array;
		protected var _allowMultiSelection:Boolean;
		protected var _lastSelectIndex:int = -1;
		
		protected var _listCellPool:ListCellPool;
		
		public var delegate:ListDelegate;
		
		public function List(width:Number, height:Number, items:Array, listCellClass:Class = null, allowMultiSelection:Boolean = false)
		{
			super(width, height);
			
			_items = items;
			_listCellClass = listCellClass || ListCell;
			_listCellPool = new ListCellPool(_listCellClass);
			_allowMultiSelection = allowMultiSelection;
			
			updateCells();
		}
		
		public function set allowMultiSelection(value:Boolean):void{
			_allowMultiSelection = value;
		}
		public function get allowMultiSelection():Boolean{
			return _allowMultiSelection;
		}
		
		public function set items(value:Array):void{
			_items = value;
			_lastSelectIndex = -1;
			updateCells();
		}
		
		public function get items():Array{
			return _items;
		}
		
		public function getItemByIndex(index:int):Object{
			var cell:ListCell = _cells[index];
			return cell.data;
		}
		public function getUnselectedItemsBeforeIndex(index:int):Array{
			
			index = index > _cells.length ? _cells.length : index;
			var items:Array = [];
			var i:int = -1;
			var cell:ListCell;
			while(++i < index){
				cell = ListCell(_cells[i]);
				if(cell.selected == false){
					items.push(cell.data);
				}
			}
			return items;
		}
		
		public function getUnselectedItemsAfterIndex(index:int):Array{
			index = index < -1 ? -1 : index;
			var items:Array = [];
			var i:int = index, len:int = _cells.length;
			var cell:ListCell;
			while(++i < len){
				cell = ListCell(_cells[i]);
				if(cell.selected == false){
					items.push(cell.data);
				}
			}
			return items;
		}
		public function set selectedItem(value:Object):void{
			var listCell:ListCell = getListCellByData(value);
			if(listCell != null){
				listCell.selected = true;
				updateList(listCell);
			}
		}
		
		public function get selectedItem():Object{
			
			for (var j:int = 0; j < _cells.length; j++) 
			{
				var cell:ListCell = _cells[j];
				if(cell.selected){
					return cell.data;
				}
			}
			return null;
		}
		
		public function set selectedItems(value:Array):void{
			deselectAll();
			if(value == null || value.length == 0){
				return;
			}
			var i:int = -1, j:int = -1, len:int = _cells.length;
			var labels:Array = value.concat();
			var cell:ListCell;
			while(++i < len){
				cell = _cells[i];
				j = labels.length;
				while(--j > -1){
					if(cell.data == labels[j]){
						cell.selected = true;
						labels.splice(j, 1);
					}
				}
			}
		}
		
		public function get selectedItems():Array{
			var items:Array = [];
			var i:int = -1, len:int = _cells.length;
			var cell:ListCell;
			while(++i < len){
				cell = _cells[i];
				if(cell.selected){
					items.push(cell.data);
				}
			}
			return items;
		}
		
		public function set selectedIndex(value:int):void{
			value = value < 0 ? 0 : value;
			value = value > (_items.length-1) ? (_items.length-1) : value;
			var listCell:ListCell = _cells[value];
			listCell.selected = true;
			updateList(listCell);
		}
		
		public function get selectedIndex():int{
			for (var j:int = 0; j < _cells.length; j++) 
			{
				var cell:ListCell = _cells[j];
				if(cell.selected){
					return j;
				}
			}
			return -1;
		}
		
		public function get lastSelectedIndex():int{
			var i:int = _cells.length;
			while(--i > -1){
				if(ListCell(_cells[i]).selected){
					return i;
				}
			}
			return -1;
		}
		
		public function set selectedIndices(value:Array):void{
			deselectAll();
			var i:int = -1, len:int = value.length, index:int = 0;
			var cell:ListCell;
			while(++i < len){
				index = value[i]
				cell = _cells[index];
				cell.selected = true;
			}
		}
		
		public function get selectedIndices():Array{
			var indices:Array = [];
			var i:int = -1, len:int = _cells.length;
			var cell:ListCell;
			while(++i < len){
				cell = _cells[i];
				if(cell.selected){
					indices.push(i);
				}
			}
			return indices;
		}
		
		public function removeSelectedItems():void{
			
			var unselectedItems:Array = [];
			var i:int = -1, len:int = _cells.length;
			var cell:ListCell;
			while(++i < len){
				cell = _cells[i];
				if(cell.selected == false){
					unselectedItems.push(cell.data);
				}
			}
			this.items = unselectedItems;
		}
		
		public function deselectAll():void{
			for (var j:int = 0; j < _cells.length; j++) 
			{
				var cell:ListCell = _cells[j];
				cell.selected = false;
			}
		}
		
		public function selectItem(label:String):void{
			var cell:ListCell = getListCellByLabel(label);
			if(cell != null){
				cell.selected = true;
				updateList(cell);
				
				if(delegate != null){
					delegate.listDidPickItem(this, cell.data);
				}
			}
		}
		
		public function scrollToCell(label:String):void{
			if(this.contentHeight < this.visibleHeight){
				return;
			}
			for (var j:int = 0; j < _cells.length; j++) 
			{
				var cell:ListCell = _cells[j];
				if(cell.label == label){
					
					var targetY:Number = - cell.y;
					if(targetY < this.minY){
						targetY = this.minY;
					}
					_contentCon.y = targetY;
					updateScrollBars();
					return;
				}
			}
		}
		
		public function scrollToFirstSelectedItem():void{
			if(this.contentHeight < this.visibleHeight){
				return;
			}
			var i:int = -1, len:int = _cells.length;
			var cell:ListCell;
			while(++i < len){
				cell = _cells[i];
				if(cell.selected){
					var targetY:Number = - cell.y;
					if(targetY < this.minY){
						targetY = this.minY;
					}
					_contentCon.y = targetY;
					updateScrollBars();
					return;
				}
			}
		}
		
		protected function getListCellByData(data:Object):ListCell{
			
			for (var j:int = 0; j < _cells.length; j++) 
			{
				var cell:ListCell = _cells[j];
				if(cell.data == data){
					return cell;
				}
			}
			return null;

		}
		
		protected function getListCellByLabel(label:String):ListCell{
			for (var j:int = 0; j < _cells.length; j++) 
			{
				var cell:ListCell = _cells[j];
				if(cell.label == label){
					return cell;
				}
			}
			return null;
		}
		
		protected function removeCells():void{
			
			_contentCon.removeChildren();
			
			if(_cells != null){
				var cell:ListCell;
				for (var j:int = 0; j < _cells.length; j++) 
				{
					cell = _cells[j];
					cell.removeEventListener(MouseEvent.CLICK, onClickCell);
					cell.removeEventListener(Event.CHANGE, onCellChanged);
					_listCellPool.returnListCell(cell);
				}
			}
			_cells = [];
			_contentCon.x = this.maxX;
			_contentCon.y = this.maxY;
		}
		
		protected function updateCells():void{
			
			removeCells();
			if(_items == null) return;
			
			var cell:ListCell;
			
			for (var i:int = 0; i < _items.length; i++) 
			{
				var item:Object = _items[i];
				cell = _listCellPool.getListCell();
				cell.setCellAttributes(_width-2, item, false);
				cell.addEventListener(MouseEvent.CLICK, onClickCell);
				cell.addEventListener(Event.CHANGE, onCellChanged);
				cell.y = i * cell.height;
				_contentCon.addChild(cell);
				_contentCon.x = maxX;
				_cells.push(cell);
			}
			
			updateScrollBars();
		}
		
		protected function onCellChanged(e:Event):void{
			
			var cell:ListCell = ListCell(e.currentTarget);
			if(delegate != null){
				delegate.listItemDidChange(this, cell.data);
			}
		}
		
		protected function onClickCell(e:MouseEvent):void{
			
			var i:int = 0, len:int, startIndex:int, endIndex:int;
			var cell:ListCell = ListCell(e.currentTarget);
			var index:int = getListCellIndex(cell);
			
			if(_allowMultiSelection){
				
				if(e.shiftKey){
					
					if(_lastSelectIndex > -1){
						startIndex = _lastSelectIndex;
						endIndex = index;
						if(index < _lastSelectIndex){
							startIndex = index;
							endIndex = _lastSelectIndex;
						}
						
						for(i=startIndex; i<=endIndex; ++i){
							
							ListCell(_cells[i]).selected = true;
						}
						
					}else{
						
						cell.selected = true;
					}
					
				}else if(e.ctrlKey){
					
					cell.selected = !cell.selected;
					
				}else{
					deselectAll();
					cell.selected = true;
				}
				
			}else{
				
				cell.selected = true;
				updateList(cell);
				
				if(delegate != null){
					delegate.listDidPickItem(this, cell.data);
				}
			}
			if(delegate != null){
				delegate.listDidChangeSelection(this);
			}
			_lastSelectIndex = index;
		}
		
		protected function getListCellIndex(cell:ListCell):int{
			var i:int = -1, len:int = _cells.length;
			while(++i < len){
				if(_cells[i] == cell){
					return i;
				}
			}
			return -1;
		}
		
		public function updateList(selectedCell:ListCell):void{
			
			for each (var cell:ListCell in _cells) 
			{
				if(cell != selectedCell){
					cell.selected = false;
				}
			}
		}
		
		
	}
}