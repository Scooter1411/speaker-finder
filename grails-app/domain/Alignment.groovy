class Alignment {

	BigDecimal rpre = 0.0
	
	Date   dateCreated
	Date   lastUpdated	
	String createdBy
	String lastModifiedBy

 	static constraints = {

	    rpre( min: 0.1 , max: 2.0 )
	
		dateCreated(nullable:true)
		lastUpdated(nullable:true)		
		createdBy(nullable:true)
		lastModifiedBy(nullable:true)		
	}	
}