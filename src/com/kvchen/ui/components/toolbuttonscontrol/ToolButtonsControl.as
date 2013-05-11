package com.kvchen.ui.components.toolbuttonscontrol
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import flashx.textLayout.formats.Direction;
	
	public class ToolButtonsControl extends Sprite
	{
		public static const DIRECTION_HORIZONTAL:String = "horizontal";
		public static const DIRECTION_VERTICAL:String = "vertical";
		
		protected var _buttons:Array = [];
		protected var _selectedButton:ToolToggleButton = null;
		
		public var delegate:ToolButtonsControlDelegate;
		
		public function ToolButtonsControl(direction:String = DIRECTION_HORIZONTAL, gap:Number = 3, ...toolToggleButtons)
		{
			var i:int = -1;
			var len:int = toolToggleButtons.length;
			var button:ToolToggleButton;
			
			var x:Number = 0;
			var y:Number = 0;
			while(++i < len){
				button = toolToggleButtons[i];
				button.x = x;
				button.addEventListener(MouseEvent.CLICK, onClickButton);
				if(direction == DIRECTION_HORIZONTAL){
					x += button.width + gap;
				}else if(direction == DIRECTION_VERTICAL){
					y += button.height + gap;
				}
				addChild(button);
				_buttons.push(button);
			}
		}
		
		public function set enabled(value:Boolean):void{
			 var i:int = -1, len:int = _buttons.length;
			 var btn:ToolToggleButton;
			 while(++i < len){
			 	btn = _buttons[i];
				btn.enabled = value;
			 }
		}
		
		protected function onClickButton(e:MouseEvent):void{
			_selectedButton = (ToolToggleButton)(e.currentTarget);
			updateState(_selectedButton);
			if(delegate){
				delegate.toolButtonsControlDidClickButton(this, _selectedButton);
			}
		}
		
		public function get selectedButton():ToolToggleButton{
			return _selectedButton;
		}
		
		public function set selectedButton(button:ToolToggleButton):void{
			updateState(button);
			_selectedButton = button;
		}
		
		protected function updateState(selectedBtn:ToolToggleButton):void{
			for each (var btn:ToolToggleButton in _buttons) 
			{
				if(btn == selectedBtn){
					btn.selected = true;
				}else{
					btn.selected = false;
				}
			}
		}
	}
}