Class HL7v2toKafka.production Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="kafka.prod" TestingEnabled="true" LogGeneralTraceEvents="true">
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
</Production>
}

}
