<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                xmlns:tns="http://www.bolivariano.com/ws/OTCService"
                xmlns:mcr="http://www.bolivariano.com/MensajeEtapa"
                xmlns:ns6="http://www.bolivariano.com/mensaje/MensajeOTC"
                exclude-result-prefixes="xsl tns mcr ns6"
                xmlns:xs="http://www.w3.org/2001/XMLSchema">
  <xsl:template match="/">
    <mcr:MensajeEntradaPagar>
      <canal>
        <xsl:value-of select="/ns6:entradaEjecutarPago/ns6:canal"/>
      </canal>
      <oficina>
        <xsl:value-of select='/ns6:entradaEjecutarPago/ns6:datosAdicionales/ns6:datoAdicional[codigo = "s_ofi"]/valor'/>
      </oficina>
      <terminal>
        <xsl:value-of select='/ns6:entradaEjecutarPago/ns6:datosAdicionales/ns6:datoAdicional[codigo = "s_term"]/valor'/>
      </terminal>
      <transaccion>
        <xsl:text disable-output-escaping="no">62643</xsl:text>
      </transaccion>
      <usuario>
      <xsl:value-of select='/ns6:entradaEjecutarPago/ns6:datosAdicionales/ns6:datoAdicional[codigo = "s_user"]/valor'/>
      </usuario>
      <InformacionEtapa>
        <aplicativoCobis> 
	  <xsl:choose>
	    <xsl:when test="/ns6:entradaEjecutarPago/ns6:canal = 'CNB'">
		<xsl:text disable-output-escaping="no">S</xsl:text>
	    </xsl:when>
	    <xsl:otherwise>
	    	<xsl:text disable-output-escaping="no">N</xsl:text>
	    </xsl:otherwise>
          </xsl:choose>
        </aplicativoCobis>
        <cantidadCheque>0</cantidadCheque>
        <chequeComision>0.00</chequeComision>
        <debito>
          <xsl:choose>
			<xsl:when test="/ns6:entradaEjecutarPago/ns6:canal = 'CNB' and /ns6:entradaEjecutarPago/ns6:datosAdicionales/ns6:datoAdicional[codigo = 'p_forma_pago']/valor = 'EFE'">
				<xsl:text disable-output-escaping="no">0</xsl:text>
			</xsl:when>
                <xsl:when test="/ns6:entradaEjecutarPago/ns6:datosAdicionales/ns6:datoAdicional[codigo = 'MPA_TC']">
                    <xsl:text disable-output-escaping="no">0</xsl:text>
                </xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="/ns6:entradaEjecutarPago/ns6:valorPago"/>
			</xsl:otherwise>
		  </xsl:choose>		  
        </debito>
        <debitoComision>
			<xsl:choose>
			<xsl:when test="/ns6:entradaEjecutarPago/ns6:canal = 'CNB' and /ns6:entradaEjecutarPago/ns6:datosAdicionales/ns6:datoAdicional[codigo = 'p_forma_pago']/valor = 'EFE'">
				<xsl:text disable-output-escaping="no">0</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="/ns6:entradaEjecutarPago/ns6:valorComision"/>
			</xsl:otherwise>
		  </xsl:choose>          
        </debitoComision>
        <efectivo>
			<xsl:choose>
				<xsl:when test="/ns6:entradaEjecutarPago/ns6:canal = 'CNB' and /ns6:entradaEjecutarPago/ns6:datosAdicionales/ns6:datoAdicional[codigo = 'p_forma_pago']/valor = 'EFE'">
					<xsl:value-of select="/ns6:entradaEjecutarPago/ns6:valorPago"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text disable-output-escaping="no">0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>			
		</efectivo>
        <efectivoComision>
				<xsl:choose>
				<xsl:when test="/ns6:entradaEjecutarPago/ns6:canal = 'CNB' and /ns6:entradaEjecutarPago/ns6:datosAdicionales/ns6:datoAdicional[codigo = 'p_forma_pago']/valor = 'EFE'">
					<xsl:value-of select="/ns6:entradaEjecutarPago/ns6:valorComision"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text disable-output-escaping="no">0</xsl:text>
				</xsl:otherwise>
				</xsl:choose>
		</efectivoComision>
        <empresa>
	  
	  <xsl:choose>
	    <xsl:when test="/ns6:entradaEjecutarPago/ns6:canal = 'CNB'">
    <xsl:value-of select='/ns6:entradaEjecutarPago/ns6:datosAdicionales/ns6:datoAdicional[codigo = "p_codigoEmpresa"]/valor'/>	      
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:value-of select="/ns6:entradaEjecutarPago/ns6:servicio/codigoEmpresa"/>
	    </xsl:otherwise>
          </xsl:choose>
        </empresa>
        <entidad>
          <xsl:text disable-output-escaping="no">BEBOLIVARI</xsl:text>
        </entidad>
        <nombre>
	  <xsl:choose>
	    <xsl:when test="/ns6:entradaEjecutarPago/ns6:canal = 'CNB'">
		<xsl:value-of select="/ns6:entradaEjecutarPago/ns6:nombreCliente"/> 
	    </xsl:when>
	    <xsl:otherwise>
	    	<xsl:value-of select='/ns6:entradaEjecutarPago/ns6:datosAdicionales/ns6:datoAdicional[codigo = "nombreCli"]/valor'/>
	    </xsl:otherwise>
          </xsl:choose>
        </nombre>
        <suministro>
          <xsl:value-of select="/ns6:entradaEjecutarPago/ns6:servicio/identificador"/>
        </suministro>
        <tipoCanal>
          <xsl:text disable-output-escaping="no">BELE</xsl:text>
        </tipoCanal>
        <tipoMoneda>
            <xsl:text disable-output-escaping="no">1</xsl:text>
        </tipoMoneda>
        <tipoPago>DCA</tipoPago>
        <!--TODO validar parametro-->
        <ubicacion>0</ubicacion>
        <!--TODO validar parametro-->
        <valorCheque>0.00</valorCheque>
        <valorComision>
          <xsl:value-of select="/ns6:entradaEjecutarPago/ns6:valorComision"/>
        </valorComision>

          <valorTotalCancelar>
            <xsl:value-of select="/ns6:entradaEjecutarPago/ns6:valorPago + /ns6:entradaEjecutarPago/ns6:valorComision"/>
          </valorTotalCancelar>
        
        <cuenta>
          <cuenta>
            <xsl:value-of select="/ns6:entradaEjecutarPago/ns6:cuenta"/>
          </cuenta>
          <tipoCuenta>
            <xsl:value-of select="/ns6:entradaEjecutarPago/ns6:tipoCuenta"/>
          </tipoCuenta>
        </cuenta>

          <xsl:if test='/ns6:entradaEjecutarPago/ns6:datosAdicionales/ns6:datoAdicional[codigo = "MPA_TC"]'>
              <formaPago>
                  <tarjeta>
                      <tarjeta>
                          <xsl:value-of select='/ns6:entradaEjecutarPago/ns6:datosAdicionales/ns6:datoAdicional[codigo = "MPA_TC"]/valor'/>
                      </tarjeta>
                      <valor>
                          <xsl:value-of select="format-number(/ns6:entradaEjecutarPago/ns6:valorPago,'0.00')"/>
                      </valor>
                      <valorComision>
                          <xsl:value-of select="format-number(/ns6:entradaEjecutarPago/ns6:valorComision,'0.00')"/>
                      </valorComision>
                      <mesesDiferido>
                          <xsl:value-of select='/ns6:entradaEjecutarPago/ns6:datosAdicionales/ns6:datoAdicional[codigo = "FPA_TC"]/valor'/>
                      </mesesDiferido>
                  </tarjeta>
              </formaPago>
          </xsl:if>

        <identificadorDeuda>
          <xsl:value-of select='/ns6:entradaEjecutarPago/ns6:datosAdicionales/ns6:datoAdicional[codigo = "identificadorDeuda"]/valor'/>
        </identificadorDeuda>
        <xsl:choose>
	    <xsl:when test="/ns6:entradaEjecutarPago/ns6:canal = 'CNB'">
	<deudaActual>
  <xsl:value-of select='format-number(/ns6:entradaEjecutarPago/ns6:datosAdicionales/ns6:datoAdicional[codigo = "deudaActual"]/valor  * 100, "0")'/>
        </deudaActual>
	    </xsl:when>
	    <xsl:otherwise>
	    	        <deudaActual>
        <xsl:value-of select='/ns6:entradaEjecutarPago/ns6:datosAdicionales/ns6:datoAdicional[codigo = "deudaActual"]/valor'/>
        
        </deudaActual>
	    </xsl:otherwise>
    </xsl:choose>

      </InformacionEtapa>
      <InformacionCore>
        <!--TODO se obtienen desde paratros no cobis-->
        <modoCorreccion>
          <xsl:text disable-output-escaping="no">N</xsl:text>
        </modoCorreccion>
        <rolBPM>
          <xsl:value-of select='/ns6:entradaEjecutarPago/ns6:datosAdicionales/ns6:datoAdicional[codigo = "s_rol"]/valor'/>
        </rolBPM>
        <secuencial>
          <xsl:value-of select='/ns6:entradaEjecutarPago/ns6:datosAdicionales/ns6:datoAdicional[codigo = "s_ssn"]/valor'/>
        </secuencial>
        <servidor>
          <xsl:value-of select='/ns6:entradaEjecutarPago/ns6:datosAdicionales/ns6:datoAdicional[codigo = "s_srv"]/valor'/>
        </servidor>
      </InformacionCore>
	  	<xsl:if test="/ns6:entradaEjecutarPago/ns6:canal = 'CNB'">
			<CNB>
				<autorizacion>
					 <xsl:value-of select='/ns6:entradaEjecutarPago/ns6:datosAdicionales/ns6:datoAdicional[codigo = "p_autorizacionCNB"]/valor'/>
				</autorizacion>
				<comercio>
					 <xsl:value-of select='/ns6:entradaEjecutarPago/ns6:datosAdicionales/ns6:datoAdicional[codigo = "p_comercio"]/valor'/>
				</comercio>		
					
				<terminalID>
					  <xsl:value-of select='/ns6:entradaEjecutarPago/ns6:datosAdicionales/ns6:datoAdicional[codigo = "p_terminalID"]/valor'/>
				</terminalID>
				<agencia>
					 <xsl:value-of select='/ns6:entradaEjecutarPago/ns6:datosAdicionales/ns6:datoAdicional[codigo = "p_agencia"]/valor'/>
				</agencia>		
				<red>
					 <xsl:value-of select='/ns6:entradaEjecutarPago/ns6:datosAdicionales/ns6:datoAdicional[codigo = "p_red"]/valor'/>
				</red>
				<secuencial>
					<xsl:value-of select='/ns6:entradaEjecutarPago/ns6:datosAdicionales/ns6:datoAdicional[codigo = "s_ssn"]/valor'/>
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
						 <formaPago>
							<xsl:value-of select='/ns6:entradaEjecutarPago/ns6:datosAdicionales/ns6:datoAdicional[codigo = "p_forma_pago"]/valor'/>
						</formaPago>
						          <empresa>
              <xsl:value-of select='/ns6:entradaEjecutarPago/ns6:datosAdicionales/ns6:datoAdicional[codigo = "p_codigoEmpresa"]/valor'/>
          </empresa>
		  </CNB>		
		</xsl:if>
    </mcr:MensajeEntradaPagar>
  </xsl:template>
</xsl:stylesheet>
