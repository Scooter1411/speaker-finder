class Enclosure {
    static mapping = {
         table 'ENCLOSURE_VIEW'
         // version is set to false, because this isn't available by default for legacy databases
         version false
         id column:'ID'
    }
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