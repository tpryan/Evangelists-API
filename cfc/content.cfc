/* NOTE: Any changes you make to this CFC will be written over if you regenerate the application.*/
component persistent="true"{

	property name="id" ormtype="integer" type="numeric" fieldtype="id" generator="native";
	property name="guid" type="string";
	property name="link" type="string";
	property name="author" type="string";
	property name="published" ormtype="timestamp" type="date";
	property name="source" type="string";
	property name="title" type="string";
	property name="description" ormtype="text" type="string";
	property name="tags" type="string";

	/**
	* @hint A initialization routine, runs when object is created.
	*/
	remote content function init() {
		return This;
	}

	/**
	* @hint Nullifies blank or zero id's.  Useful for dealing with objects coming back from remoting.
	*/
	public void function nullifyZeroID() {
		if (getid() eq 0 OR getid() eq ""){
			setid(JavaCast("Null", ""));
		}
	}

	/**
	* @hint Populates the content of the object from a form structure.
	*/
	public content function populate(required struct formStruct ) {
		if (StructKeyExists(arguments.formstruct, "id") AND arguments.formstruct.id gt 0){

			var item = EntityLoad("content", arguments.formstruct.id, true);

			if (not isNull(item)){
				This = item;
			}
			else{
				This.setid(arguments.formstruct.id);
			}
		}

		if (StructKeyExists(arguments.formstruct, "guid")){
			This.setguid(arguments.formstruct.guid);
		}

		if (StructKeyExists(arguments.formstruct, "link")){
			This.setlink(arguments.formstruct.link);
		}

		if (StructKeyExists(arguments.formstruct, "author")){
			This.setauthor(arguments.formstruct.author);
		}

		if (StructKeyExists(arguments.formstruct, "published")){
			This.setpublished(arguments.formstruct.published);
		}

		if (StructKeyExists(arguments.formstruct, "source")){
			This.setsource(arguments.formstruct.source);
		}

		if (StructKeyExists(arguments.formstruct, "title")){
			This.settitle(arguments.formstruct.title);
		}

		if (StructKeyExists(arguments.formstruct, "description")){
			This.setdescription(arguments.formstruct.description);
		}

		if (StructKeyExists(arguments.formstruct, "tags")){
			This.settags(arguments.formstruct.tags);
		}

		return This;
	}
}