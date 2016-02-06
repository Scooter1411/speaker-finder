class VentedAlignment extends Alignment {

    BigDecimal vx = 1.0
	
	static constraints = {
        vx( min: 0.7, unique: 'rpre' )
	}	
}