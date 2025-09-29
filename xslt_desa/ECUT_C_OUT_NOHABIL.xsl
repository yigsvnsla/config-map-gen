<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:men="http://www.bolivariano.com/mensaje/MensajeOTC"
                exclude-result-prefixes="java">
  <xsl:template match="/">
    <men:salidaConsultarDeuda>
      <men:codigoError>9999</men:codigoError>
      <men:mensajeUsuario>TRANSACCION NO PERMITIDA EN ESTE MOMENTO</men:mensajeUsuario>
    </men:salidaConsultarDeuda>
  </xsl:template>
</xsl:stylesheet>
