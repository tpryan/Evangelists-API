component{

	public function init(){   
		variables.lineBreak = createObject("java", "java.lang.System").getProperty("line.separator"); 
   		return This;    
    }

	public string function formatEntriesAsXML (array entries){
		
		var	results = '<?xml version="1.0" encoding="iso-8859-1"?>' & linebreak;
		
		
		results = results & "<entries>" & linebreak;
		
		for (i=1;i <= ArrayLen(arguments.entries); i++){
			var entry = entries[i];
			results = results & "	<entry>" & linebreak;
			results = results & "		<id>" & entry.getId() & "</id>" & linebreak;
			results = results & "		<guid>" & entry.getGuid() & "</guid>" & linebreak;
			results = results & "		<link>" & entry.getLink() & "</link>" & linebreak;
			results = results & "		<author>" & entry.getAuthor() & "</author>" & linebreak;
			results = results & "		<published>" & entry.getpublished() & "</published>" & linebreak;
			results = results & "		<source>" & entry.getSource() & "</source>" & linebreak;
			results = results & "		<title>" & entry.getTitle() & "</title>" & linebreak;
			results = results & "		<description>" & XMLFormat(entry.getdescription()) & "</description>" & linebreak;
			results = results & "		<tags>" & entry.getTags() & "</tags>" & linebreak;
			results = results & "	</entry>" & linebreak;
			
		}
		results = results & "</entries>";
		
		return results;
		
	}
	
	public string function formatAuthorsAsXML (array authors){
		
		var	results = '<?xml version="1.0" encoding="iso-8859-1"?>' & linebreak;
		
		results = results & "<authors>" & linebreak;
		
		for (i=1;i <= ArrayLen(arguments.authors); i++){
			var author = authors[i];
			results = results & "	<author>" & author  & "</author>"& linebreak;
		}
		results = results & "</authors>";
		return results;
	}
	
	public string function formatSourcesAsXML (array sources){
		
		var	results = '<?xml version="1.0" encoding="iso-8859-1"?>' & linebreak;
		
		results = results & "<sources>" & linebreak;
		
		for (i=1;i <= ArrayLen(arguments.sources); i++){
			var source = sources[i];
			results = results & "	<source>" & source  & "</source>"& linebreak;
		}
		results = results & "</sources>";
		return results;
	}
	
	

	public struct function formatDates (string dateString){
		var process = {};
		
		if(listlen(arguments.dateString, "-") > 1){
			process.start = getToken(arguments.dateString,1,"-");
			process.end = getToken(arguments.dateString,2,"-");
		}
		else{
			if(left(arguments.dateString, "1") == "-"){
				process.start = "";
				process.end = replace(arguments.dateString, "-", "", "Once");
			}
			else{
				process.start = replace(arguments.dateString, "-", "", "Once");
				process.end = "";
			}
		}
		
		
		var results = {startDate="",endDate=""};
		
		if (len(process.start)){
			results.startDate = formatDate(process.start);
		}
		if (len(process.end)){
			results.endDate = formatDate(process.end);
		}
		
		return results;
	}

	public date function formatDate (string dateString){
		var year = Left(arguments.dateString,4);
		var month = Mid(arguments.dateString,5,2);
		var day = Right(arguments.dateString,2);
		var results = CreateDate(year,month,day);
		
		return results;
	}



	public string function formatCountAsXML(numeric count){
		var	results = '<?xml version="1.0" encoding="iso-8859-1"?>' & linebreak;
		results = results & "<counts>" & linebreak;
		results = results & "	<count>" & count  & "</count>"& linebreak;
		results = results & "</counts>";
		return results;
	}
}