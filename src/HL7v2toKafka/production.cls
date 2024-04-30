Class HL7v2toKafka.production Extends Ens.Production
{

ClassMethod OnStart(pTimeStarted As %String) As %Status
{
  do ##class(%File).CopyDir("/data/HL7/test","/data/HL7/in",1)
  merge ^%SYS("sql","ODBCCONNECTION") = ^SQLGateway
	return $$$OK
}

XData ProductionDefinition
{
<Production Name="HL7v2toKafka.production" TestingEnabled="true" LogGeneralTraceEvents="true">
  <Description></Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="source HL7 SIU FILE" Category="HL7" ClassName="EnsLib.HL7.Service.FileService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="MessageSchemaCategory">2.3.1</Setting>
    <Setting Target="Adapter" Name="FileSpec">*.hl7</Setting>
    <Setting Target="Host" Name="TargetConfigNames">HL7 SIU router</Setting>
  </Item>
  <Item Name="HL7 SIU router" Category="" ClassName="EnsLib.HL7.MsgRouter.RoutingEngine" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="BusinessRuleName">HL7v2toKafka.HL7router.SIU</Setting>
    <Setting Target="Host" Name="RuleLogging">a</Setting>
  </Item>
  <Item Name="source HL7 SIU TCP" Category="" ClassName="EnsLib.HL7.Service.TCPService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="MessageSchemaCategory">2.3.1</Setting>
    <Setting Target="Host" Name="TargetConfigNames">HL7 SIU router</Setting>
    <Setting Target="Adapter" Name="Port">19000</Setting>
    <Setting Target="Host" Name="ArchiveIO">1</Setting>
  </Item>
  <Item Name="target HL7 SIU TCP" Category="" ClassName="EnsLib.HL7.Operation.TCPOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="IPAddress">localhost</Setting>
    <Setting Target="Adapter" Name="Port">19000</Setting>
    <Setting Target="Host" Name="ArchiveIO">1</Setting>
  </Item>
  <Item Name="source HL7 SIU HTTP" Category="" ClassName="EnsLib.HL7.Service.HTTPService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="MessageSchemaCategory">2.3.1</Setting>
    <Setting Target="Host" Name="TargetConfigNames">HL7 SIU router</Setting>
    <Setting Target="Adapter" Name="Port">19001</Setting>
    <Setting Target="Host" Name="ArchiveIO">1</Setting>
  </Item>
  <Item Name="target HL7 SIU HTTP" Category="" ClassName="EnsLib.HL7.Operation.HTTPOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="HTTPServer">localhost</Setting>
    <Setting Target="Adapter" Name="HTTPPort">19001</Setting>
    <Setting Target="Host" Name="ArchiveIO">1</Setting>
  </Item>
  <Item Name="Kafka router" Category="" ClassName="EnsLib.MsgRouter.RoutingEngine" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="BusinessRuleName">HL7v2toKafka.rules.Kafka</Setting>
    <Setting Target="Host" Name="RuleLogging">a</Setting>
  </Item>
  <Item Name="target IRIS SQL" Category="" ClassName="EnsLib.SQL.Operation.GenericOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="InputParameters">*topic,*key,*value</Setting>
    <Setting Target="Host" Name="Query">insert into data.kafka 
(topic,key,value) 
values 
(?,?,?)</Setting>
    <Setting Target="Host" Name="RequestClass">EnsLib.Kafka.Message</Setting>
    <Setting Target="Host" Name="ResponseClass">HL7v2toKafka.msg.iris</Setting>
    <Setting Target="Adapter" Name="DSN">iris</Setting>
    <Setting Target="Adapter" Name="JGService">JDBC Gateway</Setting>
    <Setting Target="Host" Name="ArchiveIO">1</Setting>
    <Setting Target="Adapter" Name="JDBCDriver">com.intersystems.jdbc.IRISDriver</Setting>
  </Item>
  <Item Name="source Kafka Consumer TOPIC APT-FROM-DXPLANNING" Category="" ClassName="EnsLib.Kafka.Service" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="TargetConfigNames">Kafka router</Setting>
    <Setting Target="Adapter" Name="Topic">APT-FROM-DXPLANNING-ENVOIE-TO-PTAH--RECEPTION</Setting>
    <Setting Target="Adapter" Name="Servers">host.docker.internal:9092</Setting>
    <Setting Target="Host" Name="ArchiveIO">1</Setting>
  </Item>
  <Item Name="source Kafka Consumer TOPIC APT-FROM-TRAKCARE" Category="" ClassName="EnsLib.Kafka.Service" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="TargetConfigNames">Kafka router</Setting>
    <Setting Target="Adapter" Name="Topic">APT-FROM-TRAKCARE-ENVOIE-TO-PTAH--RECEPTION</Setting>
    <Setting Target="Adapter" Name="Servers">host.docker.internal:9092</Setting>
    <Setting Target="Host" Name="ArchiveIO">1</Setting>
  </Item>
  <Item Name="source Kafka Consumer TOPIC SURG" Category="" ClassName="EnsLib.Kafka.Service" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="TargetConfigNames">Kafka router</Setting>
    <Setting Target="Adapter" Name="Topic">SURG-FROM-SendingApp-SendingFac-TO-ReceivingApp--ReceivingFac</Setting>
    <Setting Target="Adapter" Name="Servers">host.docker.internal:9092</Setting>
    <Setting Target="Host" Name="ArchiveIO">1</Setting>
  </Item>
  <Item Name="target Kafka Producer" Category="" ClassName="EnsLib.Kafka.Operation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="ArchiveIO">1</Setting>
    <Setting Target="Adapter" Name="Servers">host.docker.internal:9092</Setting>
  </Item>
  <Item Name="JDBC Gateway" Category="" ClassName="EnsLib.JavaGateway.Service" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
  </Item>
</Production>
}

}
