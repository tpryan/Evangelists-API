<cfcomponent hint="Remote API for dealing with conent from the Evangelist aggregator. ">
	<cfscript>

	public function init(){    
    		    
   		return This;    
    }

	/**
		@hint Returns a count of records matching input criteria. Useful for paging interfaces.
		@source The external source of the content. A list of posible sources is available via listSources() 
		@author The username of the creator of the content. A list of posible sources is available via listAuthors() 
		@startDate The begining of a date range to filter content. If ommitted, count will count records back to the earliest record 
		@endDate The end of a date range to filter content. If ommitted, count wil count records forward to the latest record
		@q A search term which will be matched against the TITLE and DESCRIPTION of the content.
		    
	*/
	remote numeric function count(string source = "", 
													string author = "",
													any startDate = "",
													any endDate = "",
													any q = "") {
	
		var hqlString = "SELECT COUNT(id) FROM content";
		var whereClause = "";
		var whereParams = [];

		if (len(arguments.source) gt 0){
			whereClause  = ListAppend(whereClause, " source in (#formatInList(arguments.source)#)", "|");
		}
		if (len(arguments.author) gt 0){
			whereClause  = ListAppend(whereClause, " author in (#formatInList(arguments.author)#)", "|");
		}
		
		if (len(arguments.startDate) gt 0 && isDate(arguments.startDate)){
			whereClause  = ListAppend(whereClause, " published >= ?", "|");
			ArrayAppend(whereParams, arguments.startDate);
		}
		
		if (len(arguments.endDate) gt 0 && isDate(arguments.endDate)){
			whereClause  = ListAppend(whereClause, " published <= ?", "|");
			ArrayAppend(whereParams, arguments.endDate);
		}
		
		if (len(arguments.q)){
			whereClause  = ListAppend(whereClause, " (title LIKE '%#arguments.q#%' OR description LIKE '%#arguments.q#%')", "|");
		}
		
		whereClause = Replace(whereClause, "|", " AND ", "all");
		
		
		if (len(whereClause) gt 0){
			hqlString = hqlString & " WHERE " & whereClause;
		}

		var result = ormExecuteQuery(hqlString, whereParams)[1];
		return result;
	}
	
	/**
		@hint Returns a list of records matching input criteria.
		@source The external source of the content. A list of posible sources is available via listSources() 
		@author The username of the creator of the content. A list of posible sources is available via listAuthors() 
		@startDate The begining of a date range to filter content. If ommitted, get wil retrieve records back to the earliest record 
		@endDate The end of a date range to filter content. If ommitted, get wil retrieve records forward to the latest record
		@q A search term which will be matched against the TITLE and DESCRIPTION of the content.
		@offset A record number to start the search from. Useful for paging.
		@maxresults The count of records to retrieve at one point. Useful for paging.
		@orderby The order in which to retrieve the records.
		    
	*/
	remote Evangelists.cfc.content[] function get(string source = "", 
													string author = "",
													any startDate = "",
													any endDate = "",
													any q = "",				
													numeric offset ="0" , 
													numeric maxresults ="20" , 
													string orderby ="id asc" ) {

		var hqlString = "";
		var whereClause = "";
		var whereParams = [];
		var params = {};
		hqlString = hqlString & "FROM content";
		if (arguments.offset neq 0){
			params.offset = arguments.offset;
		}
		if (arguments.maxresults neq 0){
			params.maxresults = arguments.maxresults;
		}
		if (len(arguments.source) gt 0){
			whereClause  = ListAppend(whereClause, " source in (#formatInList(arguments.source)#)", "|");
		}
		if (len(arguments.author) gt 0){
			whereClause  = ListAppend(whereClause, " author in (#formatInList(arguments.author)#)", "|");
		}
		
		if (len(arguments.startDate) gt 0 && isDate(arguments.startDate)){
			whereClause  = ListAppend(whereClause, " published >= ?", "|");
			ArrayAppend(whereParams, arguments.startDate);
		}
		
		if (len(arguments.endDate) gt 0 && isDate(arguments.endDate)){
			whereClause  = ListAppend(whereClause, " published <= ?", "|");
			ArrayAppend(whereParams, arguments.endDate);
		}
		
		if (len(arguments.q)){
			whereClause  = ListAppend(whereClause, " (title LIKE '%#arguments.q#%' OR description LIKE '%#arguments.q#%')", "|");
		}
		
		whereClause = Replace(whereClause, "|", " AND ", "all");
		
		
		if (len(whereClause) gt 0){
			hqlString = hqlString & " WHERE " & whereClause;
		}
		
		hqlString = hqlString & " ORDER BY #arguments.orderby#";
		
	
		var result = ormExecuteQuery(hqlString, whereParams, false, params);
		
		return result;
	}
	
	/**
		@hint Returns an array of each unique source. 
	*/	
	remote array function listSources(){
		return listColumn("source");
	}
	
	/**
		@hint Returns an array of each unique author. 
	*/
	remote array function listAuthors(){
		return listColumn("author");
	}
	
	private array function listColumn(required string column){
		var hqlString = "SELECT DISTINCT #arguments.column# FROM content";
		var result = ormExecuteQuery(hqlString);
		return result;
	}
	
	private string function formatInList(required string list){
		var result = ListQualify(arguments.list, "'");
		return result; 
	}

</cfscript>

</cfcomponent>