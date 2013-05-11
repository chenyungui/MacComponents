package com.kvchen.ui.components.inputprompt
{
	import com.kvchen.ui.components.button.Button;
	import com.kvchen.ui.components.inputfield.InputField;
	import com.kvchen.ui.components.label.Label;
	import com.kvchen.ui.components.panel.PromptPanel;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextFormatAlign;
	import flash.ui.Keyboard;
	
	public class InputPrompt extends PromptPanel
	{
		public var delegate:InputPromptDelegate;
		
		protected var _messageLabel:Label;
		protected var _inputField:InputField;
		protected var _okButton:Button;
		protected var _cancelButton:Button;
		
		public function InputPrompt(title:String, message:String, initialValue:String, stage:Stage)
		{
			super(220, 23, 110, title, stage);
			
			var container:Sprite = new Sprite();
			
			_messageLabel = new Label(message, 180, TextFormatAlign.LEFT);
			_messageLabel.x = 20;
			_messageLabel.y = 10;
			
			_inputField = new InputField(initialValue, 180);
			_inputField.x = _messageLabel.x;
			_inputField.y = _messageLabel.y + _messageLabel.height + 5;
			_inputField.selectAllText();
			
			_cancelButton = new Button("Cancel", 85, false, handleClickCancelBtn);
			_cancelButton.x = _messageLabel.x;
			_cancelButton.y = _inputField.y + _inputField.height + 10;
			
			_okButton = new Button("OK", 85, true, handleClickOKBtn);
			_okButton.x = _cancelButton.x + _cancelButton.width + 10;
			_okButton.y = _cancelButton.y;

			container.addChild(_messageLabel);
			container.addChild(_inputField);
			container.addChild(_okButton);
			container.addChild(_cancelButton);
			
			this.content = container;
			
			_stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		protected function onKeyUp(e:KeyboardEvent):void{
			
			switch(e.keyCode){
				case Keyboard.ENTER:
					handleClickOKBtn(null);
					break;
			}
		}
		
		protected function handleClickOKBtn(e:MouseEvent):void{
			
			if(delegate != null){
				delegate.inputPromptDidFinish(this, _inputField.text);
			}
			hide();
		}
		
		protected function handleClickCancelBtn(e:MouseEvent):void{

			if(delegate != null){
				delegate.inputPromptDidCancel(this);
			}
			hide();
		}
		
		override public function hide():void{
			_stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			super.hide();
		}
	}
}