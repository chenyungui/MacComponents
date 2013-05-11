package com.kvchen.ui.layout
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class HBox extends Sprite
	{
		protected var _gap:Number;
		protected var _xpos:Number;
		
		public function HBox(gap:Number = 0)
		{
			_gap = gap;
			_xpos = 0;
		}
		
		override public function addChild(child:DisplayObject):DisplayObject{
			child.x = _xpos;
			_xpos += child.width + _gap;
			return super.addChild(child);
		}
	}
}