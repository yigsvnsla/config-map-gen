<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
                xmlns:bpws="http://schemas.xmlsoap.org/ws/2003/03/business-process/"
                xmlns:xp20="http://www.oracle.com/XSL/Transform/java/oracle.tip.pc.services.functions.Xpath20"
                xmlns:bpel="http://docs.oasis-open.org/wsbpel/2.0/process/executable"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xmlns:bpm="http://xmlns.oracle.com/bpmn20/extensions"
                xmlns:soap12="http://schemas.xmlsoap.org/wsdl/soap12/"
                xmlns:ns8="http://www.bolivariano.com/dominio/DatoAdicional"
                xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/"
                xmlns:ns1="http://www.bolivariano.com/CoreBB"
                xmlns:ns3="http://www.bolivariano.com/Cuenta"
                xmlns:mime="http://schemas.xmlsoap.org/wsdl/mime/"
                xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/"
                xmlns:ora="http://schemas.oracle.com/xpath/extension"
                xmlns:ns12="http://www.bolivariano.com/dominio/Convenio"
                xmlns:socket="http://www.oracle.com/XSL/Transform/java/oracle.tip.adapter.socket.ProtocolTranslator"
                xmlns:ns14="http://www.bolivariano.com/dominio/Recibo"
                xmlns:ns7="movr:Broadnet/types"
                xmlns:tns="http://www.bolivariano.com/ws/BroadnetRecarga"
                xmlns:ns19="http://www.bolivariano.com/dominio/RegionalArea"
                xmlns:ns18="http://www.bolivariano.com/dominio/ListaSeleccion"
                xmlns:ns11="http://www.bolivariano.com/dominio/Servicio"
                xmlns:ns0="http://www.bolivariano.com/MensajeBolivariano"
                xmlns:mhdr="http://www.oracle.com/XSL/Transform/java/oracle.tip.mediator.service.common.functions.MediatorExtnFunction"
                xmlns:oraext="http://www.oracle.com/XSL/Transform/java/oracle.tip.pc.services.functions.ExtFunc"
                xmlns:dvm="http://www.oracle.com/XSL/Transform/java/oracle.tip.dvm.LookupValue"
                xmlns:ns4="http://www.bolivariano.com/Recaudo"
                xmlns:hwf="http://xmlns.oracle.com/bpel/workflow/xpath"
                xmlns:ns16="http://www.bolivariano.com/dominio/TipoMatriculacion"
                xmlns:med="http://schemas.oracle.com/mediator/xpath"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:ids="http://xmlns.oracle.com/bpel/services/IdentityService/xpath"
                xmlns:ns17="http://www.bolivariano.com/dominio/FormaPago"
                xmlns:xdk="http://schemas.oracle.com/bpel/extension/xpath/function/xdk"
                xmlns:xref="http://www.oracle.com/XSL/Transform/java/oracle.tip.xref.xpath.XRefXPathFunctions"
                xmlns:ns10="http://www.bolivariano.com/dominio/TipoIdentificador"
                xmlns:ns9="http://www.bolivariano.com/ws/OTCService"
                xmlns:xsd="http://www.w3.org/2001/XMLSchema"
                xmlns:ns2="http://www.bolivariano.com/Producto"
                xmlns:ns13="http://www.bolivariano.com/dominio/Empresa"
                xmlns:ns5="http://www.bolivariano.com/Cliente"
                xmlns:ns15="http://www.bolivariano.com/mensaje/MensajeOTC"
                xmlns:ns6="http://www.bolivariano.com/Broadnet"
                xmlns:wbcm="http://www.bolivariano.com/MensajeBroadnet"
                xmlns:ldap="http://schemas.oracle.com/xpath/extension/ldap"
                exclude-result-prefixes="xsi xsl soap12 soap ns1 ns3 mime wsdl ns7 tns ns0 ns4 xsd ns2 ns5 ns6 wbcm ns8 ns12 ns14 ns19 ns18 ns11 ns16 ns17 ns10 ns9 ns13 ns15 bpws xp20 bpel bpm ora socket mhdr oraext dvm hwf med ids xdk xref ldap">
  <xsl:template match="/">
      <xsl:choose>
        <xsl:when test="/wbcm:MensajeSalidaReversarBroadnet/codigoError='00'">
          <xsl:call-template name="RespuestaOK"/>
        </xsl:when>
        <xsl:when test="/wbcm:MensajeSalidaReversarBroadnet/codigoError!='0'">
          <xsl:call-template name="RespuestaError"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="RespuestaError"/>
        </xsl:otherwise>
      </xsl:choose>
  </xsl:template>
  <xsl:template name="RespuestaError">
	<ns15:salidaEjecutarReverso>
      <ns15:codigoError>
        <xsl:value-of select="/wbcm:MensajeSalidaReversarBroadnet/codigoError"/>
      </ns15:codigoError>
      <ns15:mensajeUsuario>
        <xsl:value-of select="/wbcm:MensajeSalidaReversarBroadnet/mensajeUsuario"/>
      </ns15:mensajeUsuario>
       <ns15:mensajeSistema>
        <xsl:value-of select="/wbcm:MensajeSalidaReversarBroadnet/mensajeSistema"/>
      </ns15:mensajeSistema>
	</ns15:salidaEjecutarReverso>
  </xsl:template>
  <xsl:template name="RespuestaOK">
	<ns15:salidaEjecutarReverso>
      <ns15:codigoError>0</ns15:codigoError>
      <ns15:fechaDebito>
        <xsl:value-of select="/wbcm:MensajeSalidaReversarBroadnet/informacionBroadnet/fechaEmision"/>
      </ns15:fechaDebito>
      <ns15:fechaPago>
        <xsl:value-of select="/wbcm:MensajeSalidaReversarBroadnet/informacionBroadnet/fechaContable"/>
      </ns15:fechaPago>
	<ns15:mensajeUsuario>TRANSACCION OK</ns15:mensajeUsuario>
	<ns15:mensajeSistema>TRANSACCION OK</ns15:mensajeSistema>
      <ns15:referencia>
        <xsl:value-of select="/wbcm:MensajeSalidaReversarBroadnet/informacionCore/secuencial"/>
      </ns15:referencia>
	</ns15:salidaEjecutarReverso>
  </xsl:template>
</xsl:stylesheet>
