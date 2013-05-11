package com.kvchen.ui.components.colorpicker
{
	public interface ColorMatrixDelegate
	{
		function colorMatrixDidSelectColor(colorMatrix:ColorMatrix, color:uint):void;
		function colorMatrixMouseOverColor(colorMatrix:ColorMatrix, color:uint):void;
	}
}