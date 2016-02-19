class Enclosure {
    static belongsTo = [parameterSet: ParameterSet, alignment:Alignment]

	BigDecimal pmax
	BigDecimal spl
	BigDecimal splMech
	BigDecimal pmech
	BigDecimal splEle
	BigDecimal f3
	
    static constraints = {
        id(editable:false,display:true)
	    pmax(editable:false,display:true)
	    spl(editable:false,display:true)
	    splMech(editable:false,display:true)
	    pmech(editable:false,display:true)
	    splEle(editable:false,display:true)
	    f3(editable:false,display:true)
	}

	
}