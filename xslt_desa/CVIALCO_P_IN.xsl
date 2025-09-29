<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
				xmlns:xp20="http://www.oracle.com/XSL/Transform/java/oracle.tip.pc.services.functions.Xpath20"
				xmlns:bpws="http://schemas.xmlsoap.org/ws/2003/03/business-process/"
				xmlns:bpel="http://docs.oasis-open.org/wsbpel/2.0/process/executable"
				xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
				xmlns:bpm="http://xmlns.oracle.com/bpmn20/extensions"
				xmlns:ns12="http://www.bolivariano.com/EE"
				xmlns:ns1="http://www.bolivariano.com/dominio/DatoAdicional"
				xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/"
				xmlns:ns14="http://www.bolivariano.com/CoreBB"
				xmlns:ns16="http://www.bolivariano.com/Cuenta"
				xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/"
				xmlns:ora="http://schemas.oracle.com/xpath/extension"
				xmlns:ns5="http://www.bolivariano.com/dominio/Convenio"
				xmlns:socket="http://www.oracle.com/XSL/Transform/java/oracle.tip.adapter.socket.ProtocolTranslator"
				xmlns:ns6="http://www.bolivariano.com/dominio/Recibo"
				xmlns:ns10="http://www.bolivariano.com/dominio/ListaSeleccion"
				xmlns:ns9="http://www.bolivariano.com/dominio/RegionalArea"
				xmlns:ns0="http://www.bolivariano.com/dominio/Servicio"
				xmlns:ns13="http://www.bolivariano.com/MensajeBolivariano"
				xmlns:mhdr="http://www.oracle.com/XSL/Transform/java/oracle.tip.mediator.service.common.functions.MediatorExtnFunction"
				xmlns:oraext="http://www.oracle.com/XSL/Transform/java/oracle.tip.pc.services.functions.ExtFunc"
				xmlns:dvm="http://www.oracle.com/XSL/Transform/java/oracle.tip.dvm.LookupValue"
				xmlns:ns17="http://www.bolivariano.com/Recaudo"
				xmlns:hwf="http://xmlns.oracle.com/bpel/workflow/xpath"
				xmlns:med="http://schemas.oracle.com/mediator/xpath"
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:ns2="http://www.bolivariano.com/dominio/TipoMatriculacion"
				xmlns:ids="http://xmlns.oracle.com/bpel/services/IdentityService/xpath"
				xmlns:mcnel="http://www.bolivariano.com/CashManagement/MensajesDepositoenLinea"
				xmlns:mpe="http://www.bolivariano.com/CashManagement/MensajesPeaje"
				xmlns:peaj="http://www.bolivariano.com/Peaje"
				xmlns:rec="http://www.bolivariano.com/Recaudaciones"
				xmlns:ns3="http://www.bolivariano.com/dominio/FormaPago"
				xmlns:xdk="http://schemas.oracle.com/bpel/extension/xpath/function/xdk"
				xmlns:xref="http://www.oracle.com/XSL/Transform/java/oracle.tip.xref.xpath.XRefXPathFunctions"
				xmlns:ns4="http://www.bolivariano.com/dominio/TipoIdentificador"
				xmlns:tns="http://www.bolivariano.com/ws/OTCService"
				xmlns:http="http://schemas.xmlsoap.org/wsdl/http/"
				xmlns:xsd="http://www.w3.org/2001/XMLSchema"
				xmlns:ns15="http://www.bolivariano.com/Producto"
				xmlns:ns18="http://www.bolivariano.com/Cliente"
				xmlns:ns7="http://www.bolivariano.com/dominio/Empresa"
				xmlns:ns19="http://www.bolivariano.com/Comision"
				xmlns:ns8="http://www.bolivariano.com/mensaje/MensajeOTC"
				xmlns:ldap="http://schemas.oracle.com/xpath/extension/ldap"
				xmlns:java="java"
				exclude-result-prefixes="xsi xsl ns1 soap wsdl ns5 ns6 ns10 ns9 ns0 ns2 ns3 ns4 tns xsd ns7 ns8 ns12 ns14 ns16 ns13 ns17 mcnel mpe peaj http ns15 ns18 ns19 xp20 bpws bpel bpm ora socket mhdr oraext dvm hwf med ids xdk xref ldap">
	<xsl:template match="/">
		<mpe:MensajeEntradaPagar>

			<canal>
				<xsl:value-of select="/ns8:entradaEjecutarPago/ns8:canal"/>
			</canal>

			<depuracion>
				<xsl:text disable-output-escaping="no">N</xsl:text>
			</depuracion>

			<fecha>
				<xsl:value-of select='substring(/ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = "s_date"]/valor,1,19)'/>
			</fecha>

			<oficina>
				<xsl:value-of select='/ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = "s_ofi"]/valor'/>
			</oficina>

			<terminal>
				<xsl:value-of select='/ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = "s_term"]/valor'/>
			</terminal>

			<transaccion>
				<xsl:text disable-output-escaping="no">62675</xsl:text>
			</transaccion>

			<secuencial>
				<xsl:value-of select='/ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = "s_ssn"]/valor'/>
			</secuencial>

			<usuario>
				<xsl:value-of select='/ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = "s_user"]/valor'/>
			</usuario>

			<informacionPeaje>
				<peaj:cod_cliente>
					<xsl:value-of select='/ns8:entradaEjecutarPago/ns8:servicio/identificador'/>
				</peaj:cod_cliente>

				<peaj:importe>
					<xsl:value-of select="/ns8:entradaEjecutarPago/ns8:valorPago"/>
				</peaj:importe>

				<peaj:nom_cliente>
					<xsl:value-of select="/ns8:entradaEjecutarPago/ns8:nombreCliente"/>
				</peaj:nom_cliente>

			</informacionPeaje>

			<informacionRecaudaciones>

				<rec:modoCorreccion>
					<xsl:text disable-output-escaping="no">N</xsl:text>
				</rec:modoCorreccion>

				<rec:servidor>
					<xsl:value-of select='/ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = "s_srv"]/valor'/>
				</rec:servidor>

				<rec:servidorLocal>
					<xsl:value-of select='/ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = "s_srv"]/valor'/>
				</rec:servidorLocal>

				<xsl:choose>
					<xsl:when test="/ns8:entradaEjecutarPago/ns8:canal = 'CNB'">
						<rec:empresa>
							<xsl:value-of select="/ns8:entradaEjecutarPago/ns8:servicio/codigoConvenio"/>
						</rec:empresa>
					</xsl:when>
					<xsl:otherwise>
						<rec:empresa>
							<xsl:value-of select="/ns8:entradaEjecutarPago/ns8:servicio/codigoEmpresa"/>
						</rec:empresa>
					</xsl:otherwise>
				</xsl:choose>


				<rec:aplicativoCobis>
					<xsl:text disable-output-escaping="no">N</xsl:text>
				</rec:aplicativoCobis>

				<rec:moneda>
					<xsl:text disable-output-escaping="no">1</xsl:text>
				</rec:moneda>

				<xsl:choose>
					<xsl:when test="/ns8:entradaEjecutarPago/ns8:canal = 'CNB'">
						<rec:codigoSubempresa>
							<xsl:value-of select="/ns8:entradaEjecutarPago/ns8:servicio/codigoConvenio"/>
						</rec:codigoSubempresa>
					</xsl:when>
					<xsl:otherwise>
						<rec:codigoSubempresa>
							<xsl:value-of select="/ns8:entradaEjecutarPago/ns8:servicio/codigoEmpresa"/>
						</rec:codigoSubempresa>
					</xsl:otherwise>
				</xsl:choose>

				<rec:fechaContable>
					<xsl:value-of select="concat(substring(/ns8:entradaEjecutarPago/ns8:fechaPago,6,2),'/', substring(/ns8:entradaEjecutarPago/ns8:fechaPago,9,2),'/', substring(/ns8:entradaEjecutarPago/ns8:fechaPago,1,4)) "/>
				</rec:fechaContable>
			</informacionRecaudaciones>

			<pago>
				<valorPagoTotal>
					<xsl:value-of select="/ns8:entradaEjecutarPago/ns8:valorPago"/>
				</valorPagoTotal>

				<xsl:variable name="comision">
					<xsl:choose>
						<xsl:when test="string-length(/ns8:entradaEjecutarPago/ns8:valorComision)=0">0.0</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="/ns8:entradaEjecutarPago/ns8:valorComision"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>

				<valorComisionTotal>
					<xsl:value-of select="$comision"/>
				</valorComisionTotal>
				<xsl:choose>
					<xsl:when test="/ns8:entradaEjecutarPago/ns8:canal = 'CNB' and /ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = &quot;p_forma_pago&quot;]/valor = 'DEB' ">
						<debitoCuenta>
							<tipoCuenta>
								<xsl:value-of select="/ns8:entradaEjecutarPago/ns8:tipoCuenta"/>
							</tipoCuenta>
							<cuenta>
								<xsl:value-of select="/ns8:entradaEjecutarPago/ns8:cuenta"/>
							</cuenta>
							<valor>
								<xsl:value-of select="/ns8:entradaEjecutarPago/ns8:valorPago"/>
							</valor>
							<valorComision>
								<xsl:value-of select="$comision"/>
							</valorComision>
						</debitoCuenta>
						<efectivo>
							<valor>0.00</valor>
							<valorComision>0.00</valorComision>
						</efectivo>
						<cheque>
							<cantidadCheques>0</cantidadCheques>
							<valor>0.00</valor>
							<valorComision>0.00</valorComision>
						</cheque>
					</xsl:when>
					<xsl:when test="/ns8:entradaEjecutarPago/ns8:canal = 'CNB' and /ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = &quot;p_forma_pago&quot;]/valor = 'EFE' ">
						<debitoCuenta>
							<tipoCuenta>
								<xsl:text disable-output-escaping="no">CTE</xsl:text>
							</tipoCuenta>
							<cuenta>
								<xsl:value-of select="/ns8:entradaEjecutarPago/ns8:cuenta"/>
							</cuenta>
							<valor>0.00</valor>
							<valorComision>0.00</valorComision>
						</debitoCuenta>
						<efectivo>
							<valor>
								<xsl:value-of select="/ns8:entradaEjecutarPago/ns8:valorPago"/>
							</valor>
							<valorComision>
								<xsl:value-of select="$comision"/>
							</valorComision>
						</efectivo>
						<cheque>
							<cantidadCheques>0</cantidadCheques>
							<valor>0.00</valor>
							<valorComision>0.00</valorComision>
						</cheque>
					</xsl:when>
					<xsl:otherwise>
						<debitoCuenta>
							<tipoCuenta>
								<xsl:value-of select="/ns8:entradaEjecutarPago/ns8:tipoCuenta"/>
							</tipoCuenta>
							<cuenta>
								<xsl:value-of select="/ns8:entradaEjecutarPago/ns8:cuenta"/>
							</cuenta>
							<valor>
								<xsl:value-of select="/ns8:entradaEjecutarPago/ns8:valorPago"/>
							</valor>
							<valorComision>
								<xsl:value-of select="$comision"/>
							</valorComision>
						</debitoCuenta>
						<efectivo>
							<valor>0.00</valor>
							<valorComision>0.00</valorComision>
						</efectivo>
						<cheque>
							<cantidadCheques>0</cantidadCheques>
							<valor>0.00</valor>
							<valorComision>0.00</valorComision>
						</cheque>
					</xsl:otherwise>
				</xsl:choose>
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
		</mpe:MensajeEntradaPagar>
	</xsl:template>
</xsl:stylesheet>
