<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"              
                xmlns:msne="http://www.bolivariano.com/MensajeDepositoTemporal"
                xmlns:ns14="http://www.bolivariano.com/mensaje/MensajeOTC"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:java="java"
                exclude-result-prefixes="java msne xsl ns14">
	<xsl:template match="/">
		<xsl:choose>
			<xsl:when test="/msne:MensajeSalidaPagar/codigoError='0'">
				<ns14:salidaEjecutarPago>
					<ns14:codigoError>0</ns14:codigoError>
					<ns14:fechaDebito>
						<xsl:value-of select='java:format(java:text.SimpleDateFormat.new("yyyy-MM-dd&apos;T&apos;HH:mm:ss"), java:util.Date.new())'/>
					</ns14:fechaDebito>
					<ns14:fechaPago>
						<xsl:value-of select="/msne:MensajeSalidaPagar/informacionDepositoTemporal/fechaContable"/>
					</ns14:fechaPago>
					<ns14:codigoError>
						<xsl:value-of select="/msne:MensajeSalidaPagar/codigoError"/>
					</ns14:codigoError>
					<ns14:datosAdicionales>
						<xsl:call-template name="datosAdicionales"/>       
					</ns14:datosAdicionales>
					<ns14:referencia>
						<xsl:value-of select="/msne:MensajeSalidaPagar/informacionDepositoTemporal/secuencial"/>
					</ns14:referencia>
					<ns14:nombreCliente>
						<xsl:value-of select="/msne:MensajeSalidaPagar/informacionDepositoTemporal/nombre"/>
					</ns14:nombreCliente>
				</ns14:salidaEjecutarPago>
			</xsl:when>
			<xsl:otherwise>
				<ns14:salidaEjecutarPago>
					<ns14:codigoError>
						<xsl:value-of select="/msne:MensajeSalidaPagar/codigoError"/>
					</ns14:codigoError>      
					<ns14:mensajeUsuario>
						<xsl:value-of select="/msne:MensajeSalidaPagar/mensajeUsuario"/>
					</ns14:mensajeUsuario>     
				</ns14:salidaEjecutarPago>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="datosAdicionales">
		<ns14:datoAdicional>
			<codigo>01</codigo>
			<etiqueta>autorizacion</etiqueta>
			<valor>
				<xsl:value-of select="/msne:MensajeSalidaPagar/informacionDepositoTemporal/autorizacion"/>
			</valor>
			<visible>false</visible>
		</ns14:datoAdicional>
		<ns14:datoAdicional>
			<codigo>02</codigo>
			<etiqueta>autorizacionSRI</etiqueta>
			<valor>
				<xsl:value-of select="/msne:MensajeSalidaPagar/informacionDepositoTemporal/autorizacionSRI"/>
			</valor>
			<visible>false</visible>
		</ns14:datoAdicional>
		<ns14:datoAdicional>
			<codigo>03</codigo>
			<etiqueta>efectivoComision</etiqueta>
			<valor>
				<xsl:value-of select="/msne:MensajeSalidaPagar/informacionDepositoTemporal/efectivoComision"/>
			</valor>
			<visible>false</visible>
		</ns14:datoAdicional>
		<ns14:datoAdicional>
			<codigo>04</codigo>
			<etiqueta>comprobante</etiqueta>
			<valor>
				<xsl:value-of select="/msne:MensajeSalidaPagar/informacionDepositoTemporal/comprobante"/>
			</valor>
			<visible>false</visible>
		</ns14:datoAdicional>
		<ns14:datoAdicional>
			<codigo>05</codigo>
			<etiqueta>Valor a pagar del Dep&#243;sito Temporal</etiqueta>
			<valor><xsl:value-of select="format-number(/msne:MensajeSalidaPagar/informacionDepositoTemporal/datosOriginales, '0.00')"/></valor>
			<visible>true</visible>
		</ns14:datoAdicional>		
	</xsl:template>
</xsl:stylesheet>