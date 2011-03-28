<cfscript>
	
	api = new Evangelists.api.entry(); 	
	
	results = api.get(author='terryr',q="flex");
	
	writeDump(results );
</cfscript>	