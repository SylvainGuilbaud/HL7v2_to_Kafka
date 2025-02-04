Class sample.transfo.HL7v2SIUToPatient Extends Ens.DataTransformDTL [ DependsOn = (EnsLib.HL7.Message, msg.patient) ]
{

Parameter GENERATEEMPTYSEGMENTS = 0;

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='EnsLib.HL7.Message' targetClass='msg.patient' sourceDocType='2.5.1:SIU_S12' create='new' language='objectscript' >
<assign value='source.{PIDgrp(1).PID:AdministrativeSex}' property='target.sex' action='set' />
<if condition='source.{PIDgrp(1).PID:PatientName(1).NameTypeCode} = "L"' >
<true>
<assign value='source.{PIDgrp(1).PID:PatientName(1).GivenName}' property='target.firstname' action='set' />
<assign value='source.{PIDgrp(1).PID:PatientName(1).FamilyName.Surname}' property='target.lastname' action='set' />
</true>
</if>
<assign value='source.{SCH:AppointmentTimingQuantity().StartDateTime}' property='target.start' action='set' />
<assign value='source.{SCH:AppointmentTimingQuantity().EndDateTime}' property='target.end' action='set' />
</transform>
}

}
