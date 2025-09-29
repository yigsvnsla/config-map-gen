<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"           
				xmlns:msne="http://www.bolivariano.com/MensajeDepositoTemporal"
				xmlns:ns8="http://www.bolivariano.com/mensaje/MensajeOTC"
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:java="java"
                exclude-result-prefixes="xsl java ns8">
  <xsl:template match="/">
    <msne:MensajeEntradaPagar>
      <canal>
        <xsl:value-of select="/ns8:entradaEjecutarPago/ns8:canal"/>
      </canal>
      <date>
        <xsl:value-of select="/ns8:entradaEjecutarPago/ns8:fecha"/>
      </date>
      <oficina>
        <xsl:value-of select='/ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = "s_ofi"]/valor'/>
      </oficina>
      <proceso>
        <xsl:text disable-output-escaping="no">010001</xsl:text>
      </proceso>
      <terminal>
        <xsl:value-of select='/ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = "s_term"]/valor'/>
      </terminal>
      <transaccion>
        <xsl:text disable-output-escaping="no">62653</xsl:text>
      </transaccion>
      <usuario>
        <xsl:value-of select='/ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = "s_user"]/valor'/>
      </usuario>
      <tipoPago>
        <xsl:text disable-output-escaping="no">M</xsl:text>
      </tipoPago>
      <informacionDepositoTemporal>
        <autorizacion>
          <xsl:text disable-output-escaping="no">N</xsl:text>
        </autorizacion>
          <codigoProveedor>
           <xsl:value-of select='/ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = "codigoProveedor"]/valor'/>
          </codigoProveedor>
         <debito>
          <xsl:value-of select="/ns8:entradaEjecutarPago/ns8:valorPago"/>
        </debito>
        <debitoComision>
          <xsl:value-of select="/ns8:entradaEjecutarPago/ns8:valorComision"/>
        </debitoComision>
        <empresa>
          <xsl:value-of select="/ns8:entradaEjecutarPago/ns8:servicio/codigoConvenio"/>
        </empresa>
        <fechaContable>
          <xsl:value-of select='java:format(java:text.SimpleDateFormat.new("yyyy-MM-dd"), java:util.Date.new())'/>
        </fechaContable>
        <horario>
          <xsl:value-of select='java:format(java:text.SimpleDateFormat.new("yyMMddHHmmss"), java:util.Date.new())'/>
        </horario>
        <identificacion>
          <xsl:value-of select="/ns8:entradaEjecutarPago/ns8:servicio/identificador"/>
        </identificacion>
        <tipoMoneda>
          <xsl:text disable-output-escaping="no">840</xsl:text>
        </tipoMoneda>
        <tipoOperacion>
          <xsl:text disable-output-escaping="no">010001</xsl:text>
        </tipoOperacion>
        <ubicacion>
          <xsl:text disable-output-escaping="no">0</xsl:text>
        </ubicacion>
        <cuenta>
          <cuenta>
            <xsl:value-of select="/ns8:entradaEjecutarPago/ns8:cuenta"/>
          </cuenta>
          <idProducto>
            <xsl:value-of select="/ns8:entradaEjecutarPago/ns8:tipoCuenta"/>
          </idProducto>
          <moneda>
            <xsl:text disable-output-escaping="no">1</xsl:text>
          </moneda>
        </cuenta>
        <canalPago>
          <xsl:text disable-output-escaping="no">3</xsl:text>
        </canalPago>
		
        <declaracion>
          <xsl:value-of select="/ns8:entradaEjecutarPago/ns8:servicio/identificador"/>
        </declaracion>
        <codigoAdquiriente>
          <xsl:text disable-output-escaping="no">00000597777</xsl:text>
        </codigoAdquiriente>
        <fechaHoraBANRED>
          <xsl:value-of select='java:format(java:text.SimpleDateFormat.new("yyyy-MM-dd&apos;T&apos;00:00:00.000"), java:util.Date.new())'/>
        </fechaHoraBANRED>
        <fechaTransaccionLocal>
          <xsl:value-of select='java:format(java:text.SimpleDateFormat.new("yyyy-MM-dd&apos;T&apos;00:00:00.000"), java:util.Date.new())'/>
        </fechaTransaccionLocal>
        <fechaCompensacion>
          <xsl:value-of select='java:format(java:text.SimpleDateFormat.new("yyyy-MM-dd&apos;T&apos;00:00:00.000"), java:util.Date.new())'/>
        </fechaCompensacion>
        <horaTransaccionLocal>
          <xsl:value-of select='java:format(java:text.SimpleDateFormat.new("HHmmss"), java:util.Date.new())'/>
        </horaTransaccionLocal>
        <diasGracia>
          <xsl:text disable-output-escaping="no">29791</xsl:text>
        </diasGracia>
        <horarioTransaccion>
          <xsl:value-of select='java:format(java:text.SimpleDateFormat.new("HH"), java:util.Date.new())'/>
        </horarioTransaccion>
        <nombreOCE>
          <xsl:value-of select="/ns8:entradaEjecutarPago/ns8:nombreCliente"/>
        </nombreOCE>
        <referencia>
          <xsl:value-of select="/ns8:entradaEjecutarPago/ns8:servicio/identificador"/>
        </referencia>
        <secuencialAdquiriente>
          <xsl:text disable-output-escaping="no">000000494665</xsl:text>
        </secuencialAdquiriente>
        <numeroTerminal>
          <xsl:text disable-output-escaping="no">0233000000OPE998</xsl:text>
        </numeroTerminal>
        <valorTotal>
          <xsl:value-of select="/ns8:entradaEjecutarPago/ns8:valorComision + /ns8:entradaEjecutarPago/ns8:valorPago"/>
        </valorTotal>
        <valor>
          <xsl:value-of select="format-number(/ns8:entradaEjecutarPago/ns8:valorPago, '0.00')"/>
        </valor>
        <valorRecaudo>
          <xsl:value-of select="format-number(/ns8:entradaEjecutarPago/ns8:valorPago, '0.00')"/>
        </valorRecaudo>
        <valoresEfectoCobro>
          <orden>2</orden>
          <valor/>
        </valoresEfectoCobro>
        <valoresEfectoCobro>
          <orden>3</orden>
          <valor/>
        </valoresEfectoCobro>
        <valoresEfectoCobro>
          <orden>4</orden>
          <valor/>
        </valoresEfectoCobro>
        <valoresEfectoCobro>
          <orden>5</orden>
          <valor/>
        </valoresEfectoCobro>
        <valoresEfectoCobro>
          <orden>6</orden>
          <valor/>
        </valoresEfectoCobro>
        <valoresEfectoCobro>
          <orden>7</orden>
          <valor/>
        </valoresEfectoCobro>
        <valoresEfectoCobro>
          <orden>8</orden>
          <valor/>
        </valoresEfectoCobro>
        <valoresEfectoCobro>
          <orden>9</orden>
          <valor/>
        </valoresEfectoCobro>
        <valoresEfectoCobro>
          <orden>10</orden>
          <valor/>
        </valoresEfectoCobro>
      </informacionDepositoTemporal>
      <informacionCore>
      <fechaProcesoKernel>
          <xsl:value-of select='/ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = "s_date"]/valor'/>
        </fechaProcesoKernel>
		<login><xsl:value-of select='/ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = "05"]/valor'/></login>
        <origenTransaccion>U</origenTransaccion>
        <rolBPM>
          <xsl:value-of select='/ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = "s_rol"]/valor'/>
        </rolBPM>
        <secuencial>
          <xsl:value-of select='/ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = "s_ssn"]/valor'/>
        </secuencial>
        <servidor>
          <xsl:value-of select='/ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = "s_srv"]/valor'/>
        </servidor>
        <servidorLocal>
          <xsl:value-of select='/ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = "s_lsrv"]/valor'/>
        </servidorLocal>    
      </informacionCore>
    </msne:MensajeEntradaPagar>
  </xsl:template>
</xsl:stylesheet>
