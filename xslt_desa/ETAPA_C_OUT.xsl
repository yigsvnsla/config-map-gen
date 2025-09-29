<xsl:stylesheet version="1.0"
                xmlns:tns="http://www.bolivariano.com/ws/OTCService"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:ns10="http://www.bolivariano.com/mensaje/MensajeOTC"
                xmlns:mcr="http://www.bolivariano.com/MensajeEtapa"
                exclude-result-prefixes="tns xsl mcr">
  <xsl:template match="/">
    <xsl:choose>
      <xsl:when test="/mcr:MensajeSalidaConsultar/codigoError='OK'">
        <ns10:salidaConsultarDeuda>
          <ns10:codigoError>0</ns10:codigoError>
          <ns10:datosAdicionales>
            <xsl:call-template name="datosAdicionales"/>
          </ns10:datosAdicionales>
          <xsl:if test="/mcr:MensajeSalidaConsultar/InformacionEtapa/empresa !='1708'">
            <ns10:formaPago>TOTAL</ns10:formaPago>
          </xsl:if>
          <xsl:if test="/mcr:MensajeSalidaConsultar/InformacionEtapa/empresa = '1708'">
            <ns10:formaPago>TOTAL</ns10:formaPago>
          </xsl:if>
          <ns10:limiteMontoMaximo>
            <xsl:value-of select="/mcr:MensajeSalidaConsultar/InformacionEtapa/deudaActual div 100"/>
          </ns10:limiteMontoMaximo>
          <ns10:montoTotal>
            <xsl:value-of select="/mcr:MensajeSalidaConsultar/InformacionEtapa/deudaActual div 100"/>
          </ns10:montoTotal>
          <ns10:nombreCliente>
            <xsl:value-of select="/mcr:MensajeSalidaConsultar/InformacionEtapa/nombre"/>
          </ns10:nombreCliente>
        </ns10:salidaConsultarDeuda>
      </xsl:when>
      <xsl:otherwise>
        <ns10:salidaConsultarDeuda>
          <ns10:codigoError>
            <xsl:value-of select="/mcr:MensajeSalidaConsultar/codigoError"/>
          </ns10:codigoError>
          <ns10:mensajeUsuario>
            <xsl:value-of select="/mcr:MensajeSalidaConsultar/mensajeUsuario"/>
          </ns10:mensajeUsuario>
          <ns10:mensajeSistema>
            <xsl:value-of select="/mcr:MensajeSalidaConsultar/mensajeSistema"/>
          </ns10:mensajeSistema>
        </ns10:salidaConsultarDeuda>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!--  User Defined Templates  -->
  <xsl:template name="datosAdicionales">
    <ns10:datoAdicional>
      <codigo>01</codigo>
      <!-- llenar desde el componente-->
      <etiqueta>empresa</etiqueta>
      <!-- llenar desde el componente-->
      <valor>
        <xsl:value-of select="/mcr:MensajeSalidaConsultar/InformacionEtapa/empresa"/>
      </valor>
      <visible>false</visible>
      <!-- llenar desde el componente-->
    </ns10:datoAdicional>
    <ns10:datoAdicional>
      <codigo>nombreCli</codigo>
      <etiqueta>empresa</etiqueta>
      <valor>
        <xsl:value-of select="/mcr:MensajeSalidaConsultar/InformacionEtapa/nombre"/>
      </valor>
      <visible>false</visible>
    </ns10:datoAdicional>
    <ns10:datoAdicional>
      <codigo>valorComision</codigo>
      <valor>  
      <xsl:choose>
        <xsl:when test="/mcr:MensajeSalidaConsultar/InformacionEtapa/valorComision > 0 ">
	      <xsl:variable name="nvalorTotalComision" select="string(/mcr:MensajeSalidaConsultar/InformacionEtapa/valorComision)"/>
	      <xsl:value-of select="substring($nvalorTotalComision, 1, string-length(substring-before($nvalorTotalComision, '.')) + 3)"/>
       </xsl:when>
       <xsl:otherwise>
          <xsl:text disable-output-escaping="no">0.0</xsl:text>
       </xsl:otherwise>
      </xsl:choose>
      </valor>
      <visible>false</visible>
      <!-- llenar desde el componente-->
    </ns10:datoAdicional>
    <ns10:datoAdicional>
      <codigo>identificadorDeuda</codigo>
      <valor>
        <xsl:value-of select="/mcr:MensajeSalidaConsultar/InformacionEtapa/identificadorDeuda"/>
      </valor>
      <visible>false</visible>
    </ns10:datoAdicional>
    <ns10:datoAdicional>
      <codigo>idReferencia</codigo>
      <valor>
        <xsl:value-of select="/mcr:MensajeSalidaConsultar/InformacionEtapa/idReferencia"/>
      </valor>
      <visible>false</visible>
      <!-- llenar desde el componente-->
    </ns10:datoAdicional>
    <ns10:datoAdicional>
      <codigo>tipoServicio</codigo>
      <!-- llenar desde el componente-->
      <valor>
        <xsl:value-of select="/mcr:MensajeSalidaConsultar/InformacionEtapa/tipoServicio"/>
      </valor>
      <visible>false</visible>
      <!-- llenar desde el componente-->
    </ns10:datoAdicional>
    <ns10:datoAdicional>
      <codigo>servicioNombre</codigo>
      <valor>
        <xsl:value-of select="/mcr:MensajeSalidaConsultar/InformacionEtapa/servicioNombre"/>
      </valor>
      <visible>false</visible>
      <!-- llenar desde el componente-->
    </ns10:datoAdicional>
    <ns10:datoAdicional>
      <codigo>docPendientes</codigo>
      <!-- llenar desde el componente-->
      <etiqueta>Facturas Pendientes</etiqueta>
      <!-- llenar desde el componente-->
      <valor>
        <xsl:value-of select="/mcr:MensajeSalidaConsultar/InformacionEtapa/docPendientes"/>
      </valor>
      <visible>true</visible>
      <editable>false</editable>
      <!-- llenar desde el componente-->
    </ns10:datoAdicional>
    <ns10:datoAdicional>
      <codigo>deudaActual</codigo>
      <valor>
        <xsl:value-of select="/mcr:MensajeSalidaConsultar/InformacionEtapa/deudaActual"/>
      </valor>
      <visible>false</visible>
      <!-- llenar desde el componente-->
    </ns10:datoAdicional>
    <ns10:datoAdicional>
      <codigo>fechaUltimoPago</codigo>
      <valor>
        <xsl:value-of select="/mcr:MensajeSalidaConsultar/InformacionEtapa/fechaUltimoPago"/>
      </valor>
      <visible>false</visible>
      <!-- llenar desde el componente-->
    </ns10:datoAdicional>
  </xsl:template>
</xsl:stylesheet>



