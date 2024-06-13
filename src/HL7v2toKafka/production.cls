Class HL7v2toKafka.production Extends Ens.Production
{

ClassMethod OnStart(pTimeStarted As %String) As %Status
{
  do ##class(%File).CopyDir("/data/HL7/test","/data/HL7/in",1)
  do ##class(%File).CopyDir("/data/HL7/test","/data/HL7/validate",1)
  do ##class(Ens.Util.Statistics).EnableStatsForProduction()

	return $$$OK
}

XData ProductionDefinition
{
<Production Name="HL7v2toKafka.production" TestingEnabled="true" LogGeneralTraceEvents="true">
  <Description>This demo transforms HL7v2 SIU messages to Kafka</Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="source HL7 SIU FILE" Category="HL7" ClassName="EnsLib.HL7.Service.FileService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="FileSpec">*.hl7</Setting>
    <Setting Target="Host" Name="TargetConfigNames">HL7 SIU router</Setting>
  </Item>
  <Item Name="HL7 SIU router" Category="HL7" ClassName="EnsLib.HL7.MsgRouter.RoutingEngine" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="BusinessRuleName">HL7v2toKafka.HL7router.SIU</Setting>
  </Item>
  <Item Name="source HL7 SIU TCP" Category="HL7" ClassName="EnsLib.HL7.Service.TCPService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="TargetConfigNames">HL7 SIU router</Setting>
    <Setting Target="Host" Name="LocalFacilityApplication">ISC:IRISHL7</Setting>
  </Item>
  <Item Name="target HL7 SIU TCP" Category="HL7" ClassName="EnsLib.HL7.Operation.TCPOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
  </Item>
  <Item Name="source HL7 SIU HTTP" Category="HL7" ClassName="EnsLib.HL7.Service.HTTPService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="TargetConfigNames">HL7 SIU router</Setting>
    <Setting Target="Host" Name="LocalFacilityApplication">ISC:IRISHL7</Setting>
  </Item>
  <Item Name="target HL7 SIU HTTP" Category="HL7" ClassName="EnsLib.HL7.Operation.HTTPOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
  </Item>
  <Item Name="Kafka router" Category="Kafka" ClassName="EnsLib.MsgRouter.RoutingEngine" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="BusinessRuleName">HL7v2toKafka.rules.Kafka</Setting>
  </Item>
  <Item Name="source Kafka Consumer TOPIC APT-FROM-DXPLANNING" Category="Kafka" ClassName="EnsLib.Kafka.Service" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
  </Item>
  <Item Name="source Kafka Consumer TOPIC APT-FROM-TRAKCARE" Category="Kafka" ClassName="EnsLib.Kafka.Service" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
  </Item>
  <Item Name="source Kafka Consumer TOPIC SURG" Category="Kafka" ClassName="EnsLib.Kafka.Service" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
  </Item>
  <Item Name="target Kafka Producer" Category="Kafka,HL7" ClassName="EnsLib.Kafka.Operation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
  </Item>
  <Item Name="JDBC Gateway" Category="SQL" ClassName="EnsLib.JavaGateway.Service" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
  </Item>
  <Item Name="Ens.ProductionMonitorService" Category="" ClassName="Ens.ProductionMonitorService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="target IRIS TrakCare SQL" Category="SQL,Kafka" ClassName="EnsLib.SQL.Operation.GenericOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="StayConnected">5</Setting>
  </Item>
  <Item Name="target IRIS DxCare SQL" Category="SQL,Kafka" ClassName="EnsLib.SQL.Operation.GenericOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="StayConnected">5</Setting>
  </Item>
  <Item Name="target IRIS Surg SQL" Category="SQL,Kafka" ClassName="EnsLib.SQL.Operation.GenericOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="StayConnected">5</Setting>
  </Item>
  <Item Name="get gender" Category="transfo + traitements" ClassName="HTTP.operation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="HTTPServer">api.genderize.io</Setting>
    <Setting Target="Adapter" Name="SSLConfig">API</Setting>
    <Setting Target="Adapter" Name="URL">/</Setting>
    <Setting Target="Adapter" Name="SSLCheckServerIdentity">0</Setting>
    <Setting Target="Host" Name="ArchiveIO">1</Setting>
  </Item>
  <Item Name="validate" Category="HL7,transfo + traitements" ClassName="HL7v2toKafka.process.validate" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
  </Item>
  <Item Name="store gender" Category="SQL,Kafka" ClassName="EnsLib.SQL.Operation.GenericOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="RequestClass">HL7v2toKafka.msg.gender</Setting>
    <Setting Target="Host" Name="ResponseClass">HL7v2toKafka.msg.iris</Setting>
    <Setting Target="Adapter" Name="StayConnected">5</Setting>
  </Item>
  <Item Name="source HL7 SIU FILE validate" Category="HL7" ClassName="EnsLib.HL7.Service.FileService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="FileSpec">*.hl7</Setting>
    <Setting Target="Host" Name="TargetConfigNames">validate</Setting>
  </Item>
  <Item Name="Ens.Activity.Operation.Local" Category="" ClassName="Ens.Activity.Operation.Local" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
</Production>
}

}
