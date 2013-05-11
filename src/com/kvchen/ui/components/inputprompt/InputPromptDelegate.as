package com.kvchen.ui.components.inputprompt
{
	public interface InputPromptDelegate
	{
		function inputPromptDidFinish(inputPrompt:InputPrompt, value:String):void;
		function inputPromptDidCancel(inputPrompt:InputPrompt):void;
	}
}