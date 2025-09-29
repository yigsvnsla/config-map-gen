<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:msne="http://www.bolivariano.com/MensajeDepositoTemporal"
                xmlns:ns14="http://www.bolivariano.com/mensaje/MensajeOTC"
                exclude-result-prefixes="xsl ns14">
	<xsl:template match="/">
		<xsl:choose>
			<xsl:when test="/msne:MensajeSalidaConsultar/codigoError='0'">
				<ns14:salidaConsultarDeuda>
					<ns14:codigoError>
						<xsl:value-of select="/msne:MensajeSalidaConsultar/codigoError"/>
					</ns14:codigoError>
					<ns14:datosAdicionales>
						<xsl:call-template name="datosAdicionales"/>
					</ns14:datosAdicionales>      
					<xsl:choose>
						<xsl:when test="string(number(/msne:MensajeSalidaConsultar/informacionDepositoTemporal/declaracion))!='NaN'">
							<ns14:formaPago>ABONO</ns14:formaPago>
						</xsl:when>
						<xsl:otherwise>
							<ns14:formaPago>TOTAL</ns14:formaPago>
						</xsl:otherwise>
					</xsl:choose>
					<ns14:montoTotal>
            <xsl:value-of select="format-number(/msne:MensajeSalidaConsultar/informacionDepositoTemporal/valorTotal, '0.00')"/>
					</ns14:montoTotal>
					<ns14:nombreCliente>
						<xsl:value-of select="/msne:MensajeSalidaConsultar/informacionDepositoTemporal/nombre"/>
					</ns14:nombreCliente>
				</ns14:salidaConsultarDeuda>
			</xsl:when>
			<xsl:otherwise>
				<ns14:salidaConsultarDeuda>
					<ns14:codigoError>
						<xsl:value-of select="/msne:MensajeSalidaConsultar/codigoError"/>
					</ns14:codigoError>
					<ns14:mensajeUsuario>
						<xsl:value-of select="/msne:MensajeSalidaConsultar/mensajeUsuario"/>
					</ns14:mensajeUsuario>               
				</ns14:salidaConsultarDeuda>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="datosAdicionales">
		<ns14:datoAdicional>
			<codigo>codigoProveedor</codigo>
			<etiqueta>codigoProveedor</etiqueta>	
			<valor>
				<xsl:value-of select="/msne:MensajeSalidaConsultar/informacionDepositoTemporal/codigoProveedor"/>
			</valor>
			<visible>false</visible>
		</ns14:datoAdicional>   
		<ns14:datoAdicional>
			<codigo>02</codigo>
			<etiqueta>identificacion</etiqueta>
			<valor>
				<xsl:value-of select="/msne:MensajeSalidaConsultar/informacionDepositoTemporal/identificacion"/>
			</valor>
			<visible>false</visible>
		</ns14:datoAdicional>
		<ns14:datoAdicional>
			<codigo>03</codigo>
			<etiqueta>referencia</etiqueta>
			<valor>
				<xsl:value-of select="/msne:MensajeSalidaConsultar/informacionDepositoTemporal/referencia"/>
			</valor>
			<visible>false</visible>
		</ns14:datoAdicional>  
		<ns14:datoAdicional>
			<codigo>04</codigo>
			<etiqueta>efectivoComision</etiqueta>
			<valor>
				<xsl:value-of select="format-number(/msne:MensajeSalidaConsultar/informacionDepositoTemporal/efectivoComision,'0.00')"/>
			</valor>
			<visible>false</visible>
		</ns14:datoAdicional>
		<ns14:datoAdicional>
			<codigo>05</codigo>
			<etiqueta>valorDeuda</etiqueta>
			<valor>
        <xsl:value-of select="format-number(/msne:MensajeSalidaConsultar/informacionDepositoTemporal/valorTotal, '0.00')"/>
			</valor>
			<visible>false</visible>
		</ns14:datoAdicional>          
	</xsl:template>
</xsl:stylesheet>