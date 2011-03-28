<!--- contentList.cfm --->
<cfprocessingdirective suppresswhitespace="yes">
<cfparam name="attributes.contentArray" type="array" />
<cfparam name="attributes.maxresults" type="numeric" default="-1" />
<cfparam name="attributes.offset" type="numeric" default="-1" />
<cfparam name="attributes.orderby" type="string" default="" />
<cfparam name="attributes.q" type="string" default="" />
<cfparam name="attributes.method" type="string" default="list" />
<cfparam name="attributes.totalCount" type="numeric" default="0" />

<cfset contentCount = attributes.totalCount  />
<cfset prevOffset = attributes.offset - attributes.maxresults />
<cfset nextOffset = attributes.offset + attributes.maxresults />
<cfset pages = Ceiling(contentCount / attributes.maxresults) />


<cfset message = attributes.message /> 
<cfif CompareNoCase(message, "deleted") eq 0>
	<p class="alert">Record deleted</p>
<cfelseif CompareNoCase(message, "search") eq 0>
	<p class="alert">Results for <em>"<cfoutput>#attributes.q#</cfoutput>"</em></p>
<cfelse>
	<p></p>
</cfif>
<cfoutput>
<table>
	<thead>
		<tr>
			<!--- Header for id --->
			<cfset idascOrDesc = (FindNoCase("id asc", url.orderby))? "desc" : "asc" />
			<cfset idascOrDescIcon = (FindNoCase("id asc", url.orderby))? "&darr;" : "&uarr;" />
			<th><a href="?method=#attributes.method#&amp;offset=#attributes.offset#&amp;maxresults=#attributes.maxresults#&amp;orderby=id #idascOrDesc#&amp;q=#attributes.q#">Id #idascOrDescIcon#</a></th>

			<!--- Header for guid --->
			<cfset guidascOrDesc = (FindNoCase("guid asc", url.orderby))? "desc" : "asc" />
			<cfset guidascOrDescIcon = (FindNoCase("guid asc", url.orderby))? "&darr;" : "&uarr;" />
			<th><a href="?method=#attributes.method#&amp;offset=#attributes.offset#&amp;maxresults=#attributes.maxresults#&amp;orderby=guid #guidascOrDesc#&amp;q=#attributes.q#">Guid #guidascOrDescIcon#</a></th>

			<!--- Header for link --->
			<cfset linkascOrDesc = (FindNoCase("link asc", url.orderby))? "desc" : "asc" />
			<cfset linkascOrDescIcon = (FindNoCase("link asc", url.orderby))? "&darr;" : "&uarr;" />
			<th><a href="?method=#attributes.method#&amp;offset=#attributes.offset#&amp;maxresults=#attributes.maxresults#&amp;orderby=link #linkascOrDesc#&amp;q=#attributes.q#">Link #linkascOrDescIcon#</a></th>

			<!--- Header for author --->
			<cfset authorascOrDesc = (FindNoCase("author asc", url.orderby))? "desc" : "asc" />
			<cfset authorascOrDescIcon = (FindNoCase("author asc", url.orderby))? "&darr;" : "&uarr;" />
			<th><a href="?method=#attributes.method#&amp;offset=#attributes.offset#&amp;maxresults=#attributes.maxresults#&amp;orderby=author #authorascOrDesc#&amp;q=#attributes.q#">Author #authorascOrDescIcon#</a></th>

			<!--- Header for published --->
			<cfset publishedascOrDesc = (FindNoCase("published asc", url.orderby))? "desc" : "asc" />
			<cfset publishedascOrDescIcon = (FindNoCase("published asc", url.orderby))? "&darr;" : "&uarr;" />
			<th><a href="?method=#attributes.method#&amp;offset=#attributes.offset#&amp;maxresults=#attributes.maxresults#&amp;orderby=published #publishedascOrDesc#&amp;q=#attributes.q#">Published #publishedascOrDescIcon#</a></th>

			<!--- Header for source --->
			<cfset sourceascOrDesc = (FindNoCase("source asc", url.orderby))? "desc" : "asc" />
			<cfset sourceascOrDescIcon = (FindNoCase("source asc", url.orderby))? "&darr;" : "&uarr;" />
			<th><a href="?method=#attributes.method#&amp;offset=#attributes.offset#&amp;maxresults=#attributes.maxresults#&amp;orderby=source #sourceascOrDesc#&amp;q=#attributes.q#">Source #sourceascOrDescIcon#</a></th>

			<!--- Header for title --->
			<cfset titleascOrDesc = (FindNoCase("title asc", url.orderby))? "desc" : "asc" />
			<cfset titleascOrDescIcon = (FindNoCase("title asc", url.orderby))? "&darr;" : "&uarr;" />
			<th><a href="?method=#attributes.method#&amp;offset=#attributes.offset#&amp;maxresults=#attributes.maxresults#&amp;orderby=title #titleascOrDesc#&amp;q=#attributes.q#">Title #titleascOrDescIcon#</a></th>

			<!--- Header for description --->
			<cfset descriptionascOrDesc = (FindNoCase("description asc", url.orderby))? "desc" : "asc" />
			<cfset descriptionascOrDescIcon = (FindNoCase("description asc", url.orderby))? "&darr;" : "&uarr;" />
			<th><a href="?method=#attributes.method#&amp;offset=#attributes.offset#&amp;maxresults=#attributes.maxresults#&amp;orderby=description #descriptionascOrDesc#&amp;q=#attributes.q#">Description #descriptionascOrDescIcon#</a></th>

			<!--- Header for tags --->
			<cfset tagsascOrDesc = (FindNoCase("tags asc", url.orderby))? "desc" : "asc" />
			<cfset tagsascOrDescIcon = (FindNoCase("tags asc", url.orderby))? "&darr;" : "&uarr;" />
			<th><a href="?method=#attributes.method#&amp;offset=#attributes.offset#&amp;maxresults=#attributes.maxresults#&amp;orderby=tags #tagsascOrDesc#&amp;q=#attributes.q#">Tags #tagsascOrDescIcon#</a></th>

		</tr>
	</thead>
	<tbody>
	<cfloop index="i" from="1" to="#ArrayLen(attributes.contentArray)#">
		<cfset content = attributes.contentArray[i] />
		<tr<cfif i mod 2> class="odd"</cfif>>
			<td>#content.getid()#</td>
			<td>#content.getguid()#</td>
			<td>#content.getlink()#</td>
			<td>#content.getauthor()#</td>
			<td>#dateFormat(content.getpublished(),"mm/dd/yyyy" )# #timeFormat(content.getpublished(),"h:mm tt" )#</td>
			<td>#content.getsource()#</td>
			<td>#content.gettitle()#</td>
			<td>#content.getdescription()#</td>
			<td>#content.gettags()#</td>
			<td class="crudlink"><a href="content.cfm?method=read&id=#content.getid()#">Read</a></td>
			<td class="crudlink"><a href="content.cfm?method=edit&id=#content.getid()#">Edit</a></td>
			<td class="crudlink"><a href="content.cfm?method=delete_process&id=#content.getid()#" onclick="if (confirm('Are you sure?')) { return true}; return false"">Delete</a></td>
		</tr>
	</cfloop>
