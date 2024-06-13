Class data.gender Extends (%Persistent, %XML.Adaptor, %JSON.Adaptor)
{

Property firstname As %String(MAXLEN = 500);

Property value As %String;

Property ts As %TimeStamp [ InitialExpression = {$zdt($h,3)} ];

Storage Default
{
<Data name="genderDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>firstname</Value>
</Value>
<Value name="3">
<Value>value</Value>
</Value>
<Value name="4">
<Value>ts</Value>
</Value>
</Data>
<DataLocation>^data.genderD</DataLocation>
<DefaultData>genderDefaultData</DefaultData>
<IdLocation>^data.genderD</IdLocation>
<IndexLocation>^data.genderI</IndexLocation>
<StreamLocation>^data.genderS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
