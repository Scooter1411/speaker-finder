class ParameterSet {

    static belongsTo = [driver: Driver]
    static hasMany = [alignments: Alignment]
	
	Date   dateCreated
	Date   lastUpdated	
	String createdBy
	String lastModifiedBy

    BigDecimal vas  = 0.0
    BigDecimal qts  = 0.0   
    BigDecimal qes  = 0.0  
    BigDecimal qms  = 0.0  
    BigDecimal fs   = 0.0
    BigDecimal mms  = 0.0 
    BigDecimal cms  = 0.0
    Integer    nvc  = 0
    BigDecimal re   = 0.0 
    BigDecimal le   = 0.0  
    BigDecimal sd   = 0.0
    BigDecimal xmax = 0.0
    BigDecimal spl  = 0.0
    BigDecimal pmax = 0.0

 	static constraints = {
        vas( min:0.03, max:1000.0 )
		qts( min:0.11,  max:1.23     )
		qes( min:0.12,  max:1.6     )
		qms( min:1.1,  max:25.0     )
		/*fs( min: 10.0, max:300.0 )
		mms( min: 0.0, max:3000.0 )
		cms( min: 0.0, max:500.0, nullable:true )
		//nvc( inList:[1,2] )
		re( min:1.5, 18 )
		le( min:0.0, max: 80.0, nullable:true)
		sd( min: 5.3, max: 1800.0 )
		xmax( min:1.0, max: 38.5 )
		spl( min: 78.0, max: 105.0 )
		pmax( min: 5.0, max : 2000.0 )
		*/
		dateCreated(nullable:true)
		lastUpdated(nullable:true)		
		createdBy(nullable:true)
		lastModifiedBy(nullable:true)		
	}
	
	String toString(){"$driver ($qts)"}
}