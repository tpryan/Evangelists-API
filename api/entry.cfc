<cfcomponent>
	<cfscript>

	public function init(){    
    		    
   		return This;    
    }

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
			whereClause  = ListAppend(whereClause, " title LIKE '%#arguments.q#%' ", "|");
		}
		
		whereClause = Replace(whereClause, "|", " AND ", "all");
		
		
		if (len(whereClause) gt 0){
			hqlString = hqlString & " WHERE " & whereClause;
		}
		
		//hqlString = hqlString & " ORDER BY #arguments.orderby#";
		
	
		var result = ormExecuteQuery(hqlString, whereParams, false);
		
		return ormExecuteQuery(hqlString, whereParams, false);
	}
	
	private string function formatInList(required string list){
		var result = ListQualify(arguments.list, "'");
		return result; 
	}

</cfscript>

</cfcomponent>