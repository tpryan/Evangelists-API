<cfsetting showdebugoutput="false" />
<cfparam name="url.method" type="string" default="list" />
<cfparam name="url.id" type="any" default="0" />
<cfparam name="url.orderby" type="string" default="id asc" />
<cfparam name="url.message" type="string" default="" />
<cfparam name="url.offset" type="numeric" default="0" />
<cfparam name="url.maxresults" type="numeric" default="10" />
<cfparam name="url.q" type="string" default="" />
<cfimport path="Evangelists.cfc.*" />
<cf_pageWrapper>

<h2>Content</h2>

<cfswitch expression="#url.method#" >

	<cfcase value="list">
		<cfset contentArray = application.contentService.listPaged(url.offset, url.maxresults, url.orderby ) />
		<cfset totalCount = application.contentService.count() />
		<cf_contentBreadcrumb method="list"/>
		<cf_contentSearch q="#url.q#" />
		<cf_contentList orderby="#url.orderby#" contentArray = "#contentArray#" message="#url.message#" offset="#url.offset#" maxresults="#url.maxresults#" totalCount="#totalCount#" /> 
	</cfcase>

	<cfcase value="searchresult">
		<cfset contentArray = application.contentService.searchPaged(url.q, url.offset, url.maxresults, url.orderby ) />
		<cfset totalCount = application.contentService.searchCount(url.q) />
		<cf_contentBreadcrumb method="list"/>
		<cf_contentSearch q="#url.q#" />
		<cf_contentList method="searchresult" q="#url.q#" orderby="#url.orderby#" contentArray = "#contentArray#" message="#url.message#" offset="#url.offset#" maxresults="#url.maxresults#"  totalCount="#totalCount#" /> 
	</cfcase>

	<cfcase value="read">
		<cfset content = application.contentService.get(url.id) />
		<cf_contentBreadcrumb method="read" content = "#content#"/>
		<cf_contentSearch q="#url.q#" />
		<cf_contentRead content = "#content#" /> 
	</cfcase>

	<cfcase value="edit">
		<cfif url.id eq 0>
			<cfset content = New content() />
			<cfset new = true />
		<cfelse>
			<cfset content = application.contentService.get(url.id) />
			<cfset new = false />
		</cfif>
		<cf_contentBreadcrumb method="edit" content = "#content#"  new="#new#" /> 

		<cf_contentEdit content = "#content#" message="#url.message#" /> 
	</cfcase>

	<cfcase value="clone">
		<cfset ref = application.contentService.get(url.id) />
		<cfset content = entityNew("content") />
		<cfset content.setguid(ref.getguid())  />
		<cfset content.setlink(ref.getlink())  />
		<cfset content.setauthor(ref.getauthor())  />
		<cfset content.setpublished(ref.getpublished())  />
		<cfset content.setsource(ref.getsource())  />
		<cfset content.settitle(ref.gettitle())  />
		<cfset content.setdescription(ref.getdescription())  />
		<cfset content.settags(ref.gettags())  />

		<cf_contentBreadcrumb method="new" content = "#content#"  new="true" /> 

		<cf_contentEdit content = "#content#" message="#url.message#" /> 
	</cfcase>

	<cfcase value="edit_process">
		<cfset content = EntityNew("content") />
		<cfset content = content.populate(form) />
		<cfset application.contentService.update(content) />
		<cfset ORMFlush() />
		<cflocation url ="#cgi.script_name#?method=edit&id=#content.getid()#&message=updated" />
	</cfcase>

	<cfcase value="delete_process">
			<cfset content = application.contentService.get(url.id) />
		<cfset application.contentService.destroy(content) />
		<cfset ORMFlush() />
		<cflocation url ="#cgi.script_name#?method=list&message=deleted" />
	</cfcase>

</cfswitch>
</cf_pageWrapper>