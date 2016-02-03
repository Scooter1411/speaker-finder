class Driver {

    String name

	static belongsTo = [maker:Maker]
	
    static hasMany = [parameterSets: ParameterSet]

    //static searchable = [ except: ['version', 'dateCreated', 'lastUpdated'] ]

    

    String toString(){"$maker $name"}
}