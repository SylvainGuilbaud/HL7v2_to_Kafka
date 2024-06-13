Class HL7v2toKafka.msg.iris Extends (msg.json, Ens.Response)
{

Property NumRowsAffected As %Integer;

Storage Default
{
<Data name="irisDefaultData">
<Subscript>"iris"</Subscript>
<Value name="1">
<Value>NumRowsAffected</Value>
</Value>
</Data>
<DefaultData>irisDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
