/// 
Class HL7v2toKafka.rules.Kafka Extends Ens.Rule.Definition
{

Parameter RuleAssistClass = "EnsLib.MsgRouter.RuleAssist";

XData RuleDefinition [ XMLNamespace = "http://www.intersystems.com/rule" ]
{
<ruleDefinition alias="" context="EnsLib.MsgRouter.RoutingEngine" production="HL7v2toKafka.production">
<ruleSet name="" effectiveBegin="" effectiveEnd="">
<rule name="TrakCare" disabled="false">
<constraint name="source" value="source Kafka Consumer TOPIC APT-FROM-TRAKCARE"></constraint>
<constraint name="msgClass" value="EnsLib.Kafka.Message"></constraint>
<when condition="Document.topic[&quot;TRAKCARE&quot;" comment="">
<send transform="" target="target IRIS TrakCare SQL"></send>
<return></return>
</when>
</rule>
<rule name="DxPlanning" disabled="false">
<constraint name="source" value="source Kafka Consumer TOPIC APT-FROM-DXPLANNING"></constraint>
<constraint name="msgClass" value="EnsLib.Kafka.Message"></constraint>
<when condition="Document.topic[&quot;DXPLANNING&quot;" comment="">
<send transform="" target=",target IRIS DxCare SQL"></send>
<return></return>
</when>
</rule>
<rule name="Surg" disabled="false">
<constraint name="source" value="source Kafka Consumer TOPIC SURG"></constraint>
<constraint name="msgClass" value="EnsLib.Kafka.Message"></constraint>
<when condition="Document.topic[&quot;SURG&quot;" comment="">
<send transform="" target=",target IRIS Surg SQL"></send>
<return></return>
</when>
</rule>
</ruleSet>
</ruleDefinition>
}

}
