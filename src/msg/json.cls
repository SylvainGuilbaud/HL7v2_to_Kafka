Class msg.json Extends (Ens.Request, %JSON.Adaptor)
{

Method %GetContentType() As %String
{
    Quit "text/html"
}

/// This method is called by the Management Portal to display a message-specific content viewer.<br>
/// This method displays its content by writing out to the current device.
/// The content should match the type returned by the <method>%GetContentType</method> method.<br>
Method %ShowContents(pZenOutput As %Boolean = 0)
{
   do ..%JSONExportToString(.jsonExport)
    set formatter = ##class(%JSON.Formatter).%New()
    do formatter.FormatToString(jsonExport, .json)
    &html<
        <i style="color:green;">type: #($classname())#  id: #(..%Id())# </i>
        <pre>#(json)#</pre>
    >
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
