component{

	This.name = "khoyt";
	This.ormenabled = true;
	This.datasource = "khoyt";
	This.customTagPaths = GetDirectoryFromPath(GetCurrentTemplatePath()) & "customtags";
	This.ormsettings.eventHandler = "Evangelists.cfc.eventHandler";
	This.ormsettings.dbcreate = "update";
	This.ormsettings.logSQL = true;


	public boolean function onRequestStart() {

		if (structKeyExists(url, "reset_app")){
			ApplicationStop();
			location(cgi.script_name, false);
		}

		return true;
	}

	public boolean function onApplicationStart() {
		application.contentService = new Evangelists.services.contentService();
		return true;
	}
	
	public boolean function onMissingTemplate(){
		writeDump(url);
		writeDump(request);
		writeDump(cgi);
	
		return true;
	}	
}