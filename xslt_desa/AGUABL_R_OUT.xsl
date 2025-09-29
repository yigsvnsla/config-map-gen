<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
				xmlns:mc="http://www.bolivariano.com/CashManagement/MensajesRecaudacionAgua"
				xmlns:ns15="http://www.bolivariano.com/mensaje/MensajeOTC"
				xmlns:ns7="http://www.bolivariano.com/mensaje/MensajeOTC"
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:java="java"
                exclude-result-prefixes="ns15 xsl java mc">
  <xsl:template match="/">
    <ns7:salidaEjecutarPago>
      <ns15:codigoError>
        <xsl:value-of select="/mc:MensajeSalidaReversar/codigoError"/>
      </ns15:codigoError>     
      <ns15:fechaDebito>
        <xsl:value-of select='java:format(java:text.SimpleDateFormat.new("yyyy-MM-dd&apos;T&apos;HH:mm:ss.SSS"), java:util.Date.new())'/>
       </ns15:fechaDebito>
    
      <xsl:if test="/mc:MensajeSalidaReversar/fechaProceso">
          <ns15:fechaPago>
            <xsl:value-of select="/mc:MensajeSalidaReversar/fechaProceso"/>
          </ns15:fechaPago>
      </xsl:if>
       <xsl:if test="/mc:MensajeSalidaReversar/fechaContable">
          <ns15:fechaPago>
            <xsl:value-of select="/mc:MensajeSalidaReversar/fechaContable"/>
          </ns15:fechaPago>
      </xsl:if>            
      <ns15:mensajeUsuario>
        <xsl:value-of select="/mc:MensajeSalidaReversar/mensajeUsuario"/>
      </ns15:mensajeUsuario>
      <!--<xsl:if test="/mc:MensajeSalidaReversar/secuenciaTransaccion">
        <ns15:referencia>
          <xsl:value-of select="/mc:MensajeSalidaReversar/codigoPago"/>
        </ns15:referencia>
      </xsl:if>-->
      <xsl:if test="/mc:MensajeSalidaReversar/secuenciaTransaccion">
        <ns15:referencia>
          <xsl:value-of select="/mc:MensajeSalidaReversar/secuenciaTransaccion"/>
        </ns15:referencia>
      </xsl:if>
    </ns7:salidaEjecutarPago>
  </xsl:template>
</xsl:stylesheet>
