package com.kvchen.ui.components.segmentedcontrol
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class SegmentedControl extends Sprite
	{
		public var delegate:SegmentedControlDelegate = null;
		
		protected var _buttons:Array = null;
		
		public function SegmentedControl(buttonWidth:Number = 60, selectedIndex:int = 0, ...labels)
		{
			_buttons = new Array();
			if(labels is Array){
				
				for (var i:int = 0; i < labels.length; i++) 
				{
					var side:int = SegmentedButton.SIDE_MIDDLE;
					if(i == 0){
						side = SegmentedButton.SIDE_LEFT;
					}else if(i == labels.length-1){
						side = SegmentedButton.SIDE_RIGHT;
					}
					var selected:Boolean = false;
					if(i == selectedIndex){
						selected = true;
					}
					var btn:SegmentedButton = new SegmentedButton(labels[i], buttonWidth, side, selected);
					btn.x = i * buttonWidth - i;
					btn.addEventListener(MouseEvent.CLICK, onClickSegmentedBtn);
					_buttons.push(btn);
					addChild(btn);
				}
				this.addChild(_buttons[selectedIndex]);
			}else{
				throw new Error("SegmentedControl need at least 2 labels. ");
			}
		}
		
		public function get selectedButtonLabel():String{
			
			for(var i:uint = 0; i < _buttons.length; i++)
			{
				var btn:SegmentedButton = _buttons[i];
				if(btn.selected){
					return btn.label;
				}
			}
			return "";
		}
		
		public function set selectedButtonLabel(label:String):void{
			
			for(var i:uint = 0; i < _buttons.length; i++)
			{
				var btn:SegmentedButton = _buttons[i];
				if(btn.label == label){
					btn.selected = true;
					addChild(btn);
				}else{
					btn.selected = false;
				}
			}
		}
		
		protected function onClickSegmentedBtn(e:MouseEvent):void{
			
			var btn:SegmentedButton = SegmentedButton(e.currentTarget);
			for(var i:uint = 0; i < _buttons.length; i++)
			{
				if(_buttons[i] != btn){
					_buttons[i].selected = false;
				}else{
					_buttons[i].selected = true;
				}
			}
			this.addChild(btn);
			if(delegate != null){
				delegate.segmentedControlDidSelectButton(this, btn.label);
			}
		}
	}
}