<!--- contentEdit.cfm --->
<cfprocessingdirective suppresswhitespace="yes">
<cfparam name="attributes.content" type="any" />
<cfparam name="attributes.message" type="string" default="" />
<cfset content = attributes.content /> 
<cfset message = attributes.message /> 
<cfif CompareNoCase(message, "updated") eq 0>
	<p class="alert">Record updated</p>
<cfelse>
	<p></p>
</cfif>
<cfoutput>
<cfform action="?method=edit_process" method="post" format="html" enctype="multipart/form-data">
	<table>
	<tbody>
			<input name="id" type="hidden" value="#content.getid()#" />
		<tr>
			<th><label for="guid">Guid:</label></th>
			<td><input name="guid" type="text" id="guid" value="#content.getguid()#" /></td>
		</tr>
		<tr>
			<th><label for="link">Link:</label></th>
			<td><input name="link" type="text" id="link" value="#content.getlink()#" /></td>
		</tr>
		<tr>
			<th><label for="author">Author:</label></th>
			<td><input name="author" type="text" id="author" value="#content.getauthor()#" /></td>
		</tr>
		<tr>
			<th><label for="published">Published:</label></th>
			<td><input name="published" type="text" id="published" value="#content.getpublished()#" /></td>
		</tr>
		<tr>
			<th><label for="source">Source:</label></th>
			<td><input name="source" type="text" id="source" value="#content.getsource()#" /></td>
		</tr>
		<tr>
			<th><label for="title">Title:</label></th>
			<td><input name="title" type="text" id="title" value="#content.gettitle()#" /></td>
		</tr>
		<tr>
			<th><label for="description">Description:</label></th>
			<td><cftextarea name="description"  id="description" value="#content.getdescription()#" richtext="true" toolbar="Basic" skin="Silver" /></td>
		</tr>
		<tr>
			<th><label for="tags">Tags:</label></th>
			<td><input name="tags" type="text" id="tags" value="#content.gettags()#" /></td>
		</tr>
		<tr>
			<th />
			<td><input name="save" type="submit" value="Save" /></td>
		</tr>
	</tbody>
	</table>
</cfform>
</cfoutput>
</cfprocessingdirective>
<cfexit method="exitTag" />