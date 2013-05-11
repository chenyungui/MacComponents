package com.kvchen.ui.shape.protocol
{
	import com.kvchen.ui.fillstyle.LineFillStyle;
	import com.kvchen.ui.fillstyle.ShapeFillStyle;
	
	import flash.geom.Matrix;

	public interface IFillable
	{
		function set lineStyle(style:LineFillStyle):void
		function set fillStyle(style:ShapeFillStyle):void
	}
}