<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:mmn="http://www.bolivariano.com/MensajeCTE"
                xmlns:ns6="http://www.bolivariano.com/mensaje/MensajeOTC"
                xmlns:java="java" exclude-result-prefixes="xsl mmn ns6">
  <xsl:template match="/">
    <xsl:choose>
      <xsl:when test="/ns6:entradaConsultarDeuda/ns6:servicio/codigoConvenio='CIT'">
        <xsl:call-template name="ConsultarCitacionesPendientes"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="ConsultarCPE"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="ConsultarCitacionesPendientes">
    <mmn:MensajeEntradaConsultarCitacionesPendientes>
      <xsl:call-template name="mensajeBoli"/>
      <cte>
        <aplicativoCobis>N</aplicativoCobis>
        <autorizacion>N</autorizacion>
        <efectivo>0.00</efectivo>
        <empresa>2572</empresa>
        <identificacion>
          <xsl:value-of select='/ns6:entradaConsultarDeuda/ns6:servicio/identificador'/>
        </identificacion>
        <opcion>C</opcion>
        <tipoMoneda>1</tipoMoneda>
        <servicioPersona>1</servicioPersona>
        <cuenta>
          <rubroPerson>PCTG</rubroPerson>
          <serviPerson>CSPB</serviPerson>
        </cuenta>
        <Autenticacion>
          <usuario>7</usuario>
          <clave>BBSfLooV1NH</clave>
        </Autenticacion>
      </cte>
      <cliente>
        <idBanco>7</idBanco>
        <idCliente>
          <xsl:value-of select='/ns6:entradaConsultarDeuda/ns6:servicio/identificador'/>
        </idCliente>
      </cliente>
      <xsl:call-template name="mensajeCore"/>
    </mmn:MensajeEntradaConsultarCitacionesPendientes>
  </xsl:template>
  <xsl:template name="ConsultarCPE">
    <mmn:MensajeEntradaConsultarCEP>
      <xsl:call-template name="mensajeBoli"/>
      <cte>
        <aplicativoCobis>N</aplicativoCobis>
        <autorizacion>N</autorizacion>
        <efectivo>0.00</efectivo>
        <empresa>2572</empresa>
        <opcion>C</opcion>
        <suministro>
          <xsl:value-of select='/ns6:entradaConsultarDeuda/ns6:servicio/identificador'/>
        </suministro>
        <tipoMoneda>1</tipoMoneda>
        <servicioPersona>1</servicioPersona>
        <cuenta>
          <rubroPerson>PCTG</rubroPerson>
          <serviPerson>CSPB</serviPerson>
        </cuenta>
        <Autenticacion>
          <usuario>7</usuario>
          <clave>BBSfLooV1NH</clave>
        </Autenticacion>
      </cte>
      <cliente>
        <idBanco>7</idBanco>
      </cliente>
      <xsl:call-template name="mensajeCore"/>
    </mmn:MensajeEntradaConsultarCEP>
  </xsl:template>
  <xsl:template name="mensajeBoli">
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
    <transaccion>
      <xsl:text disable-output-escaping="no">62153</xsl:text>
    </transaccion>
    <usuario>
      <xsl:value-of select='/ns6:entradaConsultarDeuda/ns6:servicio/datosAdicionales/datoAdicional[codigo = "s_user"]/valor'/>
    </usuario>
  </xsl:template>
  <xsl:template name="mensajeCore">
    <informacionCore>
      <modoCorreccion>N</modoCorreccion>
      <origenTransaccion>
        <xsl:value-of select='/ns6:entradaConsultarDeuda/ns6:servicio/datosAdicionales/datoAdicional[codigo = "s_org"]/valor'/>
      </origenTransaccion>
      <rolBPM>
        <xsl:value-of select='/ns6:entradaConsultarDeuda/ns6:servicio/datosAdicionales/datoAdicional[codigo = "s_rol"]/valor'/>
      </rolBPM>
      <sec>
        <xsl:value-of select='/ns6:entradaConsultarDeuda/ns6:servicio/datosAdicionales/datoAdicional[codigo = "s_ssn"]/valor'/>
      </sec>
      <secuencial>
        <xsl:value-of select='/ns6:entradaConsultarDeuda/ns6:servicio/datosAdicionales/datoAdicional[codigo = "s_ssn"]/valor'/>
      </secuencial>
      <servidor>
        <xsl:value-of select='/ns6:entradaConsultarDeuda/ns6:servicio/datosAdicionales/datoAdicional[codigo = "s_srv"]/valor'/>
      </servidor>
      <servidorLocal>
        <xsl:value-of select='/ns6:entradaConsultarDeuda/ns6:servicio/datosAdicionales/datoAdicional[codigo = "s_lsrv"]/valor'/>
      </servidorLocal>
      <sesion>0</sesion>
    </informacionCore>
  </xsl:template>
</xsl:stylesheet>

