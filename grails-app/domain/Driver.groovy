class Driver {

    String name
    String company

    static hasMany = [parameterSets: ParameterSet]

    static searchable = [ except: ['version', 'dateCreated', 'lastUpdated'] ]

    

    String toString(){"$company $name"}
}