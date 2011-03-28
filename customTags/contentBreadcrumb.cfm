<!--- contentBreadcrumb.cfm --->
<cfprocessingdirective suppresswhitespace="yes">
<cfparam name="attributes.method" type="string" default="list" />
<cfparam name="attributes.new" type="boolean" default="false" />
<cfparam name="attributes.content" type="any" default="" />
<cfset new = attributes.new />
<cfset content = attributes.content />
<cfset method = attributes.method />

<cfoutput><p class="breadcrumb">
	<a href="index.cfm">Main</a> / 
		<a href="content.cfm?method=list">List</a> /
		<cfif CompareNoCase(method, "read") eq 0>
		<a href="content.cfm?method=edit&amp;id=#content.getid()#">Edit</a> /
		<a href="content.cfm?method=clone&amp;id=#content.getid()#&amp;message=clone">Clone</a> /
		</cfif>
		<cfif CompareNoCase(method, "edit") eq 0 and not new>
		<a href="content.cfm?method=read&amp;id=#content.getid()#">Read</a> /
		<a href="content.cfm?method=clone&amp;id=#content.getid()#&amp;message=clone">Clone</a> /
		</cfif>
	<a href="content.cfm?method=edit">New</a>
</p></cfoutput>

</cfprocessingdirective>
<cfexit method="exitTag" />