<xsl:stylesheet version="1.0" exclude-result-prefixes="java ns6 tns xsl" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://www.bolivariano.com/ws/OTCService" xmlns:mmn="http://www.bolivariano.com/MensajeCTE" xmlns:ns6="http://www.bolivariano.com/mensaje/MensajeOTC" xmlns:java="java">
	<xsl:template match="/">
		<mmn:MensajeEntradaReversarPago>
			 <xsl:variable name="codidentificador" select='/ns6:entradaEjecutarReverso/ns6:servicio/codigoTipoIdentificador'/>
            <xsl:variable name="identificador" select='/ns6:entradaEjecutarReverso/ns6:servicio/identificador'/>
            <xsl:variable name="servicio" select='substring(/ns6:entradaEjecutarReverso/ns6:servicio/codigoConvenio,1,3)'/>
			<canal>
				<xsl:value-of select="/ns6:entradaEjecutarReverso/ns6:canal"/>
			</canal>
			<fecha>
				<xsl:value-of select="/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = &quot;s_date&quot;]/valor"/>
			</fecha>
			<oficina>
				<xsl:value-of select="/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = &quot;s_ofi&quot;]/valor"/>
			</oficina>
			<terminal>
				<xsl:value-of select="/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = &quot;s_term&quot;]/valor"/>
			</terminal>
			<transaccion>
				<xsl:text disable-output-escaping="no">62154</xsl:text>
			</transaccion>
			<usuario>
				<xsl:value-of select="/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = &quot;s_user&quot;]/valor"/>
			</usuario>
			<!---->
			<cte>
				<aplicativoCobis>N</aplicativoCobis>
				<autorizacion>N</autorizacion>
				<xsl:choose>
					<xsl:when test="/ns6:entradaEjecutarReverso/ns6:canal = 'CNB'">
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
						<xsl:value-of select="/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = &quot;tramite&quot;]/valor"/>
					</tramite>
				</xsl:if>
				<xsl:choose>
					<xsl:when test="/ns6:entradaEjecutarReverso/ns6:canal = 'CNB'">
						<xsl:if test="/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = &quot;p_forma_pago&quot;]/valor = 'EFE'">
							<efectivo>
								<xsl:value-of select="/ns6:entradaEjecutarReverso/ns6:valorPago"/>
							</efectivo>
							<efectivoComision>
								<xsl:value-of select="/ns6:entradaEjecutarReverso/ns6:valorComision"/>
							</efectivoComision>					
						</xsl:if>
						<xsl:if test="/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = &quot;p_forma_pago&quot;]/valor = 'DEB'">
							<debito>
								<xsl:value-of select="/ns6:entradaEjecutarReverso/ns6:valorPago"/>
							</debito>
							<debitoComision>
								<xsl:value-of select="/ns6:entradaEjecutarReverso/ns6:valorComision"/>
							</debitoComision>
						</xsl:if>
					</xsl:when>
					<xsl:otherwise>
						<debito>
							<xsl:value-of select="/ns6:entradaEjecutarReverso/ns6:valorPago"/>
						</debito>
						<debitoComision>
							<xsl:value-of select="/ns6:entradaEjecutarReverso/ns6:valorComision"/>
						</debitoComision>
					</xsl:otherwise>
				</xsl:choose>						
				<efectivo>0.00</efectivo>
				<efectivoComision>0.00</efectivoComision>
				<xsl:choose>
					<xsl:when test="/ns6:entradaEjecutarReverso/ns6:canal = 'CNB'">
						<empresa>
							<xsl:value-of select="/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = &quot;p_codigoEmpresa&quot;]/valor"/>
						</empresa>
					</xsl:when>
					<xsl:otherwise>
						<empresa>
							<xsl:value-of select="/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = &quot;codigoEmpresa&quot;]/valor"/>
						</empresa>
					</xsl:otherwise>
				</xsl:choose>				
				<fechaContable>
					<xsl:value-of select="substring(/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = &quot;s_date&quot;]/valor,1,10)"/>
				</fechaContable>
				<fechaEfectiva>
					<xsl:value-of select="/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = &quot;s_date&quot;]/valor"/>
				</fechaEfectiva>
				 <solicitud>
                            <xsl:value-of select="$identificador"/>
                 </solicitud>

				<identificacion>
					<xsl:value-of select="/ns6:entradaEjecutarReverso/ns6:servicio/identificador"/>
				</identificacion>
				<nombre>
					<xsl:value-of select="/ns6:entradaEjecutarReverso/ns6:nombreCliente"/>
				</nombre>
				<operacionProceso>T</operacionProceso>
				<xsl:choose>
					<xsl:when test="/ns6:entradaEjecutarReverso/ns6:servicio/codigoConvenio='CIT'">
						<suministro>
							<xsl:value-of select="/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = &quot;suministro&quot;]/valor"/>
						</suministro>
					</xsl:when>
					<xsl:otherwise>
						<suministro>
							<xsl:value-of select="/ns6:entradaEjecutarReverso/ns6:servicio/identificador"/>
						</suministro>
					</xsl:otherwise>
				</xsl:choose>
				<tipoMoneda>1</tipoMoneda>
				<tipoPago>M</tipoPago>
				<!--<rubroPersona>2</rubroPersona>-->
				<totalComision>
					<xsl:value-of select="/ns6:entradaEjecutarReverso/ns6:valorComision"/>
				</totalComision>
				<valorTotalCancelar>
					<xsl:value-of select="format-number(/ns6:entradaEjecutarReverso/ns6:valorPago,'0.00') "/>
				</valorTotalCancelar>
				<cuenta>
					<cuenta>
						<xsl:value-of select="/ns6:entradaEjecutarReverso/ns6:cuenta"/>
					</cuenta>
					<tipoCuenta>
						<xsl:value-of select="/ns6:entradaEjecutarReverso/ns6:tipoCuenta"/>
					</tipoCuenta>
					<consComision>0</consComision>
					<!--<rubroPerson>PCTG</rubroPerson>

          <serviPerson>CSPB</serviPerson>-->
					<subtotal>0.00</subtotal>
				</cuenta>
				<Autenticacion>
					<usuario>7</usuario>
					<clave>BBSfLooV1NH</clave>
				</Autenticacion>
				 <numeroComprobante>
                    <xsl:value-of select="/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = &quot;numeroComprobante&quot;]/valor"/>
                </numeroComprobante>

			</cte>
			<cliente>
				<compania>2</compania>
				<idBanco>7</idBanco>
				<tipoId>N</tipoId>
			</cliente>
			<tipoPago>M</tipoPago>
			<!---->
			<informacionCore>
				<modoCorreccion>
					<xsl:text disable-output-escaping="no">S</xsl:text>
				</modoCorreccion>
				<xsl:choose>
					<xsl:when test="/ns6:entradaEjecutarReverso/ns6:canal = 'CNB'">
						<reversoTransaccion>
							<xsl:value-of select="/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = &quot;p_reversoTransaccion&quot;]/valor"/>
						</reversoTransaccion>				
					</xsl:when>
					<xsl:otherwise>
						<reversoTransaccion>
							<xsl:value-of select="/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = &quot;s_ssn_reverse&quot;]/valor"/>
						</reversoTransaccion>
					</xsl:otherwise>
				</xsl:choose>
				<rolBPM>
					<xsl:value-of select="/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = &quot;s_rol&quot;]/valor"/>
				</rolBPM>
				<sec>
					<xsl:value-of select="/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = &quot;s_ssn&quot;]/valor"/>
				</sec>
				<secuencial>
					<xsl:value-of select="/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = &quot;s_ssn&quot;]/valor"/>
				</secuencial>
				<servidor>
					<xsl:value-of select="/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = &quot;s_srv&quot;]/valor"/>
				</servidor>
			</informacionCore>
			<xsl:if test="/ns6:entradaEjecutarReverso/ns6:canal = 'CNB'">
				<CNB>
					<autorizacion>
						<xsl:value-of select="/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = 'p_autorizacionCNB']/valor"/>
					</autorizacion>
					<comercio>
						<xsl:value-of select="/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = 'p_comercio']/valor"/>
					</comercio>
					<terminalID>
						<xsl:value-of select="/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = 'p_terminalID']/valor"/>
					</terminalID>
					<agencia>
						<xsl:value-of select="/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = 'p_agencia']/valor"/>
					</agencia>
					<red>
						<xsl:value-of select="/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = 'p_red']/valor"/>
					</red>
					<secuencial>
						<xsl:value-of select="/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = 's_ssn']/valor"/>
					</secuencial>
					<valor>
						<xsl:value-of select="/ns6:entradaEjecutarReverso/ns6:valorPago"/>
					</valor>
					<nombreCliente>
						<xsl:value-of select='/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = "p_nombreCliente"]/valor'/>
					</nombreCliente>
					<identificacionCliente>
						<xsl:value-of select='/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = "p_identificacionCliente"]/valor'/>
					</identificacionCliente>	
					<modoCorreccion>
						<xsl:text disable-output-escaping="no">S</xsl:text>
					</modoCorreccion>
					<reversoTransaccion>
						<xsl:value-of select="/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = &quot;p_reversoTransaccion&quot;]/valor"/>
					</reversoTransaccion>		
				</CNB>
			</xsl:if>		 
		</mmn:MensajeEntradaReversarPago>
	</xsl:template>
</xsl:stylesheet>
