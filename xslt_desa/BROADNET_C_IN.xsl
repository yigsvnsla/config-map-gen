<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:bpel="http://docs.oasis-open.org/wsbpel/2.0/process/executable" xmlns:bpm="http://xmlns.oracle.com/bpmn20/extensions" xmlns:bpws="http://schemas.xmlsoap.org/ws/2003/03/business-process/" xmlns:dvm="http://www.oracle.com/XSL/Transform/java/oracle.tip.dvm.LookupValue" xmlns:http="http://schemas.xmlsoap.org/wsdl/http/" xmlns:hwf="http://xmlns.oracle.com/bpel/workflow/xpath" xmlns:ids="http://xmlns.oracle.com/bpel/services/IdentityService/xpath" xmlns:ldap="http://schemas.oracle.com/xpath/extension/ldap" xmlns:mc="http://www.bolivariano.com/CashManagement/MensajesRecaudacionAgua" xmlns:med="http://schemas.oracle.com/mediator/xpath" xmlns:mhdr="http://www.oracle.com/XSL/Transform/java/oracle.tip.mediator.service.common.functions.MediatorExtnFunction" xmlns:mime="http://schemas.xmlsoap.org/wsdl/mime/" xmlns:ns0="http://www.bolivariano.com/dominio/Servicio" xmlns:ns1="http://www.bolivariano.com/dominio/DatoAdicional" xmlns:ns10="http://www.bolivariano.com/dominio/ListaSeleccion" xmlns:ns11="http://www.bolivariano.com/CashManagement/ws/RecaudacionAgua" xmlns:ns12="http://www.bolivariano.com/FormaPago" xmlns:ns13="http://www.bolivariano.com/MensajeBolivariano" xmlns:ns14="http://www.bolivariano.com/CoreBB" xmlns:ns15="http://www.bolivariano.com/Enumerados" xmlns:ns16="http://www.bolivariano.com/Comision" xmlns:ns17="http://www.bolivariano.com/Restricciones" xmlns:ns2="http://www.bolivariano.com/dominio/TipoMatriculacion" xmlns:ns3="http://www.bolivariano.com/dominio/FormaPago" xmlns:ns4="http://www.bolivariano.com/dominio/TipoIdentificador" xmlns:ns5="http://www.bolivariano.com/dominio/Convenio" xmlns:ns6="http://www.bolivariano.com/dominio/Recibo" xmlns:ns7="http://www.bolivariano.com/dominio/Empresa" xmlns:ns8="http://www.bolivariano.com/mensaje/MensajeOTC" xmlns:ns9="http://www.bolivariano.com/dominio/RegionalArea" xmlns:ora="http://schemas.oracle.com/xpath/extension" xmlns:oraext="http://www.oracle.com/XSL/Transform/java/oracle.tip.pc.services.functions.ExtFunc" xmlns:plnk="http://docs.oasis-open.org/wsbpel/2.0/plnktype" xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/" xmlns:socket="http://www.oracle.com/XSL/Transform/java/oracle.tip.adapter.socket.ProtocolTranslator" xmlns:tns="http://www.bolivariano.com/mensaje/MensajeOTC" xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/" xmlns:xdk="http://schemas.oracle.com/bpel/extension/xpath/function/xdk" xmlns:xp20="http://www.oracle.com/XSL/Transform/java/oracle.tip.pc.services.functions.Xpath20" xmlns:xref="http://www.oracle.com/XSL/Transform/java/oracle.tip.xref.xpath.XRefXPathFunctions" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="1.0" exclude-result-prefixes="xsi xsl ns1 soap wsdl ns5 ns6 ns10 ns9 ns0 ns2 ns3 ns4 tns xsd ns7 ns8 ns11 ns12 ns15 ns14 mime mc ns13 plnk ns17 http ns16 xp20 bpws bpel bpm ora socket mhdr oraext dvm hwf med ids xdk xref ldap">
   <xsl:output indent="yes" />
   <xsl:template match="/">
      <ns2:entradaConsultarDeuda xmlns:ns2="http://www.bolivariano.com/mensaje/MensajeOTC">
         <ns2:canal>
            <xsl:value-of select="/ns8:entradaConsultarDeuda/ns8:canal" />
         </ns2:canal>
         <ns2:depuracion>
            <xsl:value-of select="/ns8:entradaConsultarDeuda/ns8:depuracion" />
         </ns2:depuracion>
         <xsl:variable name="fecha" select="/ns8:entradaConsultarDeuda/ns8:servicio/datosAdicionales/datoAdicional[codigo = &quot;s_date&quot;]/valor" />
         <xsl:choose>
            <xsl:when test="$fecha">
               <ns2:fecha>
                  <xsl:value-of select="substring($fecha, 1,19)" />
               </ns2:fecha>
            </xsl:when>
            <xsl:otherwise>
               <ns2:fecha>
                  <xsl:value-of select="substring(/ns8:entradaConsultarDeuda/ns8:fecha, 1,19)" />
               </ns2:fecha>
            </xsl:otherwise>
         </xsl:choose>
         <ns2:oficina>
            <xsl:value-of select="/ns8:entradaConsultarDeuda/ns8:oficina" />
         </ns2:oficina>
         <xsl:variable name="secuencial" select="/ns8:entradaConsultarDeuda/ns8:servicio/datosAdicionales/datoAdicional[codigo = &quot;s_ssn&quot;]/valor" />
         <xsl:choose>
            <xsl:when test="$secuencial">
               <ns2:secuencial>
                  <xsl:value-of select="$secuencial" />
               </ns2:secuencial>
            </xsl:when>
            <xsl:otherwise>
               <ns2:secuencial>
                  <xsl:value-of select="/ns8:entradaConsultarDeuda/ns8:secuencial" />
               </ns2:secuencial>
            </xsl:otherwise>
         </xsl:choose>
         <nombreCliente>
            <xsl:value-of select="/ns8:entradaConsultarDeuda/ns8:nombreCliente" />
         </nombreCliente>
         <tipoCuenta>
            <xsl:value-of select="/ns8:entradaConsultarDeuda/ns8:tipoCuenta" />
         </tipoCuenta>
         <cuenta>
            <xsl:value-of select="/ns8:entradaConsultarDeuda/ns8:cuenta" />
         </cuenta>
         <ns2:servicio>
            <codTipoServicio>
               <xsl:value-of select="/ns8:entradaConsultarDeuda/ns8:servicio/codTipoServicio" />
            </codTipoServicio>
            <codigoConvenio>
               <xsl:value-of select="/ns8:entradaConsultarDeuda/ns8:servicio/codigoConvenio" />
            </codigoConvenio>
            <codigoEmpresa>
               <xsl:value-of select="/ns8:entradaConsultarDeuda/ns8:servicio/codigoEmpresa" />
            </codigoEmpresa>
            <codigoTipoBanca>
               <xsl:value-of select="/ns8:entradaConsultarDeuda/ns8:servicio/codigoTipoBanca" />
            </codigoTipoBanca>
            <codigoTipoIdentificador>
               <xsl:value-of select="/ns8:entradaConsultarDeuda/ns8:servicio/codigoTipoIdentificador" />
            </codigoTipoIdentificador>
            <identificador>
               <xsl:value-of select="/ns8:entradaConsultarDeuda/ns8:servicio/identificador" />
            </identificador>
            <datosAdicionales>
               <datoAdicional>
                  <codigo>s_fecha_contable</codigo>
                  <valor>
                     <xsl:value-of select="/ns8:entradaConsultarDeuda/ns8:servicio/datosAdicionales/datoAdicional[codigo = &quot;s_fecha_contable&quot;]/valor" />
                  </valor>
               </datoAdicional>
               <datoAdicional>
                  <codigo>e_rol</codigo>
                  <valor>
                     <xsl:value-of select="/ns8:entradaConsultarDeuda/ns8:servicio/datosAdicionales/datoAdicional[codigo = &quot;s_rol&quot;]/valor" />
                  </valor>
               </datoAdicional>
               <datoAdicional>
                  <codigo>e_mon</codigo>
                  <valor>1</valor>
               </datoAdicional>
               <datoAdicional>
                  <codigo>e_servicio</codigo>
                  <valor>
                     <xsl:value-of select="/ns8:entradaConsultarDeuda/ns8:servicio/datosAdicionales/datoAdicional[codigo = &quot;e_servicio&quot;]/valor" />
                  </valor>
               </datoAdicional>
               <datoAdicional>
                  <codigo>e_identificacion</codigo>
                  <valor>
                     <xsl:value-of select="/ns8:entradaConsultarDeuda/ns8:servicio/datosAdicionales/datoAdicional[codigo = &quot;e_identificacion&quot;]/valor" />
                  </valor>
               </datoAdicional>
               <datoAdicional>
                  <codigo>e_efectivo</codigo>
                  <valor>0.00</valor>
               </datoAdicional>
               <datoAdicional>
                  <codigo>e_debito</codigo>
                  <valor>0.00</valor>
               </datoAdicional>
               <datoAdicional>
                  <codigo>e_ubi</codigo>
                  <valor>
                     <xsl:value-of select="/ns8:entradaConsultarDeuda/ns8:servicio/datosAdicionales/datoAdicional[codigo = &quot;e_ubi&quot;]/valor" />
                  </valor>
               </datoAdicional>
            </datosAdicionales>
         </ns2:servicio>
         <ns2:transaccion>
            <xsl:value-of select="/ns8:entradaConsultarDeuda/ns8:transaccion" />
         </ns2:transaccion>
         <ns2:usuario>
            <xsl:value-of select="/ns8:entradaConsultarDeuda/ns8:usuario" />
         </ns2:usuario>
      </ns2:entradaConsultarDeuda>
   </xsl:template>
</xsl:stylesheet>