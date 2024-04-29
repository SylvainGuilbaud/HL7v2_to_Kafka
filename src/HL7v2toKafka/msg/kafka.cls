Class HL7v2toKafka.msg.kafka Extends EnsLib.Kafka.Message
{

/// Message topic
Property topic As %String(MAXLEN = 1000);

/// Message value as string
/// If the value exceeds maximum length of IRIS string, encode/decode the string from binaryValue using UTF8. 
Property value As %String(MAXLEN = "");

/// Optional message value key
Property key As %String(MAXLEN = 1000);

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
<Data name="kafkaDefaultData">
<Subscript>"kafka"</Subscript>
<Value name="1">
<Value>topic</Value>
</Value>
<Value name="2">
<Value>value</Value>
</Value>
<Value name="3">
<Value>key</Value>
</Value>
<Value name="4">
<Value>binaryValue</Value>
</Value>
</Data>
<DefaultData>kafkaDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
