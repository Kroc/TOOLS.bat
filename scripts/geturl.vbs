Dim strURL, strRegex
strURL   = WScript.Arguments(0)
strRegex = WScript.Arguments(1)

Dim objHTTP
Set objHTTP = CreateObject ("msxml2.xmlhttp.3.0")

'//Fetch the HTML of the URL
objHTTP.Open "GET", strURL, false: objHTTP.Send
If objHTTP.Status = 200 Then
	'//Search the HTML for the hyperlink matching the regex:
	With New RegExp
		.Pattern = strRegex
		If .Test (objHTTP.ResponseText) Then
			With .Execute (objHTTP.ResponseText)
				strURL = .Item(0)
			End With
		Else
			WScript.Quit 1
		End If
	End With
End If
If objHTTP.Status <> 200 Then WScript.Quit objHTTP.Status
Set objHTTP = Nothing

WScript.Echo strURL
WScript.Quit 0