<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
	xmlns:mc="http://www.bolivariano.com/CashManagement/MensajesRecaudacionAgua"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:ns8="http://www.bolivariano.com/mensaje/MensajeOTC"
	xmlns:tns="http://www.bolivariano.com/mensaje/MensajeOTC"
	exclude-result-prefixes="xsl tns"
>
	<xsl:template match="/">
		<mc:MensajeEntradaPagar>
			<!--<xsl:if test='/ns8:entradaEjecutarPago/ns8:servicio/codigoEmpresa = "6"'>-->
			<canal>
				<xsl:value-of select="/ns8:entradaEjecutarPago/ns8:canal"/>
			</canal>
			<!--</xsl:if><xsl:if test='/ns8:entradaEjecutarPago/ns8:servicio/codigoEmpresa = "4" or /ns8:entradaEjecutarPago/ns8:servicio/codigoEmpresa = "360"'><canal><xsl:value-of select="/ns8:entradaEjecutarPago/ns8:canal"/></canal></xsl:if>-->
			<fecha>
				<xsl:value-of select='/ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = "s_date"]/valor'/>
			</fecha>
			<oficina>
				<xsl:text disable-output-escaping="no">0</xsl:text>
			</oficina>
			<terminal>
				<xsl:value-of select='/ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = "s_term"]/valor'/>
			</terminal>
			<xsl:choose>
				<xsl:when test='/ns8:entradaEjecutarPago/ns8:canal != "CNB" and /ns8:entradaEjecutarPago/ns8:servicio/codigoEmpresa = "4"'>
					<transaccion>
						<xsl:text disable-output-escaping="no">3137</xsl:text>
					</transaccion>
				</xsl:when>
				<xsl:when test='/ns8:entradaEjecutarPago/ns8:canal != "CNB" and /ns8:entradaEjecutarPago/ns8:servicio/codigoEmpresa = "360"'>
					<transaccion>
						<xsl:text disable-output-escaping="no">3137</xsl:text>
					</transaccion>
				</xsl:when>
				<xsl:when test='/ns8:entradaEjecutarPago/ns8:canal != "CNB" and /ns8:entradaEjecutarPago/ns8:servicio/codigoEmpresa = "6"'>
					<transaccion>
						<xsl:text disable-output-escaping="no">62669</xsl:text>
					</transaccion>
					<!--AMAGUA EN LINEA-->
				</xsl:when>
				<xsl:when test='/ns8:entradaEjecutarPago/ns8:canal = "CNB" and /ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = "p_codigoEmpresa"]/valor = "4"'>
					<transaccion>
						<xsl:text disable-output-escaping="no">3137</xsl:text>
					</transaccion>
				</xsl:when>
				<xsl:when test='/ns8:entradaEjecutarPago/ns8:canal = "CNB" and /ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = "p_codigoEmpresa"]/valor = "360"'>
					<transaccion>
						<xsl:text disable-output-escaping="no">3137</xsl:text>
					</transaccion>
				</xsl:when>
				<xsl:when test='/ns8:entradaEjecutarPago/ns8:canal = "CNB" and /ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = "p_codigoEmpresa"]/valor = "6"'>
					<transaccion>
						<xsl:text disable-output-escaping="no">62669</xsl:text>
					</transaccion>
					<!--AMAGUA EN LINEA-->
				</xsl:when>
			</xsl:choose>
			<secuencial>
				<xsl:value-of select='/ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = "s_ssn"]/valor'/>
			</secuencial>
			<usuario>
				<xsl:value-of select='/ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = "s_user"]/valor'/>
			</usuario>
			<xsl:choose>
				<xsl:when test='/ns8:entradaEjecutarPago/ns8:canal != "CNB" and /ns8:entradaEjecutarPago/ns8:servicio/codigoEmpresa = "4"'>
					<empresa>
						<xsl:text disable-output-escaping="no">AGUAPEN</xsl:text>
					</empresa>
				</xsl:when>
				<xsl:when test='/ns8:entradaEjecutarPago/ns8:canal != "CNB" and /ns8:entradaEjecutarPago/ns8:servicio/codigoEmpresa = "6"'>
					<empresa>
						<xsl:text disable-output-escaping="no">AMAGUA</xsl:text>
					</empresa>
				</xsl:when>
				<xsl:when test='/ns8:entradaEjecutarPago/ns8:canal != "CNB" and /ns8:entradaEjecutarPago/ns8:servicio/codigoEmpresa = "4"'>
					<empresa>
						<xsl:text disable-output-escaping="no">EMAAP-Q</xsl:text>
					</empresa>
				</xsl:when>
				<xsl:when test='/ns8:entradaEjecutarPago/ns8:canal = "CNB" and /ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = "p_codigoEmpresa"]/valor = "4"'>
					<empresa>
						<xsl:text disable-output-escaping="no">AGUAPEN</xsl:text>
					</empresa>
				</xsl:when>
				<xsl:when test='/ns8:entradaEjecutarPago/ns8:canal = "CNB" and /ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = "p_codigoEmpresa"]/valor = "6"'>
					<empresa>
						<xsl:text disable-output-escaping="no">AMAGUA</xsl:text>
					</empresa>
				</xsl:when>
				<xsl:when test='/ns8:entradaEjecutarPago/ns8:canal = "CNB" and /ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = "p_codigoEmpresa"]/valor = "4"'>
					<empresa>
						<xsl:text disable-output-escaping="no">EMAAP-Q</xsl:text>
					</empresa>
				</xsl:when>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="/ns8:entradaEjecutarPago/ns8:canal = 'CNB'">
					<codigoEmpresa>
						<xsl:value-of select="/ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = 'p_codigoEmpresa']/valor"/>
					</codigoEmpresa>
				</xsl:when>
				<xsl:otherwise>
					<codigoEmpresa>
						<xsl:value-of select="/ns8:entradaEjecutarPago/ns8:servicio/codigoEmpresa"/>
					</codigoEmpresa>
				</xsl:otherwise>
			</xsl:choose>
			<suministro>
				<xsl:value-of select="/ns8:entradaEjecutarPago/ns8:servicio/identificador"/>
			</suministro>
			<moneda>
				<xsl:text disable-output-escaping="no">1</xsl:text>
			</moneda>
			<xsl:if test='not(/ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = "MPA_TC"])'>				<!--Jesus-->
				<cuenta>
					<xsl:value-of select="/ns8:entradaEjecutarPago/ns8:cuenta"/>
				</cuenta>
			</xsl:if>
			<xsl:choose>
				<xsl:when test="/ns8:entradaEjecutarPago/ns8:canal = 'CNB' and (/ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = 'p_forma_pago']/valor = 'EFE')">
					<tipoCuenta>
						<xsl:text disable-output-escaping="no">CTE</xsl:text>
					</tipoCuenta>
				</xsl:when>
				<xsl:when test='/ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = "MPA_TC"]'>
					<tipoCuenta>
						<xsl:text disable-output-escaping="no">CTE</xsl:text>
					</tipoCuenta>
				</xsl:when>
				<xsl:otherwise>
					<tipoCuenta>
						<xsl:value-of select="/ns8:entradaEjecutarPago/ns8:tipoCuenta"/>
					</tipoCuenta>
				</xsl:otherwise>
			</xsl:choose>
			<nombreCliente>
				<xsl:value-of select="/ns8:entradaEjecutarPago/ns8:nombreCliente"/>
			</nombreCliente>
			<pago>
				<valorPagoTotal>
					<xsl:value-of select="/ns8:entradaEjecutarPago/ns8:valorPago"/>
				</valorPagoTotal>
				<valorComisionTotal>
					<xsl:value-of select="/ns8:entradaEjecutarPago/ns8:valorComision"/>
				</valorComisionTotal>
				<!--KBastidz TC-->
				<xsl:choose>
					<xsl:when test='/ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = "MPA_TC"]'>
						<xsl:if test='/ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = "MPA_TC"]'>
							<debitoCuenta>
								<tipoCuenta>
									<xsl:text disable-output-escaping="no">CTE</xsl:text>
								</tipoCuenta>
								<cuenta>
									<xsl:value-of select="/ns8:entradaEjecutarPago/ns8:cuenta"/>
								</cuenta>
								<valor>
									<xsl:text disable-output-escaping="no">0.00</xsl:text>
								</valor>
								<valorComision>
									<xsl:text disable-output-escaping="no">0.00</xsl:text>
								</valorComision>
							</debitoCuenta>
						</xsl:if>
					</xsl:when>
					<xsl:otherwise>
						<debitoCuenta>
							<xsl:choose>
								<xsl:when test="/ns8:entradaEjecutarPago/ns8:canal = 'CNB' and (/ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = 'p_forma_pago']/valor = 'EFE')">
									<tipoCuenta>
										<xsl:text disable-output-escaping="no">CTE</xsl:text>
									</tipoCuenta>
								</xsl:when>
								<xsl:otherwise>
									<tipoCuenta>
										<xsl:value-of select="/ns8:entradaEjecutarPago/ns8:tipoCuenta"/>
									</tipoCuenta>
								</xsl:otherwise>
							</xsl:choose>
							<cuenta>
								<xsl:value-of select="/ns8:entradaEjecutarPago/ns8:cuenta"/>
							</cuenta>
							<xsl:choose>
								<xsl:when test="/ns8:entradaEjecutarPago/ns8:canal = 'CNB' and (/ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = 'p_forma_pago']/valor = 'EFE')">
									<valor>
										<xsl:text disable-output-escaping="no">0.00</xsl:text>
									</valor>
								</xsl:when>
								<xsl:when test="/ns8:entradaEjecutarPago/ns8:canal = 'CNB' and (/ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = 'p_forma_pago']/valor = 'DEB')">
									<valor>
										<xsl:value-of select="/ns8:entradaEjecutarPago/ns8:valorPago"/>
									</valor>
								</xsl:when>
								<xsl:otherwise>
									<valor>
										<xsl:value-of select="/ns8:entradaEjecutarPago/ns8:valorPago"/>
									</valor>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:choose>
								<xsl:when test="/ns8:entradaEjecutarPago/ns8:canal = 'CNB' and (/ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = 'p_forma_pago']/valor = 'EFE')">
									<valorComision>
										<xsl:text disable-output-escaping="no">0.00</xsl:text>
									</valorComision>
								</xsl:when>
								<xsl:when test="/ns8:entradaEjecutarPago/ns8:canal = 'CNB' and (/ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = 'p_forma_pago']/valor = 'DEB')">
									<valorComision>
										<xsl:value-of select="/ns8:entradaEjecutarPago/ns8:valorComision"/>
									</valorComision>
								</xsl:when>
								<xsl:otherwise>
									<valorComision>
										<xsl:value-of select="/ns8:entradaEjecutarPago/ns8:valorComision"/>
									</valorComision>
								</xsl:otherwise>
							</xsl:choose>
						</debitoCuenta>
					</xsl:otherwise>
				</xsl:choose>
				<!--KBastidz TC-->
				<efectivo>
					<xsl:choose>
						<xsl:when test="/ns8:entradaEjecutarPago/ns8:canal = 'CNB' and (/ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = 'p_forma_pago']/valor = 'EFE')">
							<valor>
								<xsl:value-of select="/ns8:entradaEjecutarPago/ns8:valorPago"/>
							</valor>
						</xsl:when>
						<xsl:otherwise>
							<valor>
								<xsl:text disable-output-escaping="no">0.00</xsl:text>
							</valor>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:choose>
						<xsl:when test="/ns8:entradaEjecutarPago/ns8:canal = 'CNB' and (/ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = 'p_forma_pago']/valor = 'EFE')">
							<valorComision>
								<xsl:value-of select="/ns8:entradaEjecutarPago/ns8:valorComision"/>
							</valorComision>
						</xsl:when>
						<xsl:otherwise>
							<valorComision>
								<xsl:text disable-output-escaping="no">0.00</xsl:text>
							</valorComision>
						</xsl:otherwise>
					</xsl:choose>
				</efectivo>
				<!--JAGUZMAM TC-->
				<xsl:if test='/ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = "MPA_TC"]'>
					<!-- <formaPago> -->
					<tarjeta>
						<tipoTarjeta>CTE</tipoTarjeta>
						<tarjeta>
							<xsl:value-of select='/ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = "MPA_TC"]/valor'/>
						</tarjeta>
						<cvv>
							<xsl:value-of select='/ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = "FPA_TC"]/valor'/>
						</cvv>
						<fechaExpiracion/>
						<valor>
							<xsl:value-of select="format-number(/tns:entradaEjecutarPago/ns8:valorPago,'0.00')"/>
						</valor>
						<valorComision>
							<xsl:value-of select="format-number(/tns:entradaEjecutarPago/ns8:valorComision,'0.00')"/>
						</valorComision>
					</tarjeta>
					<!--
						<tarjeta><tarjeta><xsl:value-of select='/ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = "MPA_TC"]/valor'/></tarjeta><valor><xsl:value-of select="format-number(/tns:entradaEjecutarPago/ns8:valorPago,'0.00')"/></valor><valorComision><xsl:value-of select="format-number(/tns:entradaEjecutarPago/ns8:valorComision,'0.00')"/></valorComision><mesesDiferido><xsl:value-of select='/ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = "FPA_TC"]/valor'/></mesesDiferido></tarjeta>
					-->
					<!-- </formaPago> -->
				</xsl:if>
				<!--JAGUZMAM TC-->
			</pago>
			<xsl:choose>
				<xsl:when test="/ns8:entradaEjecutarPago/ns8:canal = 'CNB'">
					<CNB>
						<autorizacion>
							<xsl:value-of select="/ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = 'p_autorizacionCNB']/valor"/>
						</autorizacion>
						<comercio>
							<xsl:value-of select="/ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = 'p_comercio']/valor"/>
						</comercio>
						<terminalID>
							<xsl:value-of select="/ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = 'p_terminalID']/valor"/>
						</terminalID>
						<agencia>
							<xsl:value-of select="/ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = 'p_agencia']/valor"/>
						</agencia>
						<red>
							<xsl:value-of select="/ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = 'p_red']/valor"/>
						</red>
						<secuencial>
							<xsl:value-of select='/ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = "s_ssn"]/valor'/>
						</secuencial>
						<valor>
							<xsl:value-of select="/ns8:entradaEjecutarPago/ns8:valorPago"/>
						</valor>
						<nombreCliente>
							<xsl:value-of select='/ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = "p_nombreCliente"]/valor'/>
						</nombreCliente>
						<identificacionCliente>
							<xsl:value-of select='/ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = "p_identificacionCliente"]/valor'/>
						</identificacionCliente>
						<modoCorreccion>
							<xsl:text disable-output-escaping="no">N</xsl:text>
						</modoCorreccion>
						<tipoTransaccion>
							<xsl:text disable-output-escaping="no">P</xsl:text>
						</tipoTransaccion>
						<formaPago>
							<xsl:value-of select='/ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = "p_forma_pago"]/valor'/>
						</formaPago>
					</CNB>
				</xsl:when>
			</xsl:choose>
		</mc:MensajeEntradaPagar>
	</xsl:template>
</xsl:stylesheet>