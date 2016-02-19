class EnclosureService {

    def generateClosed(){
        ParameterSet.list().each{ generateClosed(it) }
    }

    def generateClosed( ParameterSet paras ){
    
        def them = ClosedEnclosure.findAllByParameterSet(paras)
        if( ! them || them.size() == 0 || them[0].dateCreated < paras.dateCreated ){
            them.each{ delete it }
            ClosedAlignment.list().each{ ali ->
                        
                def p0 = 2.83 * 2.83 / paras.re
                def vd = paras.sd * 2 * paras.xmax / 10
        
                def qes1 = paras.qes * ( paras.re + ali.rpre ) / paras.re
                def qts1 = 1/((1/paras.qms)+(1/qes1))
                def eff = 9.64 * 0.0000000001 * paras.fs*paras.fs*paras.fs * paras.vas / qes1
                def spl1 = 112 + 10 * Math.log( eff ) / Math.log(10)

                def cs = 316000 * qts1 / paras.re / paras.fs

//                first = "true";
//                for( qtc=0.5; qtc<=1.1; qtc+=0.1 ) {
                def fc = ali.qtc / qts1 * paras.fs;
                def f3 = ali.factor * fc

                def spl2 = 20 * Math.log( 0.37 * f3 * f3 * vd ) / Math.log(10);            
                def p2   = p0 * Math.exp(( spl2 - spl1)/10*Math.log(10));
                def spl3 = spl1 + 10 * Math.log( paras.pmax / p0 ) / Math.log(10);
                
                def one = (ali.qtc*ali.qtc)/(qts1*qts1)
                log.error "${ali.qtc} ${qts1} ${one}"
                if( one > 1 ){
                    def vb   = paras.vas / (one-1);
            	    
                    def newEnc = new ClosedEnclosure( 
                        parameterSet:paras,
                        alignment:ali,
                        pmax:paras.pmax,
                        vb:vb,
                        spl: spl1,
                        splMech : spl2,
                        pmech: p2,
                        splEle: spl3,
                        f3: f3
                    )
                    if( ! newEnc.validate() ){
                        newEnc.errors.each{ log.error it }
                        assert false
                    }
                    assert newEnc.save(flush:true);
                    log.error newEnc
                }
            }
        }
     }
}