<cfscript>
	
	api = new Evangelists.api.entry(); 	
	
	results = api.count(source="blog");
	
	writeDump(results );
</cfscript>	