Class msg.patient Extends Ens.Request
{

/*
    {
            "start": to_timestamp(start_dt),
            "end": to_timestamp(end_dt),
            "type": appointment_type,
            "status": appointment_status.lower(),
            "description": description,
            "identifier": identifier,
"ipp": ipp,
            "sex": sex,
            "dob": dob,
            "first_name": first_name,
            "last_name": last_name,
}
*/
/// Description
Property start As %TimeStamp;

Property end As %TimeStamp;

Property lastname As %String(MAXLEN = 500);

Property firstname As %String(MAXLEN = 500);

Property sex As %String;

Storage Default
{
<Data name="patientDefaultData">
<Subscript>"patient"</Subscript>
<Value name="1">
<Value>start</Value>
</Value>
<Value name="2">
<Value>end</Value>
</Value>
<Value name="3">
<Value>lastname</Value>
</Value>
<Value name="4">
<Value>firstname</Value>
</Value>
<Value name="5">
<Value>sex</Value>
</Value>
</Data>
<DefaultData>patientDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
