package com.kvchen.ui.components.searchfield
{
	import com.kvchen.ui.components.list.List;
	import com.kvchen.ui.components.list.ListDelegate;
	import com.kvchen.ui.fillstyle.ShapeFillStyle;
	import com.kvchen.ui.fillstyle.data.GradientFillData;
	import com.kvchen.ui.fillstyle.data.SolidFillData;
	import com.kvchen.ui.shape.RoundFrameRect;
	
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.ui.Keyboard;

	public class SearchField extends Sprite implements ListDelegate
	{
		
		protected var _width:Number = 0;
		
		protected var _bgSkin:DisplayObject;
		protected var _icon:DisplayObject;
		protected var _closeBtn:SearchFieldCloseButton;
		protected var _textField:TextField;
		protected var _resultList:List;
		protected var _isShowingResult:Boolean = false;
		
		public var delegate:SearchFieldDelegate;
		
		public function SearchField(width:Number = 150)
		{
			_width = width;
			
			_bgSkin = createInputBgSkin(_width);
			_icon = createSearchIcon();
			_icon.x = 11;
			_icon.y = 11;
			_closeBtn = new SearchFieldCloseButton();
			_closeBtn.x = _width - 11;
			_closeBtn.y = 11;
			_closeBtn.visible = false;
			_textField = createTextField(_width - 44);
			_textField.x = 22+2;
			_textField.y = 2;
			addChild(_bgSkin);
			addChild(_icon);
			addChild(_closeBtn);
			addChild(_textField);
			
			_resultList = new List(width, 150, null);
			_resultList.y = this.height;
			_resultList.filters = [new DropShadowFilter(5, 90, 0x0, .3, 5, 5, 2, 5)];
			_resultList.delegate = this;
			
			initEvent();
		}
		
		override public function get width():Number
		{
			return _width;
		}
		override public function get height():Number
		{
			return 22;
		}
		
		override public function set width(value:Number):void
		{
			
		}
		override public function set height(value:Number):void
		{
			
		}
		
		public function listDidPickItem(list:List, item:Object):void{

			hideResultList();
			if(delegate != null && item is String){
				delegate.searchFieldDidPickResult(String(item));
			}
		}
		
		public function listDidChangeSelection(list:List):void{
			
		}

		public function listItemDidChange(list:List, item:Object):void{
			
		}
		
		protected function showResultList():void{
			if(_resultList.parent == null){
				var pos:Point = this.localToGlobal(new Point(0, 22));
				_resultList.x = pos.x;
				_resultList.y = pos.y;
				stage.addChild(_resultList);
				_isShowingResult = true;
			}
		}
		
		protected function hideResultList():void{
			if(_resultList.parent){
				_resultList.parent.removeChild(_resultList);
				_isShowingResult = false;
			}
		}
		
		protected function initEvent():void{
			_textField.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			_textField.addEventListener(Event.CHANGE, onTextChange);
			_closeBtn.addEventListener(MouseEvent.CLICK, onClickCloseBtn);
		}
		
		protected function onKeyDown(e:KeyboardEvent):void{
			if(_isShowingResult){
				switch(e.keyCode){
					case Keyboard.ENTER:
						if(_resultList.items.length > 0){
							var item:String = String(_resultList.selectedItem);
							hideResultList();
							if(delegate != null){
								delegate.searchFieldDidPickResult(item);
							}
						}
						break;
					case Keyboard.DOWN:
						_resultList.selectedIndex ++;
						break;
					case Keyboard.UP:
						_resultList.selectedIndex --;
						break;
				}
			}
		}
		
		protected function onTextChange(e:Event):void{
			if(_textField.text.length > 0){
				_closeBtn.visible = true;
				
				if(delegate != null){
					var results:Array = [];
					var contents:Array = delegate.searchFieldRequestDataForSearch();
					var textForSearch:String = _textField.text;
					var regExp:RegExp = new RegExp(textForSearch, "i");
					if(contents != null){
						for each (var str:String in contents) 
						{
							if(str.search(regExp) > -1){
								results.push(str);
							}
						}
						
						if(results.length > 0){
							results = results.sort();
							_resultList.items = results;
							_resultList.selectedIndex = 0;
							showResultList();
						}else{
							hideResultList();
						}
					}
				}
				
			}else{
				_closeBtn.visible = false;
				hideResultList();
			}
		}
		
		protected function onClickCloseBtn(e:MouseEvent):void{
			_textField.text = "";
			_closeBtn.visible = false;
			hideResultList();
		}
		
		protected function createTextField(width:Number):TextField
		{
			var textFormat:TextFormat = new TextFormat("Arial", 11.5, 0x0, null, null, null, null, null, TextFormatAlign.LEFT);
			var tf:TextField = new TextField();
			tf = new TextField();
			tf.width = width;
			tf.height = 22;
			tf.defaultTextFormat = textFormat;
			tf.selectable = true;
			tf.type = TextFieldType.INPUT;
			return tf;
		}
		
		protected function createInputBgSkin(width:Number):DisplayObject{
			var gradientFillData:GradientFillData = new GradientFillData(GradientType.LINEAR, [0xbbbbbb,0xcdcdcd],[1.00,1.00],[0,255],90);
			var borderFillStyle:ShapeFillStyle = ShapeFillStyle.createByGradientFillData(gradientFillData);
			var solidFillData:SolidFillData = new SolidFillData(0xffffff, 1);
			var shapeFillStyle:ShapeFillStyle = ShapeFillStyle.createBySolidFillData(solidFillData);
			var dropShadowFilter:DropShadowFilter = new DropShadowFilter(3, 90, 0, 0.2, 2, 2, 1, 5, true);
			var roundFrameRect:RoundFrameRect = new RoundFrameRect(width, 22, 11, 11, 11, 11, 1, null, borderFillStyle, shapeFillStyle);
			roundFrameRect.filters = [dropShadowFilter];
			return roundFrameRect;
		}
		
		protected function createSearchIcon():DisplayObject{
			var data0:Vector.<Number> = new Vector.<Number>();
			data0.push(4.905,-1.247,4.939,-0.123,4.493,0.860,4.271,1.351,4.048,1.843,4.048,1.843,4.048,1.843,4.048,1.843,4.048,1.843,4.563,2.356,5.078,2.869,6.109,3.896,6.624,4.409,7.139,4.923,7.139,4.923,7.139,4.923,7.139,4.923,7.139,4.923,7.176,5.004,7.212,5.086,7.286,5.249,7.180,5.472,7.075,5.696,6.791,5.980,6.566,6.113,6.342,6.246,6.176,6.228,6.094,6.219,6.011,6.209,6.011,6.209,6.011,6.209,6.011,6.209,6.011,6.209,5.479,5.692,4.946,5.174,3.881,4.138,3.349,3.620,2.816,3.102,2.816,3.102,2.816,3.102,2.816,3.102,2.816,3.102,2.352,3.329,1.888,3.557,0.961,4.011,-0.175,3.987,-1.311,3.962,-2.655,3.458,-3.598,2.552,-4.541,1.646,-5.084,0.339,-5.084,-0.970,-5.084,-2.279,-4.541,-3.590,-3.616,-4.516,-2.691,-5.441,-1.384,-5.982,-0.077,-5.982,1.230,-5.982,2.537,-5.441,3.448,-4.538,4.358,-3.636,4.871,-2.370,4.905,-1.247);
			var command0:Vector.<int> = new Vector.<int>();
			command0.push(1,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6);
			var data:Vector.<Number> = new Vector.<Number>();
			data.push(-3.483,-0.971,-3.483,-0.090,-3.117,0.788,-2.491,1.410,-1.865,2.031,-0.979,2.396,-0.092,2.396,0.796,2.396,1.685,2.031,2.311,1.410,2.937,0.788,3.300,-0.090,3.300,-0.971,3.300,-1.852,2.937,-2.735,2.311,-3.359,1.685,-3.982,0.796,-4.345,-0.092,-4.345,-0.979,-4.345,-1.865,-3.982,-2.491,-3.359,-3.117,-2.735,-3.483,-1.852,-3.483,-0.971);
			var command:Vector.<int> = new Vector.<int>();
			command.push(1,6,6,6,6,6,6,6,6);
			
			var s:Shape = new Shape();
			s.graphics.beginFill(0x636363);
			s.graphics.drawPath(command0, data0);
			s.graphics.drawPath(command, data);
			s.graphics.endFill();
			return s;
		}
		
	}
}