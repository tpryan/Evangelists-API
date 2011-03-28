component implements="CFIDE.ORM.IEventHandler"{


	/**
	* @hint Event handler that fires after a delete operation.
	*/
	remote void function postDelete(any entity ) {
	}

	/**
	* @hint Event handler that fires after a insert operation.
	*/
	remote void function postInsert(any entity ) {
	}

	/**
	* @hint Event handler that fires after a load operation.
	*/
	remote void function postLoad(any entity ) {
	}

	/**
	* @hint Event handler that fires after a update operation.
	*/
	remote void function postUpdate(any entity ) {
	}

	/**
	* @hint Event handler that fires before a delete operation.
	*/
	remote void function preDelete(any entity ) {
	}

	/**
	* @hint Event handler that fires before an insert operation. Ensures magic words get populated.
	*/
	remote void function preInsert(any entity ) {
		if (structKeyExists(entity, "setcreatedOn")){
			entity.setcreatedOn(now());
		}

		if (structKeyExists(entity, "setupdatedOn")){
			entity.setupdatedOn(now());
		}
	}

	/**
	* @hint Event handler that fires before a load operation.
	*/
	remote void function preLoad(any entity ) {
	}

	/**
	* @hint Event handler that fires before a update operation. Ensures magic words get populated.
	*/
	remote void function preUpdate(any entity , struct oldData ) {
		if (structKeyExists(entity, "setupdatedOn")){
			entity.setupdatedOn(now());
		}
	}
}