<?xml version="1.0"?>

<!-- darcs-to-simple.txt - - convert a darcs log XML format to a
     simple text file, with just the hash and the patch name -->

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/changelog">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="patch">
    <xsl:value-of select="@hash"/>
    <xsl:text> </xsl:text>
    <xsl:value-of select="name"/>
  </xsl:template>

</xsl:stylesheet>
