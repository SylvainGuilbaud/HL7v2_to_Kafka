/// 
Class HL7v2toKafka.process.validate Extends Ens.BusinessProcessBPL
{

Storage Default
{
<Type>%Storage.Persistent</Type>
}

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='EnsLib.HL7.Message' response='HL7v2toKafka.msg.kafka' height='2000' width='2000' >
<context>
<property name='genderRequest' type='HTTP.msg.genderRequest' instantiate='0' />
<property name='genderResponse' type='HTTP.msg.genderResponse' instantiate='0' />
<property name='genderStored' type='HL7v2toKafka.msg.iris' instantiate='0' />
<property name='HL7Msg' type='EnsLib.HL7.Message' instantiate='0' />
</context>
<sequence xend='200' yend='1300' >
<transform name='get FirstName' class='HL7v2toKafka.transfo.getFirstName' source='request' target='context.genderRequest' xpos='200' ypos='250' />
<trace name='first name' value='context.genderRequest.firstName' xpos='200' ypos='350' />
<call name='check gender' target='get gender' async='0' xpos='200' ypos='450' >
<request type='HTTP.msg.genderRequest' >
<assign property="callrequest" value="context.genderRequest" action="set" languageOverride="" />
</request>
<response type='HTTP.msg.genderResponse' >
<assign property="context.genderResponse" value="callresponse" action="set" languageOverride="" />
</response>
</call>
<trace name='gender' value='context.genderResponse.gender' xpos='200' ypos='550' />
<if name='high probability' condition='context.genderResponse.probability&gt;0.9' xpos='200' ypos='650' xend='200' yend='1100' >
<true>
<trace name='high probability' value='"high probability"' xpos='470' ypos='800' />
<call name='store gender' target='store gender' async='0' xpos='470' ypos='900' >
<request type='HL7v2toKafka.msg.gender' >
<assign property="callrequest.firstname" value="context.genderRequest.firstName" action="set" languageOverride="" />
<assign property="callrequest.value" value="context.genderResponse.gender" action="set" languageOverride="" />
</request>
<response type='HL7v2toKafka.msg.iris' >
<assign property="context.genderStored" value="callresponse" action="set" languageOverride="" />
</response>
</call>
<transform name='set gender' class='HL7v2toKafka.transfo.setGender' source='request' target='context.HL7Msg' xpos='470' ypos='1000' />
</true>
<false>
<trace name='no issue' value='"no issue"' xpos='200' ypos='800' />
</false>
</if>
<call name='SIU Router' target='HL7 SIU router' async='1' xpos='200' ypos='1200' >
<request type='EnsLib.HL7.Message' >
<assign property="callrequest" value="context.HL7Msg" action="set" languageOverride="" />
</request>
<response type='Ens.Response' />
</call>
</sequence>
</process>
}

}
