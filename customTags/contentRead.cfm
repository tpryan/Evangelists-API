<!--- contentRead.cfm --->
<cfprocessingdirective suppresswhitespace="yes">
<cfparam name="attributes.content" type="any" />
<cfparam name="attributes.class" type="string" default="readpage" />
<cfset content = attributes.content /> 
<cfoutput>
<table>
	<tbody>
		<tr>
			<th>Id</th>
			<td>#content.getid()#</td>
		</tr>
		<tr>
			<th>Guid</th>
			<td>#content.getguid()#</td>
		</tr>
		<tr>
			<th>Link</th>
			<td>#content.getlink()#</td>
		</tr>
		<tr>
			<th>Author</th>
			<td>#content.getauthor()#</td>
		</tr>
		<tr>
			<th>Published</th>
			<td>#dateFormat(content.getpublished(),"mm/dd/yyyy" )# #timeFormat(content.getpublished(),"h:mm tt" )#</td>
		</tr>
		<tr>
			<th>Source</th>
			<td>#content.getsource()#</td>
		</tr>
		<tr>
			<th>Title</th>
			<td>#content.gettitle()#</td>
		</tr>
		<tr>
			<th>Description</th>
			<td>#content.getdescription()#</td>
		</tr>
		<tr>
			<th>Tags</th>
			<td>#content.gettags()#</td>
		</tr>
	</tbody>
</table>
</cfoutput>
</cfprocessingdirective>
<cfexit method="exitTag" />