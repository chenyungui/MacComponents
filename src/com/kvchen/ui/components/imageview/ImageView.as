package com.kvchen.ui.components.imageview
{
	import com.kvchen.ui.fillstyle.ShapeFillStyle;
	import com.kvchen.ui.fillstyle.data.GradientFillData;
	import com.kvchen.ui.fillstyle.data.SolidFillData;
	import com.kvchen.ui.shape.RoundFrameRect;
	
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	public class ImageView extends Sprite
	{
		protected var _bgSkin:RoundFrameRect;
		protected var _imageCon:Sprite;
		protected var _image:DisplayObject;
		
		protected var _width:Number = 0;
		protected var _height:Number = 0;
		
		protected var _imageRect:Rectangle;
		
		public function ImageView(width:Number = 100, height:Number = 100, bgColor:uint = 0xffffff, image:DisplayObject = null)
		{
			_width = width;
			_height = height;
			_image = image;
			_imageRect = new Rectangle(1, 1, _width-2, _height-2);
			
			_bgSkin = createBorderSkin(_width, _height, bgColor);
			_imageCon = new Sprite();
			
			addChild(_bgSkin);
			addChild(_imageCon);
		}
		
		override public function get width():Number
		{
			return _width;
		}
		override public function get height():Number
		{
			return _height;
		}
		
		override public function set width(value:Number):void
		{
			
		}
		override public function set height(value:Number):void
		{
			
		}
		
		public function set image(object:DisplayObject):void{
			_image = object;
			updateView();
		}
		
		public function get image():DisplayObject{
			return _image;
		}
		
		public function get bgSkin():RoundFrameRect{
			return _bgSkin;
		}
		
		public function updateView():void{
			_imageCon.removeChildren();
			if(_image != null){
				_image.scaleX = _image.scaleY = 1;
				if(_image.width < _imageRect.width && _image.height < _imageRect.height){
					_image.x = Math.round(_imageRect.x + (_imageRect.width - _image.width)/2);
					_image.y = Math.round(_imageRect.y + (_imageRect.height - _image.height)/2);
					_image.scaleX = _image.scaleY = 1;
				}else{
					fitObjToRect(_image, _imageRect);
				}
				_imageCon.addChild(_image);
			}
		}
		
		protected function fitObjToRect(obj:DisplayObject, targetRect:Rectangle):void
		{
			var widthRate:Number = targetRect.width/obj.width;
			var heightRate:Number = targetRect.height/obj.height;
			
			if(widthRate < heightRate){
				obj.x = Math.round(targetRect.x);
				obj.y = Math.round((targetRect.height - obj.height*widthRate)/2 + targetRect.y);
				obj.scaleX = obj.scaleY = widthRate;
			}else{
				obj.x = Math.round((targetRect.width - obj.width*heightRate)/2 + targetRect.x);
				obj.y = Math.round(targetRect.y);
				obj.scaleX = obj.scaleY = heightRate;
			}
		}
		
		protected function createBorderSkin(width:Number, height:Number, bgColor:uint = 0xffffff):RoundFrameRect
		{
			var gradientFillData:GradientFillData = new GradientFillData(GradientType.LINEAR, [0x898989,0xacacac],[1.00,1.00],[0,135],90);
			var borderFillStyle:ShapeFillStyle = ShapeFillStyle.createByGradientFillData(gradientFillData);
			var solidFillData:SolidFillData = new SolidFillData(bgColor, 1);
			var shapeFillStyle:ShapeFillStyle = ShapeFillStyle.createBySolidFillData(solidFillData);
			var roundFrameRect:RoundFrameRect = new RoundFrameRect(width, height, 0, 0, 0, 0, 1, null, borderFillStyle, shapeFillStyle);
			return roundFrameRect;
		}
	}
}