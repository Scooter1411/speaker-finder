class VentedEnclosure extends Enclosure{
    static belongsTo = [parameterSet: ParameterSet, closedAlignment:ClosedAlignment]

	BigDecimal vb
	Tube tube
	BigDecimal length
	
    static constraints = {
	    vb(editable:false,display:true)
	} 
}