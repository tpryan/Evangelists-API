<cfsilent>
<cfscript>
	entryService = new entry();
	formatter = new formatter();
	
	methods = ["get","count","listAuthors","listSources"];
	formats = ["xml","json"];
	authors = entryService.listAuthors();
	sources = entryService.listSources();
	
	urlArguments = listToArray(cgi.path_info, "/");
	
	for (i=1;i<=ArrayLen(urlArguments); i++){
		arg = Trim(urlArguments[i]);
		
		if (ArrayFindNoCase(authors,ListToArray(arg)[1])){
			url.author = arg;	
		}
		
		if (ArrayFindNoCase(sources,ListToArray(arg)[1])){
			url.source = arg;	
		}
		
		if (Find("-",arg)){
			if ((left(arg, 1)) == "-" ||
			 	(right(arg, 1) == "-") || 
			 	(mid(arg,9,1) == "-" && len(arg) == 17)){
				dates = formatter.formatDates(arg);
				url.startDate=dates.startDate;
				url.endDate=dates.endDate;
			}
		}
		if (ArrayFindNoCase(formats,ListToArray(arg)[1])){
			url.format = arg;	
		}
		
		if (ArrayFindNoCase(methods,arg)){
			url.method = arg;	
		}
		
		if (Find("|",arg)){
			url.offset = getToken(arg,1,"|");
			url.maxresults = getToken(arg,2,"|");
		}
		
		if (Find('"',arg)){
			
			url.q = mid(arg,2,len(arg)-2);
			
		}
	}	
	
	
	param name="url.method" type="string" default="get"; //done
	param name="url.source" type="string" default=""; //done
	param name="url.author" type="string" default=""; //done
	param name="url.startDate" type="string" default=""; //done
	param name="url.endDate" type="string" default=""; //done
	param name="url.format" type="string" default="xml"; //done
	param name="url.offset" type="string" default="#entryService.getoffset()#";//done
	param name="url.maxresults" type="string" default="100";//done
	param name="url.q" type="string" default="";//done
	
	param name="url.orderby" type="string" default="#entryService.getorderby()#";
	
	if (CompareNoCase(url.method,"get") eq 0){	
		results = entryService.get(url.source,url.author,url.startDate,url.endDate,url.q,url.offset,url.maxresults,url.orderby);
		returnContent = formatter.formatEntriesAsXML(results);
	}
	else if(CompareNoCase(url.method,"count") eq 0){
		results = entryService.count(url.source,url.author,url.startDate,url.endDate,url.q);
		returnContent = formatter.formatCountAsXML(results);
	}
	else if(CompareNoCase(url.method,"listAuthors") eq 0){
		results = entryService.listAuthors();
		returnContent = formatter.formatAuthorsAsXML(results);
	}
	else if(CompareNoCase(url.method, "listSources") eq 0){
		results = entryService.listSources();
		returnContent = formatter.formatSourcesAsXML(results);
	}	

	if (CompareNoCase(url.format, "json") eq 0){
		returnContent = serializeJSON(results);
	}
	
	
</cfscript>	

</cfsilent><cfoutput>#returnContent#</cfoutput>