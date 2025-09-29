<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
xmlns:xsd1="http://www.bolivariano.com/MensajeEtapa"
xmlns:ns6="http://www.bolivariano.com/mensaje/MensajeOTC"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
exclude-result-prefixes="xsl xsd1 ns6">
  <xsl:template match="/">
    <xsd1:MensajeEntradaConsultar>
      <canal>
        <xsl:value-of select="/ns6:entradaConsultarDeuda/ns6:canal"/>
      </canal>	  
	  <xsl:choose>
        <xsl:when test="/ns6:entradaConsultarDeuda/ns6:canal = 'CNB'">
		  <depuracion>
			<xsl:value-of select='/ns6:entradaConsultarDeuda/ns6:depuracion'/>
		  </depuracion>
		  <fecha>
			<xsl:value-of select='/ns6:entradaConsultarDeuda/ns6:fecha'/>
		  </fecha>
        </xsl:when>
      </xsl:choose>
	  <oficina>0</oficina>  
	  <xsl:choose>
        <xsl:when test="/ns6:entradaConsultarDeuda/ns6:canal = 'CNB'">
		  <terminal>
			<xsl:value-of select='/ns6:entradaConsultarDeuda/ns6:servicio/datosAdicionales/datoAdicional[codigo = "s_term"]/valor'/>
		  </terminal>
        </xsl:when>
		<xsl:otherwise>
		  <terminal>
			<xsl:value-of select='/ns6:entradaConsultarDeuda/ns6:terminal'/>
		  </terminal>
		</xsl:otherwise>
      </xsl:choose>
      <transaccion>62642</transaccion>
      <usuario>
        <xsl:value-of select="/ns6:entradaConsultarDeuda/ns6:usuario"/>
      </usuario>
      <InformacionEtapa>
		<xsl:choose>
		  <xsl:when test="/ns6:entradaConsultarDeuda/ns6:canal = 'CNB'">
			<aplicativoCobis>
				<xsl:text disable-output-escaping="no">N</xsl:text>
			</aplicativoCobis>	
			<autorizacion>
				<xsl:text disable-output-escaping="no">N</xsl:text>
			</autorizacion>		
			<efectivo>
				<xsl:text disable-output-escaping="no">0</xsl:text>
			</efectivo>	
			<empresa>
			  <xsl:value-of select="/ns6:entradaConsultarDeuda/ns6:servicio/codigoEmpresa"/>
		    </empresa>	
			<operacionProceso/>
			<opcion>
			  <xsl:text disable-output-escaping="no">P</xsl:text>
		    </opcion>
			<tipoMoneda>
			  <xsl:text disable-output-escaping="no">1</xsl:text>
		    </tipoMoneda>
			<cuenta>
			  <rubroPerson>
				  <xsl:text disable-output-escaping="no">ETEL</xsl:text>
			  </rubroPerson>
			  <serviPerson>
				  <xsl:text disable-output-escaping="no">CSBA</xsl:text>
			  </serviPerson>
		    </cuenta>	
			<codigoDeuda>
			  <xsl:value-of select="/ns6:entradaConsultarDeuda/ns6:servicio/identificador"/>
		    </codigoDeuda>
		  </xsl:when>
		  <xsl:otherwise>
			<empresa>
			  <xsl:value-of select="/ns6:entradaConsultarDeuda/ns6:servicio/codigoEmpresa"/>
		    </empresa>	 	    
		    <codigoDeuda>
			  <xsl:value-of select="/ns6:entradaConsultarDeuda/ns6:servicio/identificador"/>
		    </codigoDeuda>
		  </xsl:otherwise>
		  
        </xsl:choose>
        
      </InformacionEtapa>
	  <InformacionCore>
	  <xsl:choose>
		<xsl:when test="/ns6:entradaConsultarDeuda/ns6:canal != 'CNB'">
		  
			<secuencial>
			  5645454
			</secuencial>
		  
		</xsl:when>
		<xsl:otherwise>
			<nomLogicoProg></nomLogicoProg>	 
			<origenError></origenError>	
			<origenTransaccion>
				<xsl:text disable-output-escaping="no">D</xsl:text>
			</origenTransaccion>
		    <rolBPM>
			  <xsl:value-of select='/ns6:entradaConsultarDeuda/ns6:servicio/datosAdicionales/datoAdicional[codigo = "s_rol"]/valor'/>
		    </rolBPM>
		    <secuencial>
			  <xsl:value-of select='/ns6:entradaConsultarDeuda/ns6:secuencial'/>
		    </secuencial>
		    <servidor>
			  <xsl:value-of select='/ns6:entradaConsultarDeuda/ns6:servicio/datosAdicionales/datoAdicional[codigo = "s_srv"]/valor'/>
		    </servidor>
		    <servidorLocal>
			  <xsl:value-of select='/ns6:entradaConsultarDeuda/ns6:servicio/datosAdicionales/datoAdicional[codigo = "s_lsrv"]/valor'/>
		    </servidorLocal>
			<sesion>
				<xsl:text disable-output-escaping="no">0</xsl:text>
			</sesion>
		</xsl:otherwise>
      </xsl:choose>
	  </InformacionCore>
	  <xsl:if test="/ns6:entradaConsultarDeuda/ns6:canal = 'CNB' ">
        <CNB>
          <tipoTransaccion>C</tipoTransaccion>
        </CNB>
      </xsl:if>
    </xsd1:MensajeEntradaConsultar>
  </xsl:template>
</xsl:stylesheet>
