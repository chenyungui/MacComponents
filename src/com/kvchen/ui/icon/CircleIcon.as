package com.kvchen.ui.icon
{
	import com.kvchen.ui.fillstyle.LineFillStyle;
	import com.kvchen.ui.fillstyle.ShapeFillStyle;

	public class CircleIcon extends IconBase
	{
		public function CircleIcon(size:Number = 14, lineFillStyle:LineFillStyle = null, shapeFillStyle:ShapeFillStyle = null)
		{
			var data:Vector.<Number> = new Vector.<Number>();
			data.push(-0.0669,-6.8625,3.6865,-6.8625,6.7292,-3.8198,6.7292,-0.0664,6.7292,3.6870,3.6865,6.7297,-0.0669,6.7297,-3.8203,6.7297,-6.8630,3.6870,-6.8630,-0.0664,-6.8630,-3.8198,-3.8203,-6.8625,-0.0669,-6.8625);
			var command:Vector.<int> = new Vector.<int>();
			command.push(1,6,6,6,6);
			super(data, command, size, lineFillStyle, shapeFillStyle);
		}
	}
}
