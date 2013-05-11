package com.kvchen.ui.icon
{
	import com.kvchen.ui.fillstyle.LineFillStyle;
	import com.kvchen.ui.fillstyle.ShapeFillStyle;
	import com.kvchen.ui.shape.ShapeBase;
	
	public class IconBase extends ShapeBase
	{
		public static const DEFAULT_ICON_SIZE:Number = 14;
		
		protected var _data:Vector.<Number>;
		protected var _command:Vector.<int>;
		
		public function IconBase(data:Vector.<Number>, command:Vector.<int>, size:Number = 14, lineFillStyle:LineFillStyle = null, shapeFillStyle:ShapeFillStyle = null)
		{
			_data = data;
			_command = command;
			_x = -size/2;
			_y = -size/2;
			_width = size;
			_height = size;
			_lineStyle = lineFillStyle;
			_fillStyle = shapeFillStyle;
			
			if(size != DEFAULT_ICON_SIZE){
				var scale:Number = size/14.0;
				var i:int = 0, x:Number=0, y:Number=0, len:int = _data.length;
				for (i = 0; i < len; i += 2) 
				{
					_data[i] *= scale;
					_data[i+1] *= scale;
				}
			}
			updateShape();
		}
		
		override public function updateShape():void
		{
			this.graphics.clear();
			if((!_lineStyle) && (!_fillStyle)) return;
			super.updateShape();
			this.graphics.drawPath(_command, _data);
			this.graphics.endFill();
		}
	}
}