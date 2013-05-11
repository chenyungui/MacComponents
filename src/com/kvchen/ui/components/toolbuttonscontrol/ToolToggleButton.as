package com.kvchen.ui.components.toolbuttonscontrol
{
	import com.kvchen.ui.components.togglebutton.ToggleButton;
	import com.kvchen.ui.fillstyle.ShapeFillStyle;
	import com.kvchen.ui.fillstyle.data.GradientFillData;
	import com.kvchen.ui.fillstyle.data.SolidFillData;
	import com.kvchen.ui.shape.RoundFrameRect;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class ToolToggleButton extends Sprite
	{
		protected var _width:Number = 25;
		protected var _height:Number = 20;
		protected var _icon:BitmapData;
		
		protected var _onSkin:DisplayObject;
		protected var _offSkin:DisplayObject;
		
		protected var _selected:Boolean = false;
		
		public function ToolToggleButton(icon:BitmapData, selected:Boolean = false, clickHandler:Function = null)
		{
			_icon = icon;
			_selected = selected;
			_offSkin = createDeselectedSkin();
			_onSkin = createSelectedSkin();
			updateState(_selected);
			initEvent();
			if(clickHandler != null){
				addEventListener(MouseEvent.CLICK, clickHandler);
			}
		}
		
		public function set enabled(value:Boolean):void{
			if(value){
				this.mouseEnabled = true;
				this.mouseChildren = true;
			}else{
				this.mouseEnabled = false;
				this.mouseChildren = false;
			}
		}
		
		override public function get width():Number{
			return _width;
		}
		
		override public function get height():Number{
			return _height;
		}
		
		public function get selected():Boolean
		{
			return _selected;
		}
		
		public function set selected(value:Boolean):void
		{
			if(value != _selected){
				_selected = value;
				updateState(_selected);
			}
		}
		
		protected function initEvent():void{
			addEventListener(MouseEvent.CLICK, onClick);
		}
		
		protected function onClick(e:MouseEvent):void{
			
			this.selected = true;
		}
		
		protected function updateState(selected:Boolean):void{
			
			this.removeChildren();
			switch(selected){
				case true:
					this.addChild(_onSkin);
					break;
				case false:
					this.addChild(_offSkin);
					break;
			}
		}
		
		protected function createSelectedSkin():DisplayObject{
			
			var container:Sprite = new Sprite();
			var bgSkin:DisplayObject = createDownBg(_width, _height);
			var bmp:Bitmap = new Bitmap(_icon);
			bmp.x = Math.round((_width - bmp.width)/2);
			bmp.y = Math.round((_height - bmp.height)/2);
			container.addChild(bgSkin);
			container.addChild(bmp);
			return container;
		}
		
		protected function createDeselectedSkin():DisplayObject{
			
			var container:Sprite = new Sprite();
			var bmp:Bitmap = new Bitmap(_icon);
			bmp.x = Math.round((_width - bmp.width)/2);
			bmp.y = Math.round((_height - bmp.height)/2);
			container.addChild(bmp);
			return container;
		}
		
		protected function createDownBg(width:Number, height:Number):DisplayObject{
			var solidFillData:SolidFillData = new SolidFillData(0x959595, 1);
			var borderFillStyle:ShapeFillStyle = ShapeFillStyle.createBySolidFillData(solidFillData);
			var gradientFillData:GradientFillData = new GradientFillData(GradientType.LINEAR, [0xadadad,0xa0a0a0,0x838383,0xc5c5c5],[1.00,1.00,1.00,1.00],[0,25,57,255],90);
			var shapeFillStyle:ShapeFillStyle = ShapeFillStyle.createByGradientFillData(gradientFillData);
			var roundFrameRect:RoundFrameRect = new RoundFrameRect(width, height, 0, 0, 0, 0, 1, null, borderFillStyle, shapeFillStyle);
			return roundFrameRect;
		}
	}
}