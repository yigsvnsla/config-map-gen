<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:mmn="http://www.bolivariano.com/MensajeCTE" xmlns:ns6="http://www.bolivariano.com/mensaje/MensajeOTC" xmlns:java="java" exclude-result-prefixes="xsl mmn ns6">
  <xsl:template match="/">
    <mmn:MensajeEntradaConsultarCEP>
      <xsl:variable name="identificador" select='/ns6:entradaConsultarDeuda/ns6:servicio/identificador'/>
      <xsl:variable name="servicio" select='substring(/ns6:entradaConsultarDeuda/ns6:servicio/codigoConvenio,1,3)'/>
      <xsl:variable name="codidentificador" select='/ns6:entradaConsultarDeuda/ns6:servicio/codigoTipoIdentificador'/>
      <canal>
        <xsl:value-of select="/ns6:entradaConsultarDeuda/ns6:canal"/>
      </canal>
      <fecha>
        <xsl:value-of select='/ns6:entradaConsultarDeuda/ns6:servicio/datosAdicionales/datoAdicional[codigo = "s_date"]/valor'/>
      </fecha>
      <oficina>
        <xsl:value-of select='/ns6:entradaConsultarDeuda/ns6:servicio/datosAdicionales/datoAdicional[codigo = "s_ofi"]/valor'/>
      </oficina>
      <terminal>
        <xsl:value-of select='/ns6:entradaConsultarDeuda/ns6:servicio/datosAdicionales/datoAdicional[codigo = "s_term"]/valor'/>
      </terminal>
      <usuario>
        <xsl:value-of select='/ns6:entradaConsultarDeuda/ns6:servicio/datosAdicionales/datoAdicional[codigo = "s_user"]/valor'/>
      </usuario>
      <cte>
        <empresa>2572</empresa>
        <canal>WEB</canal>
        <provincia>GUA</provincia>
         <opcion>C</opcion>
        <tipoMoneda>1</tipoMoneda>
        <servicioPersona>1</servicioPersona>
        <cuenta>
          <rubroPerson>PCTG</rubroPerson>
          <serviPerson>CSPB</serviPerson>
        </cuenta>
        <servicio>
          <xsl:value-of select="$servicio"/>
        </servicio>
        <xsl:choose>
          <xsl:when test="$codidentificador='PLA'">
            <placa>
              <xsl:value-of select="$identificador"/>
            </placa>
          </xsl:when>
          <xsl:when test="$codidentificador='TRAMITE'">
            <solicitud>
              <xsl:value-of select="$identificador"/>
            </solicitud>
          </xsl:when>
          <xsl:otherwise>
            <tipoIdentificacion>
              <xsl:value-of select="$codidentificador"/>
            </tipoIdentificacion>
            <identificacion>
              <xsl:value-of select="$identificador"/>
            </identificacion>
          </xsl:otherwise>
        </xsl:choose>
        <suministro>
          <xsl:value-of select="$identificador"/>
        </suministro>
        
      </cte>
      <informacionCore>
        <origenTransaccion>
          <xsl:value-of select='/ns6:entradaConsultarDeuda/ns6:servicio/datosAdicionales/datoAdicional[codigo = "s_org"]/valor'/>
        </origenTransaccion>
        <rolBPM>
          <xsl:value-of select='/ns6:entradaConsultarDeuda/ns6:servicio/datosAdicionales/datoAdicional[codigo = "s_rol"]/valor'/>
        </rolBPM>
        <secuencial>
          <xsl:value-of select='/ns6:entradaConsultarDeuda/ns6:servicio/datosAdicionales/datoAdicional[codigo = "s_ssn"]/valor'/>
        </secuencial>
        <servidor>
          <xsl:value-of select='/ns6:entradaConsultarDeuda/ns6:servicio/datosAdicionales/datoAdicional[codigo = "s_srv"]/valor'/>
        </servidor>
        <servidorLocal>
          <xsl:value-of select='/ns6:entradaConsultarDeuda/ns6:servicio/datosAdicionales/datoAdicional[codigo = "s_lsrv"]/valor'/>
        </servidorLocal>
       

      </informacionCore>
    </mmn:MensajeEntradaConsultarCEP>
  </xsl:template>
</xsl:stylesheet>
