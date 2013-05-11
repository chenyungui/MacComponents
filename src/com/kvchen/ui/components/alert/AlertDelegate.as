package com.kvchen.ui.components.alert
{
	public interface AlertDelegate
	{
		function alertDidClickOK(alert:Alert):void;
		function alertDidClickCancel(alert:Alert):void;
	}
}