Class HL7v2toKafka.transfo.setGender Extends Ens.DataTransformDTL [ DependsOn = EnsLib.HL7.Message ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='EnsLib.HL7.Message' targetClass='EnsLib.HL7.Message' sourceDocType='2.3.1:SIU_S12' targetDocType='2.3.1:SIU_S12' create='copy' language='objectscript' >
<assign value='source.{PIDgrp(1).PID:PatientName(1).givenname}' property='firstname' action='set' />
<trace value='"firstname:"_firstname' />
<sql>
<![CDATA[select top 1 value 
into :gender
from data.gender
where firstname = :firstname
order by ts desc]]></sql>
<trace value='"gender:"_gender' />
<assign value='..Lookup("gender",gender)' property='target.{PIDgrp(1).PID:Sex}' action='set' />
</transform>
}

}
