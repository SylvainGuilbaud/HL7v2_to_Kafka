Class data.kafka Extends (%Persistent, %XML.Adaptor, %JSON.Adaptor)
{

/// Message topic
Property topic As %String(MAXLEN = 1000);

/// Message value as string
/// If the value exceeds maximum length of IRIS string, encode/decode the string from binaryValue using UTF8. 
Property value As %String(MAXLEN = "");

/// Optional message value key
Property key As %String(MAXLEN = 1000);

Property ts As %TimeStamp [ InitialExpression = {$zdt($now(),3,,6)} ];

Storage Default
{
<Data name="kafkaDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>topic</Value>
</Value>
<Value name="3">
<Value>value</Value>
</Value>
<Value name="4">
<Value>key</Value>
</Value>
<Value name="5">
<Value>ts</Value>
</Value>
</Data>
<DataLocation>^data.kafkaD</DataLocation>
<DefaultData>kafkaDefaultData</DefaultData>
<IdLocation>^data.kafkaD</IdLocation>
<IndexLocation>^data.kafkaI</IndexLocation>
<StreamLocation>^data.kafkaS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
