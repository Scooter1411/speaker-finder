class Driver {

    String name
	
	Date   dateCreated
	Date   lastUpdated	
	String createdBy
	String lastModifiedBy

	static belongsTo = [maker:Maker]	
    static hasMany = [parameterSets: ParameterSet]

    //static searchable = [ except: ['version', 'dateCreated', 'lastUpdated'] ]

 	static constraints = {
        name(size:1..60,unique:'maker')
		
		dateCreated(nullable:true,editable:false)
		lastUpdated(nullable:true,editable:false)		
		createdBy(nullable:true,editable:false)
		lastModifiedBy(nullable:true,editable:false)		
	}

    String toString(){"$maker $name"}
}