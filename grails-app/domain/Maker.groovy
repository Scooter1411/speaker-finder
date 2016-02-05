class Maker {

    String name
	
	Date   dateCreated
	Date   lastUpdated	
	String createdBy
	String lastModifiedBy
	
    static hasMany = [drivers: Driver]
 	static constraints = {
        name(size:1..60,unique:true)
		
		dateCreated(nullable:true,editable:false)
		lastUpdated(nullable:true,editable:false)		
		createdBy(nullable:true,editable:false)
		lastModifiedBy(nullable:true,editable:false)		
	}

    String toString(){name}
}