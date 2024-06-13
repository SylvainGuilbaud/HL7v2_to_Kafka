Class HL7v2toKafka.msg.kafka Extends (msg.json, EnsLib.Kafka.Message)
{

/// Message topic
Property topic As %String(MAXLEN = 1000);

/// Message value as string
/// If the value exceeds maximum length of IRIS string, encode/decode the string from binaryValue using UTF8. 
Property value As %String(MAXLEN = "");

/// Optional message value key
Property key As %String(MAXLEN = 1000);

Method %ShowContents(pZenOutput As %Boolean = 0)
{
    do ##super()
    &html<
        <pre>http://localhost:8082/topics</pre>
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
