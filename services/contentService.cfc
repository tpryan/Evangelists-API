/* NOTE: Any changes you make to this CFC will be written over if you regenerate the application.*/
component{


	/**
	* @hint A initialization routine, runs when object is created.
	*/
	remote contentService function init() {
		This.table = "content";
		return This;
	}

	/**
	* @hint Returns the count of records in content
	*/
	remote numeric function count() {
		return ormExecuteQuery("select Count(*) from content")[1];
	}

	/**
	* @hint Returns all of the records in content.
	*/
	remote Evangelists.cfc.content[] function list() {
		return entityLoad("content", {}, "id asc");
	}

	/**
	* @hint Returns all of the records in content, with paging.
	*/
	remote Evangelists.cfc.content[] function listPaged(numeric offset ="0" , numeric maxresults ="0" , string orderby ="id asc" ) {
		var loadArgs = {};
		if (arguments.offset neq 0){
			loadArgs.offset = arguments.offset;
		}
		if (arguments.maxresults neq 0){
			loadArgs.maxresults = arguments.maxresults;
		}
		return entityLoad("content", {}, arguments.orderby, loadArgs);
	}

	/**
	* @hint Returns one record from content.
	*/
	remote Evangelists.cfc.content function get(required numeric id ) {
		return EntityLoad("content", arguments.id, true);
	}

	/**
	* @hint Updates one record from content.
	*/
	remote void function update(required any content ) {
		arguments.content.nullifyZeroID();
		EntitySave(arguments.content);
	}

	/**
	* @hint Deletes one record from content.
	*/
	remote void function destroy(required any content ) {
		EntityDelete(arguments.content);
	}

	/**
	* @hint Performs search against content.
	*/
	remote Evangelists.cfc.content[] function search(string q ) {

		var hqlString = "";
		var whereClause = "";
		var params = {};
		hqlString = hqlString & "FROM content";
		if (len(arguments.q) gt 0){
			whereClause  = ListAppend(whereClause, " guid LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " link LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " author LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " source LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " title LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " tags LIKE '%#arguments.q#%'", "|");
			whereClause = Replace(whereClause, "|", " OR ", "all");
		}
		if (len(whereClause) gt 0){
			hqlString = hqlString & " WHERE " & whereClause;
		}
			hqlString = hqlString & " ORDER BY id asc";
		return ormExecuteQuery(hqlString, false, params);
	}

	/**
	* @hint Performs search against content., with paging.
	*/
	remote Evangelists.cfc.content[] function searchPaged(string q , numeric offset ="0" , numeric maxresults ="0" , string orderby ="id asc" ) {

		var hqlString = "";
		var whereClause = "";
		var params = {};
		hqlString = hqlString & "FROM content";
		if (arguments.offset neq 0){
			params.offset = arguments.offset;
		}
		if (arguments.maxresults neq 0){
			params.maxresults = arguments.maxresults;
		}
		if (len(arguments.q) gt 0){
			whereClause  = ListAppend(whereClause, " guid LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " link LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " author LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " source LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " title LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " tags LIKE '%#arguments.q#%'", "|");
			whereClause = Replace(whereClause, "|", " OR ", "all");
		}
		if (len(whereClause) gt 0){
			hqlString = hqlString & " WHERE " & whereClause;
		}
			hqlString = hqlString & " ORDER BY #arguments.orderby#";
		return ormExecuteQuery(hqlString, false, params);
	}

	/**
	* @hint Determines total number of results of search for paging purposes.
	*/
	remote numeric function searchCount(string q ) {

		var hqlString = "";
		var whereClause = "";
		var params = {};
		hqlString = hqlString & "SELECT count(*) ";
		hqlString = hqlString & "FROM content";
		if (len(arguments.q) gt 0){
			whereClause  = ListAppend(whereClause, " guid LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " link LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " author LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " source LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " title LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " tags LIKE '%#arguments.q#%'", "|");
			whereClause = Replace(whereClause, "|", " OR ", "all");
		}
		if (len(whereClause) gt 0){
			hqlString = hqlString & " WHERE " & whereClause;
		}
		return ormExecuteQuery(hqlString, false, params)[1];
	}
}