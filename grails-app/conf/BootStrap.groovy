import groovy.io.FileType
import org.apache.commons.io.FilenameUtils

class BootStrap {

    private Maker bootstrapMaker( String name ){
        def result = Maker.findByName(name)
        if( ! result ){
            result = new Maker( name:name ).save(flush:true)
        }
        assert result
        result
    }

    private BigDecimal s2bd( String param ){
/*
//        def p1 = param.replaceAll(/[^.,0-9]/,'').replaceAll(/[.]/,',')
        def p1 = param.replaceAll(/[^.0-9]/,'')
        log.error "|${param}|${p1}|"
        assert p1 =~ /[0-9]/
        def p1bd = new BigDecimal( p1 )
        log.error "|${param}|${p1}|${p1bd}|"
        assert p1bd
        p1bd        
        */
        new BigDecimal( param.replaceAll(/[^.0-9]/,'') )
    }
    private Integer s2i( String param ){
        new Integer( param.replaceAll(/[^0-9]/,'') )
    }
    
    private bootstrapDriver( Maker maker, String line ){
        //if( ! line ==~ /#.*/ ){
            def params = line.split(',')
            if( params.size() == 15 ){    
			    log.debug "$maker $line"
                def driver             
                maker.drivers.each{ 
                    if( it.name == params[0] ){
                        driver = it
                        log.debug "* ${it.name}"
                    }else{
                        log.debug "  ${it.name}"
                    }
                }
                //= Driver.findByMakerAndName(maker,params[0])
                if( ! driver ){
                    driver = new Driver( name:params[0], maker:maker )
                    if( ! driver.validate() ){
                        log.error "$maker ${params[0]}"
                        driver.errors.each{ log.error it }
                        assert false
                    }
                    driver.save(flush:true)
                }
                assert driver 
                if( driver.parameterSets?.size() > 0 ){
                
                    driver.parameterSets[0].vas = s2bd(params[1])
                    driver.parameterSets[0].qts = s2bd(params[2])
                    driver.parameterSets[0].qes = s2bd(params[3])
                    driver.parameterSets[0].qms = s2bd(params[4])
                    driver.parameterSets[0].fs  = s2bd(params[5])
                    driver.parameterSets[0].mms = s2bd(params[6])
                    driver.parameterSets[0].cms = s2bd(params[7])
                    driver.parameterSets[0].nvc =  s2i(params[8])
                    driver.parameterSets[0].re  = s2bd(params[9])
                    driver.parameterSets[0].le  = s2bd(params[10])
                    driver.parameterSets[0].sd  = s2bd(params[11])
                    driver.parameterSets[0].xmax= s2bd(params[12])
                    driver.parameterSets[0].spl = s2bd(params[13])
                    driver.parameterSets[0].pmax= s2bd(params[14])
                    
                    if( ! driver.parameterSets[0].validate() ){
                        log.error driver
                        driver.parameterSets[0].errors.each{ log.error it }
                        assert false
                    }
                    driver.parameterSets[0].save(flush:true)
                    
                }else{
                    def ps = new ParameterSet( 
                        driver : driver,
                        vas : s2bd(params[1]),
                        qts : s2bd(params[2]),
                        qes : s2bd(params[3]),  
                        qms : s2bd(params[4]),  
                        fs  : s2bd(params[5]),
                        mms : s2bd(params[6]), 
                        cms : s2bd(params[7]),
                        nvc :  s2i(params[8]),
                        re  : s2bd(params[9]),
                        le  : s2bd(params[10]), 
                        sd  : s2bd(params[11]),
                        xmax: s2bd(params[12]),
                        spl : s2bd(params[13]),
                        pmax: s2bd(params[14])
                    )
                    if( ! ps.validate() ){
                        log.error driver
                        ps.errors.each{ log.error it }
                        assert false
                    }
                    ps.save(flush:true)
                    assert ps
                    driver.parameterSets = []
                    driver.save(flush:true)
                    driver.parameterSets << ps
                    driver.save(flush:true)
                }
            }
        //}
    }

    private bootstrapClosedAlignment( rpre, qtc ){
        def ali = ClosedAlignment.findByRpreAndQtc( rpre, qtc )
        if( !ali ){
            ali = new ClosedAlignment( rpre:rpre, qtc:qtc )
            if( ! ali.validate() ){
                ali.errors.each{log.error it}
                assert false
            }
            ali.save( flush:true )
        }else{
            assert ali.validate()
        }
        assert ali
    }

    private bootstrapInfiniteBaffleAlignment( rpre, nvc, rpara ){
        def ali = InfiniteBaffleAlignment.findWhere( rpre:rpre, nvc:nvc, rpara:rpara )
        if( !ali ){
            ali = new InfiniteBaffleAlignment( rpre:rpre, nvc:nvc, rpara:rpara )
            if( ! ali.validate() ){
                ali.errors.each{log.error it}
                assert false
            }
            ali.save( flush:true )
        }else{
            assert ali.validate()
        }
        assert ali
    }
    
    private bootstrapVentedAlignment( rpre, vx ){
        def ali = VentedAlignment.findWhere( rpre:rpre, vx:vx )
        if( !ali ){
            ali = new VentedAlignment( rpre:rpre, vx:vx )
            if( ! ali.validate() ){
                ali.errors.each{log.error it}
                assert false
            }
            ali.save( flush:true )
        }else{
            assert ali.validate()
        }
        assert ali
    }
    
    def init = { servletContext ->
    
        [0.2,0.6,1.0].each{ rpre ->
            [0.5,0.6,0.7,0.8,0.9,1.0,1.1].each{ qtc ->
                bootstrapClosedAlignment( rpre, qtc )
            }
        }
        
        [0.0,1.0,1.5,2.2,3.3,4.7,6.8,10.0,15.0,22.0,33.0,47.0,68.0,100.0,150.0,9999.0].each{
            bootstrapInfiniteBaffleAlignment( 0.2, 2, it )
        }
        bootstrapInfiniteBaffleAlignment( 0.2, 1, null )
        
        /*[0.2,0.6,1.0].each{ rpre ->
            [0.712,0.797,0.893, 1.0, 1.12, 1.25, 1.40].each{ vx ->
                bootstrapVentedAlignment( rpre, vx )
            }
        }*/
		// LLT subs
		[2.0,2.83,4.0,5.66,8.0,11.3,16.0,22.6,32.0,45.3,64.0,90.5,128.0,181.0,256.0,362.0,512.0,724.0].each{ vx ->
			bootstrapVentedAlignment( 0.2, vx )
		}

        def old = new File('old')
        assert old.isDirectory()
    	
        old.eachFileMatch(FileType.FILES, ~/.*in/){
            def maker = bootstrapMaker(FilenameUtils.getBaseName(it.name))
            it.eachLine{ line ->
                bootstrapDriver( maker, line )
            }
        }
        log.error "${Maker.count()} makers with ${Driver.count()} drivers"
    }
    def destroy = {
    }
}
