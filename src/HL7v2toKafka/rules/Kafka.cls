/// 
Class HL7v2toKafka.rules.Kafka Extends Ens.Rule.Definition
{

Parameter RuleAssistClass = "EnsLib.MsgRouter.RuleAssist";

XData RuleDefinition [ XMLNamespace = "http://www.intersystems.com/rule" ]
{
<ruleDefinition alias="" context="EnsLib.MsgRouter.RoutingEngine" production="HL7v2toKafka.production">
<ruleSet name="" effectiveBegin="" effectiveEnd="">
<send transform="" target=",target IRIS SQL"></send>
</ruleSet>
</ruleDefinition>
}

}
