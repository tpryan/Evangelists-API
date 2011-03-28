<!--- contentSearch.cfm --->
<cfprocessingdirective suppresswhitespace="yes">
<cfparam name="attributes.q" type="string" default="" />
<cfoutput>
<cfform action="" method="get" format="html" >
<input name="method" type="hidden" value="searchresult" />
<input name="q" type="text" id="q" value="#attributes.q#" />
<input name="message" type="submit" value="Search" />
</cfform>
</cfoutput>
</cfprocessingdirective>
<cfexit method="exitTag" />