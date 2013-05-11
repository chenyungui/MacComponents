package com.kvchen.ui.shape
{
	import com.kvchen.ui.fillstyle.LineFillStyle;
	import com.kvchen.ui.fillstyle.ShapeFillStyle;
	
	public class RoundFrameRectWrapper extends RoundFrameRect implements FillObjectDelegate
	{
		public var borderFillObject:FillObject;
		public var shapeFillObject:FillObject;
		
		public function RoundFrameRectWrapper(width:Number, height:Number, TLRadius:Number=5, TRRadius:Number=5, BLRadius:Number=5, BRRadius:Number=5, border:Number=2, lineStyle:LineFillStyle=null, borderFillStyle:ShapeFillStyle=null, shapeFillStyle:ShapeFillStyle=null)
		{
			super(width, height, TLRadius, TRRadius, BLRadius, BRRadius, border, lineStyle, borderFillStyle, shapeFillStyle);
			
			borderFillObject = new FillObject();
			borderFillObject.delegate = this;
			
			shapeFillObject = new FillObject();
			shapeFillObject.delegate = this;
		}
		
		public function handleFillStyleChange(object:FillObject, shapeFillStyle:ShapeFillStyle):void{
			if(object == borderFillObject){
				this.borderFillStyle = shapeFillStyle;
			}else if(object == shapeFillObject){
				this.shapeFillStyle = shapeFillStyle;
			}
		}
	}
}

import com.kvchen.ui.fillstyle.LineFillStyle;
import com.kvchen.ui.fillstyle.ShapeFillStyle;
import com.kvchen.ui.shape.protocol.IFillable;

internal class FillObject implements IFillable{
	
	public var delegate:FillObjectDelegate;
	
	public function FillObject(){
		
	}
	
	public function set lineStyle(style:LineFillStyle):void{
		
	}
	
	public function set fillStyle(style:ShapeFillStyle):void{
		if(delegate != null){
			delegate.handleFillStyleChange(this, style);
		}
	}
}

internal interface FillObjectDelegate{
	function handleFillStyleChange(object:FillObject, shapeFillStyle:ShapeFillStyle):void
}