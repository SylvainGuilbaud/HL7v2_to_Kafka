Class HL7v2toKafka.transfo.SIU Extends Ens.DataTransformDTL [ DependsOn = (EnsLib.HL7.Message, HL7v2toKafka.msg.kafka) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='EnsLib.HL7.Message' targetClass='HL7v2toKafka.msg.kafka' sourceDocType='2.3.1:SIU_S12' create='new' language='objectscript' >
<assign value='source.{SCH:EventReason}' property='target.topic' action='set' />
<assign value='target.topic _ " FROM "  _ source.{MSH:SendingApplication}' property='target.topic' action='set' />
<assign value='target.topic _ " "  _ source.{MSH:SendingFacility}' property='target.topic' action='set' />
<assign value='target.topic _ " TO "  _ source.{MSH:ReceivingApplication}' property='target.topic' action='set' />
<assign value='target.topic _ "  "  _ source.{MSH:ReceivingFacility}' property='target.topic' action='set' />
<assign value='..ReplaceStr(target.topic," ","-")' property='target.topic' action='set' />
<assign value='source.{PIDgrp(1).PID:PatientIdentifierList()}' property='target.key' action='set' />
<assign value='source.{SCH:AppointmentTimingQuantity().startdatetime.timeofanevent}' property='target.value' action='set' />
<assign value='target.value _ " PATIENT: " _ source.{PIDgrp(1).PID:PatientName(1)}' property='target.value' action='set' />
<assign value='target.value _ source.{PIDgrp(1).PID:Sex}' property='target.value' action='set' />
<foreach property='source.{PIDgrp(1).OBX()}' key='k1' >
<assign value='target.value _ "  "_source.{PIDgrp(1).OBX(k1):ObservationIdentifier}' property='target.value' action='set' />
<assign value='target.value _ " " _ source.{PIDgrp(1).OBX(k1):ObservationValue()}' property='target.value' action='set' />
<assign value='target.value _ source.{PIDgrp(1).OBX(k1):Units}' property='target.value' action='set' />
</foreach>
</transform>
}

}
