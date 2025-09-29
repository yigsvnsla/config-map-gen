<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsd1="http://www.bolivariano.com/MensajeCTE"
                xmlns:ns15="http://www.bolivariano.com/mensaje/MensajeOTC"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="xsd1 ns15 xsl">
  <xsl:template match="/">
    <xsl:choose>
      <xsl:when test="/xsd1:MensajeSalidaConsultarCitacionesPendientes/codigoError='T0000'">
        <ns15:salidaConsultarDeuda>
          <ns15:codigoError>0</ns15:codigoError>
          <ns15:datosAdicionales>
            <ns15:datoAdicional>
              <codigo>suministro</codigo>
              <valor>
                <xsl:value-of select="/xsd1:MensajeSalidaConsultarCitacionesPendientes/cte/suministro"/>
              </valor>
              <visible>false</visible>
            </ns15:datoAdicional>
            <ns15:datoAdicional>
              <codigo>valorComision</codigo>
              <valor>
              <xsl:choose>
					     	<xsl:when test="/xsd1:MensajeSalidaConsultarCitacionesPendientes/cte/valorComision > 0 ">
						    <xsl:variable name="nvalorTotalComision" select="string(/xsd1:MensajeSalidaConsultarCitacionesPendientes/cte/valorComision)"/>
					 	    <xsl:value-of select="substring($nvalorTotalComision, 1, string-length(substring-before($nvalorTotalComision, '.')) + 3)"/>
					    	</xsl:when>
					    	<xsl:otherwise>
						   	<xsl:text disable-output-escaping="no">0.0</xsl:text>
					    	</xsl:otherwise>
					</xsl:choose>		

              </valor>
              <visible>false</visible>
            </ns15:datoAdicional>
            <ns15:datoAdicional>
              <codigo>numeroCitaciones</codigo>
              <etiqueta>Citaciones</etiqueta>
              <valor>
                <xsl:value-of select="/xsd1:MensajeSalidaConsultarCitacionesPendientes/cte/numeroCitaciones"/>
              </valor>
              <visible>true</visible>
            </ns15:datoAdicional>
            <ns15:datoAdicional>
              <codigo>valorMulta</codigo>
              <etiqueta>Valor Multa</etiqueta>
              <valor>
                <xsl:value-of select="/xsd1:MensajeSalidaConsultarCitacionesPendientes/cte/valorMulta"/>
              </valor>
              <visible>true</visible>
            </ns15:datoAdicional>
            <ns15:datoAdicional>
              <codigo>valorCitacion</codigo>
              <etiqueta>Valor Citacion</etiqueta>
              <valor>
                <xsl:value-of select="/xsd1:MensajeSalidaConsultarCitacionesPendientes/cte/valorCitacion"/>
              </valor>
              <visible>true</visible>
            </ns15:datoAdicional>
          </ns15:datosAdicionales>
          <ns15:mensajeUsuario>Transaccion Exitosa</ns15:mensajeUsuario>
          <ns15:formaPago>TOTAL</ns15:formaPago>
    			<ns15:formaPagoRecibos>UNICO_CRONOLOGICO</ns15:formaPagoRecibos>         

          <ns15:montoTotal>
            <xsl:value-of select="/xsd1:MensajeSalidaConsultarCitacionesPendientes/cte/valorTotalCancelar"/>
          </ns15:montoTotal>
          <ns15:nombreCliente>
            <xsl:value-of select="/xsd1:MensajeSalidaConsultarCitacionesPendientes/cte/nombre"/>
          </ns15:nombreCliente>
        </ns15:salidaConsultarDeuda>
      </xsl:when>
      <xsl:when test="/xsd1:MensajeSalidaConsultarCitacionesPendientes/codigoError!='T0000'">
        <ns15:salidaConsultarDeuda>
          <ns15:codigoError>
            <xsl:value-of select="/xsd1:MensajeSalidaConsultarCitacionesPendientes/codigoError"/>
          </ns15:codigoError>
          <ns15:mensajeUsuario>
            <xsl:value-of select="/xsd1:MensajeSalidaConsultarCitacionesPendientes/mensajeUsuario"/>
          </ns15:mensajeUsuario>
        </ns15:salidaConsultarDeuda>
      </xsl:when>
      <xsl:otherwise>
        <ns15:salidaConsultarDeuda>
          <ns15:codigoError>
            <xsl:value-of select="/xsd1:MensajeSalidaConsultarCitacionesPendientes/codigoError"/>
          </ns15:codigoError>
          <ns15:mensajeUsuario>
            <xsl:value-of select="/xsd1:MensajeSalidaConsultarCitacionesPendientes/mensajeUsuario"/>
          </ns15:mensajeUsuario>
        </ns15:salidaConsultarDeuda>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
