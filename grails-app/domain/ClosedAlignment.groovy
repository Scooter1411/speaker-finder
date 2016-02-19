class ClosedAlignment extends Alignment {

    BigDecimal qtc = 0.0
    BigDecimal factor

    static constraints = {

        qtc( min: 0.5 , max: 1.1 )
    }
    static mapping = {
        factor formula:'''        
            case 
                when qtc < 0.525 then 1.45  
                when qtc < 0.55  then 1.35  
                when qtc < 0.575 then 1.29 
                when qtc < 0.60  then 1.24 
                when qtc < 0.65  then 1.14 
                when qtc < 0.7   then 1.05
                when qtc < 0.75  then 0.98 
                when qtc < 0.8   then 0.93 
                when qtc < 0.85  then 0.88 
                when qtc < 0.9   then 0.85 
                when qtc < 0.95  then 0.81 
                when qtc < 1.0   then 0.79 
                when qtc < 1.05  then 0.77 
                else 0.75 
            end 
        '''
    }
    String toString(){"R<sub>pre</sub> ${rpre}&Omega; Closed q<sub>tc</sub> $qtc"}
}