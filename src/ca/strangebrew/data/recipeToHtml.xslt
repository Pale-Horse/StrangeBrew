<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml">

	<xsl:output
		method="xml"
		indent="yes"
		omit-xml-declaration="yes"
		doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
		encoding="UTF-8"/>

	<xsl:template match="/STRANGEBREWRECIPE">
		<html lang="en" xml:lang="en">
			<head>
				<title>Strangebrew Recipe</title>
				<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
				<meta name="description" content="Generated by Strangebrew Java" />
				<style type="text/css" media="all">
					body,th,td{font-family:Verdana,"Bitstream Vera Sans",Arial,sans-serif;font-size:14px;}
					h1{text-align:center;}
					table{margin-bottom:1em;width:100%;border-collapse:collapse;}
					th,td{padding:0.2em;border:1px solid #000;}
					thead th{text-align:center;background-color:#CCC;}
					tbody th{text-align:left;}
					tbody tr.even,table.vertical tbody td{background-color:#EEE;}
					#meta{margin-bottom:2em;}
					#author{margin-bottom:0;}
				</style>
				<style type="text/css" media="print">
					body,th,td{font-family:Georgia,"Bitstream Vera Serif","Times New Roman",serif;font-size:11pt;}
					table{page-break-inside:avoid;}
					<xsl:apply-templates select="PRINT"/>
					a{color:#000;text-decoration:none;}
					a:after{content:" [" attr(href) "]";}
					abbr{border-width:0;}
				</style>
			</head>
			<body>
				<xsl:apply-templates select="DETAILS"/>
				<xsl:apply-templates select="FERMENTABLES"/>
				<xsl:apply-templates select="MASH"/>
				<table>
					<thead>
						<tr>
							<th colspan="7">Flavor Addition Schedule</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th>Name</th>
							<th>Quantity</th>
							<th>Form</th>
							<th>Alpha</th>
							<th>Stage</th>
							<th>Time</th>
						</tr>
						<xsl:apply-templates select="HOPS"/>
						<xsl:apply-templates select="MISC"/>	
			 			<tr>
							<th>Hop totals:</th>
							<th>
							<xsl:value-of select="HOPS/TOTAL"/>
							<xsl:text> </xsl:text>
							<xsl:value-of select="DETAILS/HOPS_UNITS"/>
						</th>
						<th></th>
						<th><xsl:value-of select="DETAILS/IBU"/></th>
						<th></th>
						<th></th>
					</tr>	
					</tbody>
				</table>

				<table>
					<thead>
						<tr>
							<th colspan="4">Fermentation Schedule</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th>Yeast</th>
							<td><xsl:value-of select="DETAILS/YEAST"/></td>
							<th>Fermentation temperature</th>
							<td><xsl:value-of select="DETAILS/FERMENTATION_TEMP"/></td>
						</tr>
					</tbody>
				</table>
				<div id="footer">Produced by <a href="http://sourceforge.net/projects/strangebrew">Strangebrew Java</a> version <xsl:value-of select="STRANGEBREWRECIPE/@version"/>.</div>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="DETAILS">
		<h1><xsl:value-of select="NAME"/></h1>
		<div id="meta">
			<h3 id="author">Created by <xsl:value-of select="BREWER"/> on <xsl:value-of select="RECIPE_DATE"/></h3>
			<xsl:apply-templates select="NOTES"/>
		</div>
		<table class="vertical">
			<thead>
				<tr>
					<th colspan="8">Brew Target Statistics</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th>Style</th>
					<td><xsl:value-of select="STYLE"/></td>
					<th>Efficiency</th>
					<td>
						<xsl:value-of select="EFFICIENCY"/>
						<xsl:text> %</xsl:text>
					</td>
					<th>Pre-boil Volume</th>
					<td>
						<xsl:value-of select="format-number(PRESIZE, '#.00')"/>
						<xsl:text> </xsl:text>
						<xsl:value-of select="SIZE_UNITS"/>
					</td>
					<th><abbr title="Original Gravity">OG</abbr></th>
					<td><xsl:value-of select="format-number(OG, '#.000')"/></td>
				</tr>
				<tr>
					<th><abbr title="International Bittering Unit">IBU</abbr></th>
					<td><xsl:value-of select="IBU"/></td>
					<th>Mash Ratio</th>
					<td>
						<xsl:value-of select="/STRANGEBREWRECIPE/MASH/MASH_RATIO"/>
						<xsl:text> </xsl:text>
						<xsl:value-of select="/STRANGEBREWRECIPE/MASH/MASH_RATIO_U"/>
					</td>
					<th>Post-boil Volume</th>
					<td>
						<xsl:value-of select="format-number(SIZE, '#.00')"/>
						<xsl:text> </xsl:text>
						<xsl:value-of select="SIZE_UNITS"/>
					</td>
					<th><abbr title="Final Gravity">FG</abbr></th>
					<td><xsl:value-of select="format-number(FG, '#.000')"/></td>
				</tr>
				<tr>
					<th><abbr title="Standard Reference Model (color scale)">SRM</abbr></th>
					<td><xsl:value-of select="LOV"/></td>
					<th>Mash Time</th>
					<td>
						<xsl:value-of select="/STRANGEBREWRECIPE/MASH/MASH_TIME"/>
						<xsl:text> min</xsl:text>
					</td>
					<th>Boil Time</th>
					<td><xsl:value-of select="BOIL_TIME"/><xsl:text> min</xsl:text></td>
					<th>Attenuation</th>
					<td><xsl:value-of select="ATTENUATION"/><xsl:text> %</xsl:text></td>
				</tr>
				<tr>
					<th><abbr title="Alcohol By Volume">ABV</abbr></th>
					<td><xsl:value-of select="ALC"/><xsl:text> %</xsl:text></td>
					<th>Liquor Temp. Loss</th>
					<td>
						<xsl:value-of select="/STRANGEBREWRECIPE/MASH/MASH_TUNLOSS_TEMP"/>
						<xsl:text> </xsl:text>
						<xsl:value-of select="/STRANGEBREWRECIPE/MASH/MASH_TMP_U"/>
					</td>
					<th>Evaporation</th>
					<td><xsl:value-of select="format-number(EVAP, '##.#')"/> gallons</td>
					<th></th>
					<td></td>
				</tr>
			</tbody>
		</table>
	</xsl:template>

	<xsl:template match="NOTES">
		<div id="notes"><xsl:value-of select="."/><xsl:text> </xsl:text></div>
	</xsl:template>

	<xsl:template match="FERMENTABLES">
		<table xmlns="http://www.w3.org/1999/xhtml">
			<thead>
				<tr>
					<th colspan="6">Fermentables</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th>Name</th>
					<th>Quantity</th>
					<th>Percent</th>
					<th>Extract Potential</th>
					<th><xsl:value-of select="/STRANGEBREWRECIPE/DETAILS/COLOUR_METHOD"/></th>
					<th>Method</th>
				</tr>
				<xsl:for-each select="ITEM">
					<tr>
						<xsl:if test="(position() mod 2 = 0)">
							<xsl:attribute name="class">even</xsl:attribute>
						</xsl:if>
						<td><xsl:value-of select="MALT"/></td>
						<td>
							<xsl:value-of select="format-number(AMOUNT, '#0.##')"/>
							<xsl:text> </xsl:text>
							<xsl:value-of select="UNITS"/>
						</td>
						<td>
							<xsl:value-of select="format-number(PERCENT, '#0.#')"/>
							<xsl:text> %</xsl:text>
						</td>
						<td><xsl:value-of select="format-number(POINTS, '#.000')"/>/lb/gal</td>
						<td><xsl:value-of select="format-number(LOV, '#0.#')"/></td>
						<td>
							<xsl:if test="MASHED='true'">Mash</xsl:if>
							<xsl:if test="STEEPED='true'">Steep</xsl:if>
						</td>
					</tr>
				</xsl:for-each>
				<tr>
					<th>Totals:</th>
					<th>
						<xsl:value-of
							select="format-number(TOTAL, '#0.##')"/>
						<xsl:text>
						</xsl:text>
						<xsl:value-of
							select="/STRANGEBREWRECIPE/DETAILS/MALT_UNITS"/>
					</th>
					<th>100%</th>
					<th>
						<xsl:value-of
							select="format-number(/STRANGEBREWRECIPE/DETAILS/OG, '#.000')"/>
					</th>
					<th>
						<xsl:value-of
							select="/STRANGEBREWRECIPE/DETAILS/LOV"/>
					</th>
					<th></th>
					
				</tr>
				
			</tbody>
		</table>
	</xsl:template>

	<xsl:template match="HOPS">
		<xsl:for-each select="ITEM">
			<tr>
				<xsl:if test="(position() mod 2 = 0)">
					<xsl:attribute name="class">even</xsl:attribute>
				</xsl:if>
				<td><xsl:value-of select="HOP"/></td>
				<td>
					<xsl:value-of select="format-number(AMOUNT, '#0.##')"/>
					<xsl:text> </xsl:text>
					<xsl:value-of select="UNITS"/>
				</td>
				<td><xsl:value-of select="FORM"/></td>
				<td><xsl:value-of select="ALPHA"/></td>
				<td><xsl:value-of select="ADD"/></td>
				<td><xsl:value-of select="TIME"/></td>
			</tr>
		</xsl:for-each>

	</xsl:template>

	<xsl:template match="STRANGEBREWRECIPE/MASH">
		<xsl:variable name="tempUnits" select="MASH_TMP_U"/>
		<table>
			<thead>
				<tr>
					<th colspan="7">Mash Schedule</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th>Type</th>
					<th>Start Temp</th>
					<th>End Temp</th>
					<th>Method</th>
					<th>Ramp Minutes</th>
					<th>Step Minutes</th>
					<th>Instructions</th>
				</tr>
				<xsl:for-each select="ITEM">
					<tr>
						<xsl:if test="(position() mod 2 = 0)">
							<xsl:attribute name="class">even</xsl:attribute>
						</xsl:if>
						<td><xsl:value-of select="TYPE"/></td>
						<td>
							<xsl:value-of select="format-number(TEMP, '#.#')"/>
							<xsl:text> </xsl:text>
							<xsl:copy-of select="$tempUnits"/>
						</td>
						<td>
							<xsl:value-of select="format-number(END_TEMP, '#.#')"/>
							<xsl:text> </xsl:text>
							<xsl:copy-of select="$tempUnits"/>
						</td>
						<td><xsl:value-of select="METHOD"/></td>
						<td><xsl:value-of select="RAMP_MIN"/></td>
						<td><xsl:value-of select="MIN"/></td>
						<td><xsl:value-of select="DIRECTIONS"/></td>
					</tr>
				</xsl:for-each>
			</tbody>
		</table>
	</xsl:template>

	<xsl:template match="MISC">
		<xsl:for-each select="ITEM">
			<tr>
				<xsl:if test="(position() mod 2 = 0)">
					<xsl:attribute name="class">even</xsl:attribute>
				</xsl:if>
				<td><xsl:value-of select="NAME"/></td>
				<td>
					<xsl:value-of select="format-number(AMOUNT, '#0.##')"/>
					<xsl:text> </xsl:text>
					<xsl:value-of select="UNITS"/>
				</td>
				<td></td>
				<td></td>
				<td><xsl:value-of select="STAGE"/></td>
				<td><xsl:value-of select="TIME"/></td>
			</tr>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="PRINT">
		body,th,td{font-size:<xsl:value-of select="@FONTSIZE"/>;font-family:"<xsl:value-of select="@FONTFACE"/>";}
	</xsl:template>

</xsl:stylesheet>
