class InfiniteBaffleAlignment extends Alignment {

	Integer nvc = 1
    BigDecimal rpara = 0.0
	
	static constraints = {
        nvc( inList: [1,2] )
	    rpara( min: 0.0, nullable: true, unique: ['rpre','nvc'] )
	}	
}