Class HL7v2toKafka.transfo.getFirstName Extends Ens.DataTransformDTL [ DependsOn = (EnsLib.HL7.Message, HTTP.msg.genderRequest) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='EnsLib.HL7.Message' targetClass='HTTP.msg.genderRequest' sourceDocType='2.3.1:SIU_S12' create='new' language='objectscript' >
<assign value='source.{PIDgrp(1).PID:PatientName().givenname}' property='target.firstName' action='set' />
</transform>
}

}
