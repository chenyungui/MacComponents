package com.kvchen.ui.components.list
{
	public class ListCellPool
	{
		private var ListItemClass:Class;
		private var _pool:Array = null;
		
		public function ListCellPool(ListItemClass:Class)
		{
			this.ListItemClass = ListItemClass;
			this._pool = new Array();
		}
		
		public function getListCell():ListCell{
			
			if(_pool.length > 0){
				return _pool.pop();
			}else{
				return new ListItemClass();
			}
		}
		
		public function returnListCell(item:ListCell):void{
			_pool.push(item);
		}
		
		public function drainPool():void{
			_pool.length = 0;
		}
	}
}