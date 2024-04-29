Class HL7v2toKafka.production Extends Ens.Production
{

ClassMethod OnStart(pTimeStarted As %String) As %Status
{
  do ##class(%File).CopyDir("/data/HL7/test","/data/HL7/in",1)
	return $$$OK
}

XData ProductionDefinition
{
<Production Name="HL7v2toKafka.production" TestingEnabled="true" LogGeneralTraceEvents="true">
  <Description></Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="Kafka out" Category="" ClassName="EnsLib.Kafka.Operation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="ArchiveIO">1</Setting>
    <Setting Target="Adapter" Name="Servers">host.docker.internal:9092</Setting>
  </Item>
  <Item Name="SIU FILE" Category="HL7" ClassName="EnsLib.HL7.Service.FileService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="MessageSchemaCategory">2.3.1</Setting>
    <Setting Target="Adapter" Name="FilePath">/data/HL7/in</Setting>
    <Setting Target="Adapter" Name="ArchivePath">/data/HL7/archive</Setting>
    <Setting Target="Adapter" Name="FileSpec">*.hl7</Setting>
    <Setting Target="Host" Name="TargetConfigNames">SIU</Setting>
    <Setting Target="Adapter" Name="WorkPath">/data/HL7/work</Setting>
  </Item>
  <Item Name="SIU" Category="" ClassName="EnsLib.HL7.MsgRouter.RoutingEngine" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="BusinessRuleName">HL7v2toKafka.HL7router.SIU</Setting>
  </Item>
  <Item Name="SIU TCP" Category="" ClassName="EnsLib.HL7.Service.TCPService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="MessageSchemaCategory">2.3.1</Setting>
    <Setting Target="Host" Name="TargetConfigNames">SIU</Setting>
    <Setting Target="Adapter" Name="Port">19000</Setting>
  </Item>
  <Item Name="SIU TCP OUT" Category="" ClassName="EnsLib.HL7.Operation.TCPOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="IPAddress">127.0.0.1</Setting>
    <Setting Target="Adapter" Name="Port">19000</Setting>
  </Item>
  <Item Name="SIU HTTP" Category="" ClassName="EnsLib.HL7.Service.HTTPService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="MessageSchemaCategory">2.3.1</Setting>
    <Setting Target="Host" Name="TargetConfigNames">SIU</Setting>
    <Setting Target="Adapter" Name="Port">19001</Setting>
  </Item>
  <Item Name="SIU HTTP OUT" Category="" ClassName="EnsLib.HL7.Operation.HTTPOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="HTTPServer">host.docker.internal</Setting>
    <Setting Target="Adapter" Name="HTTPPort">19001</Setting>
  </Item>
  <Item Name="Kafka" Category="" ClassName="EnsLib.MsgRouter.RoutingEngine" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="BusinessRuleName">HL7v2toKafka.rules.Kafka</Setting>
  </Item>
  <Item Name="IRIS SQL" Category="" ClassName="EnsLib.SQL.Operation.GenericOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="InputParameters">*topic,*key,*value</Setting>
    <Setting Target="Host" Name="Query">insert into data.kafka 
(topic,key,value) 
values 
(?,?,?)</Setting>
    <Setting Target="Host" Name="RequestClass">EnsLib.Kafka.Message</Setting>
    <Setting Target="Host" Name="ResponseClass">HL7v2toKafka.msg.iris</Setting>
    <Setting Target="Adapter" Name="DSN">iris</Setting>
    <Setting Target="Adapter" Name="JGService">JG</Setting>
    <Setting Target="Host" Name="ArchiveIO">1</Setting>
    <Setting Target="Adapter" Name="JDBCDriver">com.intersystems.jdbc.IRISDriver</Setting>
  </Item>
  <Item Name="JG" Category="" ClassName="EnsLib.JavaGateway.Service" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Kafka TOPIC APT-FROM-DXPLANNING" Category="" ClassName="EnsLib.Kafka.Service" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="TargetConfigNames">Kafka</Setting>
    <Setting Target="Adapter" Name="Topic">APT-FROM-DXPLANNING-ENVOIE-TO-PTAH--RECEPTION</Setting>
    <Setting Target="Adapter" Name="Servers">host.docker.internal:9092</Setting>
    <Setting Target="Host" Name="ArchiveIO">1</Setting>
  </Item>
  <Item Name="Kafka TOPIC APT-FROM-TRAKCARE" Category="" ClassName="EnsLib.Kafka.Service" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="TargetConfigNames">Kafka</Setting>
    <Setting Target="Adapter" Name="Topic">APT-FROM-TRAKCARE-ENVOIE-TO-PTAH--RECEPTION</Setting>
    <Setting Target="Adapter" Name="Servers">host.docker.internal:9092</Setting>
    <Setting Target="Host" Name="ArchiveIO">1</Setting>
  </Item>
  <Item Name="Kafka TOPIC SURG" Category="" ClassName="EnsLib.Kafka.Service" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="TargetConfigNames">Kafka</Setting>
    <Setting Target="Adapter" Name="Topic">SURG-FROM-SendingApp-SendingFac-TO-ReceivingApp--ReceivingFac</Setting>
    <Setting Target="Adapter" Name="Servers">host.docker.internal:9092</Setting>
    <Setting Target="Host" Name="ArchiveIO">1</Setting>
  </Item>
</Production>
}

}
