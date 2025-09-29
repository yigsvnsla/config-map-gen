<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsd1="http://www.bolivariano.com/MensajeCTE"
                xmlns:ns15="http://www.bolivariano.com/mensaje/MensajeOTC"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="xsd1 ns15 xsl">
  <xsl:template match="/">
    <xsl:choose>
      <xsl:when test="/xsd1:MensajeSalidaConsultarCEP/codigoError='T0000'">
        <ns15:salidaConsultarDeuda>
          <ns15:codigoError>0</ns15:codigoError>
          <ns15:datosAdicionales>
            <ns15:datoAdicional>
              <codigo>tramite</codigo>
              <etiqueta>Tramite</etiqueta>
              <valor>
              <xsl:value-of select="/xsd1:MensajeSalidaConsultarCEP/cte/tramite"/>
              </valor>
              <visible>true</visible>
            </ns15:datoAdicional>
          </ns15:datosAdicionales>
          <ns15:mensajeUsuario>Transaccion Exitosa</ns15:mensajeUsuario>
          <ns15:formaPago>TOTAL</ns15:formaPago>
    			<ns15:formaPagoRecibos>UNICO_CRONOLOGICO</ns15:formaPagoRecibos>         
          <ns15:montoTotal>
            <xsl:value-of select="/xsd1:MensajeSalidaConsultarCEP/cte/valorTotalCancelar"/>
          </ns15:montoTotal>
          <ns15:nombreCliente>
            <xsl:value-of select="/xsd1:MensajeSalidaConsultarCEP/cte/nombre"/>
          </ns15:nombreCliente>
        </ns15:salidaConsultarDeuda>
      </xsl:when>
      <xsl:when test="/xsd1:MensajeSalidaConsultarCEP/codigoError!='T0000'">
        <ns15:salidaConsultarDeuda>
          <ns15:codigoError>
            <xsl:value-of select="/xsd1:MensajeSalidaConsultarCEP/codigoError"/>
          </ns15:codigoError>
          <ns15:mensajeUsuario>
            <xsl:value-of select="/xsd1:MensajeSalidaConsultarCEP/mensajeUsuario"/>
          </ns15:mensajeUsuario>
        </ns15:salidaConsultarDeuda>
      </xsl:when>
      <xsl:otherwise>
        <ns15:salidaConsultarDeuda>
          <ns15:codigoError>
            <xsl:value-of select="/xsd1:MensajeSalidaConsultarCEP/codigoError"/>
          </ns15:codigoError>
          <ns15:mensajeUsuario>
            <xsl:value-of select="/xsd1:MensajeSalidaConsultarCEP/mensajeUsuario"/>
          </ns15:mensajeUsuario>
        </ns15:salidaConsultarDeuda>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
