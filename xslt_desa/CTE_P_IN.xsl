<xsl:stylesheet version="1.0" exclude-result-prefixes="java ns6 tns xsl"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tns="http://www.bolivariano.com/ws/OTCService"
    xmlns:mmn="http://www.bolivariano.com/MensajeCTE"
    xmlns:ns6="http://www.bolivariano.com/mensaje/MensajeOTC"
    xmlns:java="java">
    <xsl:template match="/">
        <mmn:MensajeEntradaPagar>
            <xsl:variable name="codidentificador" select='/ns6:entradaEjecutarPago/ns6:servicio/codigoTipoIdentificador'/>
            <xsl:variable name="identificador" select='/ns6:entradaEjecutarPago/ns6:servicio/identificador'/>
            <xsl:variable name="servicio" select='substring(/ns6:entradaEjecutarPago/ns6:servicio/codigoConvenio,1,3)'/>
            <canal>
                <xsl:value-of select="/ns6:entradaEjecutarPago/ns6:canal"/>
            </canal>
            <fecha>
                <xsl:value-of select="/ns6:entradaEjecutarPago/ns6:fechaPago"/>
            </fecha>
            <oficina>
                <xsl:value-of select="/ns6:entradaEjecutarPago/ns6:datosAdicionales/ns6:datoAdicional[codigo = &quot;s_ofi&quot;]/valor"/>
            </oficina>
            <terminal>
                <xsl:value-of select="/ns6:entradaEjecutarPago/ns6:datosAdicionales/ns6:datoAdicional[codigo = &quot;s_term&quot;]/valor"/>
            </terminal>
            <transaccion>
                <xsl:text disable-output-escaping="no">62154</xsl:text>
            </transaccion>
            <usuario>
                <xsl:value-of select="/ns6:entradaEjecutarPago/ns6:datosAdicionales/ns6:datoAdicional[codigo = &quot;s_user&quot;]/valor"/>
            </usuario>
            <cte>
                <aplicativoCobis>N</aplicativoCobis>
                <autorizacion>N</autorizacion>
                <xsl:choose>
                    <xsl:when test="/ns6:entradaEjecutarPago/ns6:canal = 'CNB'">
                        <canal>CNB</canal>
                    </xsl:when>
                    <xsl:otherwise>
                        <canal>WEB</canal>
                    </xsl:otherwise>
                </xsl:choose>
                <provincia>GUA</provincia>
                <servicio>
                    <xsl:value-of select="$servicio"/>
                </servicio>
                <xsl:if test="$servicio != 'CIT'">
                    <tramite>
                        <xsl:value-of select="/ns6:entradaEjecutarPago/ns6:datosAdicionales/ns6:datoAdicional[codigo = &quot;tramite&quot;]/valor"/>
                    </tramite>
                </xsl:if>
                <xsl:choose>
                    <xsl:when test="/ns6:entradaEjecutarPago/ns6:canal = 'CNB'">
                        <xsl:if test="/ns6:entradaEjecutarPago/ns6:datosAdicionales/ns6:datoAdicional[codigo = &quot;p_forma_pago&quot;]/valor = 'EFE'">
                            <efectivo>
                                <xsl:value-of select="/ns6:entradaEjecutarPago/ns6:valorPago"/>
                            </efectivo>
                            <efectivoComision>
                                <xsl:value-of select="/ns6:entradaEjecutarPago/ns6:valorComision"/>
                            </efectivoComision>
                        </xsl:if>
                        <xsl:if test="/ns6:entradaEjecutarPago/ns6:datosAdicionales/ns6:datoAdicional[codigo = &quot;p_forma_pago&quot;]/valor = 'DEB'">
                            <debito>
                                <xsl:value-of select="/ns6:entradaEjecutarPago/ns6:valorPago"/>
                            </debito>
                            <debitoComision>
                                <xsl:value-of select="/ns6:entradaEjecutarPago/ns6:valorComision"/>
                            </debitoComision>
                        </xsl:if>
                    </xsl:when>
                    <xsl:otherwise>
                        <!-- PAGO TC -->
                        <xsl:choose>
                            <xsl:when test='/ns6:entradaEjecutarPago/ns6:datosAdicionales/ns6:datoAdicional[codigo = "MPA_TC"]'>
                                <debito>
                                    <xsl:text disable-output-escaping="no">0.00</xsl:text>
                                </debito>
                                <debitoComision>
                                    <xsl:value-of select="/ns6:entradaEjecutarPago/ns6:valorComision"/>
                                </debitoComision>
                                <efectivo>
                                    <xsl:text disable-output-escaping="no">0.00</xsl:text>
                                </efectivo>
                                <efectivoComision>
                                    <xsl:text disable-output-escaping="no">0.00</xsl:text>
                                </efectivoComision>
                            </xsl:when>
                            <xsl:otherwise>
                                <debito>
                                    <xsl:value-of select="/ns6:entradaEjecutarPago/ns6:valorPago"/>
                                </debito>
                                <debitoComision>
                                    <xsl:value-of select="/ns6:entradaEjecutarPago/ns6:valorComision"/>
                                </debitoComision>
                                <efectivo>0.00</efectivo>
                                <efectivoComision>0.00</efectivoComision>
                            </xsl:otherwise>
                        </xsl:choose>
                        <!-- PAGO TC -->
                    </xsl:otherwise>
                </xsl:choose>
                <efectivo>0.00</efectivo>
                <efectivoComision>0.00</efectivoComision>
                <xsl:choose>
                    <xsl:when test="/ns6:entradaEjecutarPago/ns6:canal = 'CNB'">
                        <empresa>
                            <xsl:value-of select="/ns6:entradaEjecutarPago/ns6:datosAdicionales/ns6:datoAdicional[codigo = &quot;p_codigoEmpresa&quot;]/valor"/>
                        </empresa>
                    </xsl:when>
                    <xsl:otherwise>
                        <empresa>
                            <xsl:value-of select="/ns6:entradaEjecutarPago/ns6:servicio/codigoEmpresa"/>
                        </empresa>
                    </xsl:otherwise>
                </xsl:choose>
                <fechaContable>
                    <xsl:value-of select="/ns6:entradaEjecutarPago/ns6:datosAdicionales/ns6:datoAdicional[codigo = &quot;s_date&quot;]/valor"/>
                </fechaContable>
                <fechaEfectiva>
                    <xsl:value-of select='java:format(java:text.SimpleDateFormat.new("yyyy-MM-dd&apos;T&apos;HH:mm:ss.SSS"), java:util.Date.new())'/>
                </fechaEfectiva>
                <xsl:choose>
                    <xsl:when test="$codidentificador='TRAMITE'">
                        <solicitud>
                            <xsl:value-of select="$identificador"/>
                        </solicitud>
                    </xsl:when>
                    <xsl:otherwise>
                        <tipoIdentificacion>
                            <xsl:value-of select="$codidentificador"/>
                        </tipoIdentificacion>
                    </xsl:otherwise>
                </xsl:choose>
                <identificacion>
                    <xsl:value-of select="/ns6:entradaEjecutarPago/ns6:datosAdicionales/ns6:datoAdicional[codigo = &quot;identificacion&quot;]/valor"/>
                </identificacion>
                <nombre>
                    <xsl:value-of select="/ns6:entradaEjecutarPago/ns6:nombreCliente"/>
                </nombre>
                <suministro>
                    <xsl:value-of select="$identificador"/>
                </suministro>
                <tipoMoneda>1</tipoMoneda>
                <tipoPago>M</tipoPago>
                <totalComision>
                    <xsl:value-of select="/ns6:entradaEjecutarPago/ns6:valorComision"/>
                </totalComision>
                <valorTotalCancelar>
                    <xsl:value-of select="format-number(/ns6:entradaEjecutarPago/ns6:valorPago,'0.00') "/>
                </valorTotalCancelar>
                <cuenta>
                    <cuenta>
                        <xsl:value-of select="/ns6:entradaEjecutarPago/ns6:cuenta"/>
                    </cuenta>
                    <tipoCuenta>
                        <xsl:value-of select="/ns6:entradaEjecutarPago/ns6:tipoCuenta"/>
                    </tipoCuenta>
                </cuenta>
                <numeroComprobante>
                    <xsl:value-of select="/ns6:entradaEjecutarPago/ns6:datosAdicionales/ns6:datoAdicional[codigo = &quot;numeroComprobante&quot;]/valor"/>
                </numeroComprobante>
            </cte>
            <tipoPago>M</tipoPago>
            <informacionCore>
                <rolBPM>
                    <xsl:value-of select="/ns6:entradaEjecutarPago/ns6:datosAdicionales/ns6:datoAdicional[codigo = &quot;s_rol&quot;]/valor"/>
                </rolBPM>
                <origenTransaccion>
                    <xsl:value-of select="/ns6:entradaEjecutarPago/ns6:datosAdicionales/ns6:datoAdicional[codigo = &quot;s_org&quot;]/valor"/>
                </origenTransaccion>
                <secuencial>
                    <xsl:value-of select="/ns6:entradaEjecutarPago/ns6:datosAdicionales/ns6:datoAdicional[codigo = &quot;s_ssn&quot;]/valor"/>
                </secuencial>
                <servidor>
                    <xsl:value-of select="/ns6:entradaEjecutarPago/ns6:datosAdicionales/ns6:datoAdicional[codigo = &quot;s_srv&quot;]/valor"/>
                </servidor>
                <servidorLocal>
                    <xsl:value-of select="/ns6:entradaEjecutarPago/ns6:datosAdicionales/ns6:datoAdicional[codigo = &quot;s_lsrv&quot;]/valor"/>
                </servidorLocal>
            </informacionCore>
            <xsl:if test="/ns6:entradaEjecutarPago/ns6:canal = 'CNB'">
                <CNB>
                    <autorizacion>
                        <xsl:value-of select="/ns6:entradaEjecutarPago/ns6:datosAdicionales/ns6:datoAdicional[codigo = 'p_autorizacionCNB']/valor"/>
                    </autorizacion>
                    <comercio>
                        <xsl:value-of select="/ns6:entradaEjecutarPago/ns6:datosAdicionales/ns6:datoAdicional[codigo = 'p_comercio']/valor"/>
                    </comercio>
                    <terminalID>
                        <xsl:value-of select="/ns6:entradaEjecutarPago/ns6:datosAdicionales/ns6:datoAdicional[codigo = 'p_terminalID']/valor"/>
                    </terminalID>
                    <agencia>
                        <xsl:value-of select="/ns6:entradaEjecutarPago/ns6:datosAdicionales/ns6:datoAdicional[codigo = 'p_agencia']/valor"/>
                    </agencia>
                    <red>
                        <xsl:value-of select="/ns6:entradaEjecutarPago/ns6:datosAdicionales/ns6:datoAdicional[codigo = 'p_red']/valor"/>
                    </red>
                    <secuencial>
                        <xsl:value-of select="/ns6:entradaEjecutarPago/ns6:datosAdicionales/ns6:datoAdicional[codigo = 's_ssn']/valor"/>
                    </secuencial>
                    <valor>
                        <xsl:value-of select="/ns6:entradaEjecutarPago/ns6:valorPago"/>
                    </valor>
                    <nombreCliente>
                        <xsl:value-of select='/ns6:entradaEjecutarPago/ns6:datosAdicionales/ns6:datoAdicional[codigo = "p_nombreCliente"]/valor'/>
                    </nombreCliente>
                    <identificacionCliente>
                        <xsl:value-of select='/ns6:entradaEjecutarPago/ns6:datosAdicionales/ns6:datoAdicional[codigo = "p_identificacionCliente"]/valor'/>
                    </identificacionCliente>
                    <modoCorreccion>
                        <xsl:text disable-output-escaping="no">N</xsl:text>
                    </modoCorreccion>
                    <tipoTransaccion>P</tipoTransaccion>
                </CNB>
            </xsl:if>

            <!-- PAGO TC -->
            <xsl:if test='/ns6:entradaEjecutarPago/ns6:datosAdicionales/ns6:datoAdicional[codigo = "MPA_TC"]'>
                <formaPago>
                    <tarjeta>
                        <tarjeta>
                            <xsl:value-of select='/ns6:entradaEjecutarPago/ns6:datosAdicionales/ns6:datoAdicional[codigo = "MPA_TC"]/valor'/>
                        </tarjeta>
                        <valor>
                            <xsl:value-of select="/ns6:entradaEjecutarPago/ns6:valorPago"/>
                        </valor>
                        <valorComision>
                            <xsl:value-of select="/ns6:entradaEjecutarPago/ns6:valorComision"/>
                        </valorComision>
                        <mesesDiferido>
                            <xsl:value-of select='/ns6:entradaEjecutarPago/ns6:datosAdicionales/ns6:datoAdicional[codigo = "FPA_TC"]/valor'/>
                        </mesesDiferido>
                    </tarjeta>
                </formaPago>
            </xsl:if>

            <codigoComercio>
                <xsl:choose>
                    <xsl:when test="/ns6:entradaEjecutarPago/ns6:canal = 'VEN'">
                        <xsl:text disable-output-escaping="no">2006597</xsl:text>
                    </xsl:when>
                    <xsl:when test="/ns6:entradaEjecutarPago/ns6:canal = 'IBK'">
                        <xsl:text disable-output-escaping="no">2006595</xsl:text>
                    </xsl:when>
                    <xsl:when test="/ns6:entradaEjecutarPago/ns6:canal = 'WAP'">
                        <xsl:text disable-output-escaping="no">2006596</xsl:text>
                    </xsl:when>
                    <xsl:when test="/ns6:entradaEjecutarPago/ns6:canal = 'SAT'">
                        <xsl:text disable-output-escaping="no">2006598</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text disable-output-escaping="no">2006598</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </codigoComercio>
            <!-- PAGO TC -->
        </mmn:MensajeEntradaPagar>
    </xsl:template>
</xsl:stylesheet>
