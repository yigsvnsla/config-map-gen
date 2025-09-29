<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:mmn="http://www.bolivariano.com/MensajeCTE"
                xmlns:ns9="http://www.bolivariano.com/mensaje/MensajeOTC"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:java="java" exclude-result-prefixes="java xsl ns9 mmn">
  <xsl:template match="/">
    <xsl:choose>
      <xsl:when test="/mmn:MensajeSalidaPagar/codigoError='0'">
        <ns9:salidaEjecutarPago>
          <ns9:codigoError>0</ns9:codigoError>
          <ns9:fechaDebito>
            <xsl:value-of select='java:format(java:text.SimpleDateFormat.new("yyyy-MM-dd&apos;T&apos;HH:mm:ss"), java:util.Date.new())'/>
          </ns9:fechaDebito>
          <ns9:fechaPago>
            <xsl:value-of select="/mmn:MensajeSalidaPagar/cte/fechaContable"/>
          </ns9:fechaPago>
          <ns9:mensajeUsuario>Transaccion ok</ns9:mensajeUsuario>
          <ns9:referencia>
            <xsl:value-of select="/mmn:MensajeSalidaPagar/informacionCore/secuencial"/>
          </ns9:referencia>
          <ns9:datosAdicionales>
   <ns9:datoAdicional>
      <codigo>horario</codigo>
      <valor>
        <xsl:value-of select="/mmn:MensajeSalidaPagar/cte/horario"/>
      </valor>
    </ns9:datoAdicional>  
    </ns9:datosAdicionales>  
        </ns9:salidaEjecutarPago>
      </xsl:when>
      <xsl:otherwise>
        <ns9:salidaEjecutarPago>
          <ns9:codigoError>
            <xsl:value-of select="/mmn:MensajeSalidaPagar/codigoError"/>
          </ns9:codigoError>
          <ns9:mensajeUsuario>
            <xsl:value-of select="/mmn:MensajeSalidaPagar/mensajeUsuario"/>
          </ns9:mensajeUsuario>
        </ns9:salidaEjecutarPago>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
