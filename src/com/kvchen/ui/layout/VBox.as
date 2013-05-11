package com.kvchen.ui.layout
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class VBox extends Sprite
	{
		public var widthes:Array = [];
		public var gap:Number = 0;
		
		protected var _xposes:Array = [];
		protected var _ypos:Number = 0;
		protected var _columnCount:int = 1;
		protected var _childIndex:int = 0;
		
		public function VBox(gap:Number, ...widthes)
		{
			this.gap = gap;
			if(widthes is Number){
				this.widthes = [widthes];
			}else if(widthes is Array){
				if(widthes.length > 0){
					this.widthes = widthes;
				}else{
					this.widthes = [100];
				}
			}else{
				this.widthes = [100];
			}
			_columnCount = this.widthes.length;
			_xposes = calculateXPosArray(widthes);
		}
		
		private function calculateXPosArray(widthes:Array):Array
		{
			var pos:Array = [0];
			var x:Number = 0;
			for (var i:int = 0; i < widthes.length-1; i++) 
			{
				x += widthes[i];
				pos.push(x);
			}
			return pos;
		}
		
		override public function addChild(child:DisplayObject):DisplayObject{
			
			var coordX:int, coordY:int;
			
			if(child != null){
				coordX = _childIndex%_columnCount;
				coordY = _childIndex/_columnCount;
				_childIndex++;
				
				child.x = _xposes[coordX];
				child.y = _ypos;
				
				if(coordX == _columnCount-1){
					_ypos += child.height + gap;
				}
				return super.addChild(child);
				
			}else{
				coordX = _childIndex%_columnCount;
				_childIndex++;
				if(coordX == _columnCount-1){
					var obj:DisplayObject = getChildAt(numChildren-1);
					_ypos += obj.height + gap;
				}
				
				return null;
			}
		}
	}
}









