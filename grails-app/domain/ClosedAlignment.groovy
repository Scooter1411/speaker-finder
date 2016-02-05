class ClosedAlignment extends Alignment {

    BigDecimal qtc = 0.0
	
	static constraints = {

	    qtc( min: 0.5 , max: 1.1 )
	}

	String toString(){"R<sub>pre</sub>=${rpre}&Omega; Closed qtc=$qtc"}
}