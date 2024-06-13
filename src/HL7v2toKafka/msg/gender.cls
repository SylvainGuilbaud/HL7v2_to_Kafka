Class HL7v2toKafka.msg.gender Extends (msg.json, Ens.Request)
{

Property firstname As %String(MAXLEN = 500);

Property value As %String;

Storage Default
{
<Data name="genderDefaultData">
<Subscript>"gender"</Subscript>
<Value name="1">
<Value>firstname</Value>
</Value>
<Value name="2">
<Value>value</Value>
</Value>
</Data>
<DefaultData>genderDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