<cfif attributes.offset gte 0>
<cfif pages gt 1>
	<tr>
	<td colspan="12">
		<table class="listnav">
			<tr>
				<td class="prev">
					<cfif prevOffset gte 0>
						<a href="?method=#attributes.method#&amp;offset=#prevOffset#&amp;maxresults=#attributes.maxresults#&amp;orderby=#attributes.orderby#&amp;q=#url.q#">&larr; Prev</a>
					</cfif>
				</td>
				<td class="pages">
					<cfloop index="i" from="1" to="#pages#">
						<cfset offset = 0 + ((i -1) * attributes.maxresults) />
						<cfif offset eq attributes.offset>
							#i#
						<cfelse>
							<a href="?method=#attributes.method#&amp;offset=#offset#&amp;maxresults=#attributes.maxresults#&amp;orderby=#attributes.orderby#&amp;q=#url.q#">#i#</a>
						</cfif>
					</cfloop>
				</td>
				<td class="next">
					<cfif nextOffset lt contentCount>
					<a href="?method=#attributes.method#&amp;offset=#nextOffset#&amp;maxresults=#attributes.maxresults#&amp;orderby=#attributes.orderby#&amp;q=#url.q#">Next &rarr;<a/>
					</cfif>
				</td>
			</tr>
		</table>
	</td>
	</tr>
</cfif>
	</tbody>
</cfif>
	</cfoutput>
</table>
</cfprocessingdirective>
<cfexit method="exitTag" />