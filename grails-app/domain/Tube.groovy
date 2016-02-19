class Tube {

    String     name
	BigDecimal diameter
	BigDecimal area
	
	Date   dateCreated
	Date   lastUpdated	
	String createdBy
	String lastModifiedBy
	
	static mapping = {
        area formula: '3.1416 / 4 * power( diameter / 10, 2 )'
    }
 	static constraints = {
        name(size:1..20,unique:true,nullable:false)
		diameter(nullable:false,min:10.0,max:1000.0,unique:true)
		
		dateCreated(nullable:true,editable:false)
		lastUpdated(nullable:true,editable:false)		
		createdBy(nullable:true,editable:false)
		lastModifiedBy(nullable:true,editable:false)		
	}

    String toString(){name}
}