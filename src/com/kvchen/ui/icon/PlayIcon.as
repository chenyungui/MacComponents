package com.kvchen.ui.icon
{
	import com.kvchen.ui.fillstyle.LineFillStyle;
	import com.kvchen.ui.fillstyle.ShapeFillStyle;

	public class PlayIcon extends IconBase
	{
		public function PlayIcon(size:Number = 14, lineFillStyle:LineFillStyle = null, shapeFillStyle:ShapeFillStyle = null)
		{
			var data:Vector.<Number> = new Vector.<Number>();
			data.push(-6.8112,-6.7957,-6.8112,-6.7957,-6.8112,6.7957,-6.8112,6.7957,-6.8112,6.7957,4.9583,0.0000,4.9583,0.0000,4.9583,0.0000,-6.8112,-6.7957,-6.8112,-6.7957);
			var command:Vector.<int> = new Vector.<int>();
			command.push(1,6,6,6);
			super(data, command, size, lineFillStyle, shapeFillStyle);
		}
	}
}
