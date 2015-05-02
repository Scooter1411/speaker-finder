import grails.util.GrailsUtil 
import static groovy.io.FileType.*

class BootStrap {

def searchableService

private bootstrapRole( authority ){

    def role = AuthRole.findByAuthority(authority) ?: new AuthRole(authority:authority)
    assert role
    if( ! role.validate() ){
        role.errors.each{ log.error it }
        assert false
    }
    assert role.save()
}

private bootstrapUser( username, lastName = null, firstName = null, email = null ){

    if( lastName ){
        assert email
        assert firstName
    }    
    def roleContributor = AuthRole.findByAuthority('ROLE_CONTRIBUTOR') 
    assert roleContributor
    def roleAdmin = AuthRole.findByAuthority('ROLE_ADMIN') 
    assert roleAdmin

    def myself = AuthUser.findByUsername(username) ?: new AuthUser(username:username,password:'WontWork')
    assert myself
    if( ! myself.validate() ){
        myself.errors.each{ log.error it }
        assert false
    }
    assert myself.save()

    def was = AuthUserAuthRole.findByAuthUserAndAuthRole( myself, roleContributor ) 
    if( ! was ){
        was = new AuthUserAuthRole(authUser:myself,authRole:roleContributor ).save()
        assert was
    }
    if( !( username =~ /test/ )){
        was = AuthUserAuthRole.findByAuthUserAndAuthRole( myself, roleAdmin  )
        if( !was ){
            was = new AuthUserAuthRole(authUser:myself,authRole:roleAdmin  ).save()
            assert was
        }
    }
}

private bootstrapOld(){

    def oldDir = new File('old')
    assert oldDir.isDirectory()

    oldDir.eachFileMatch(FILES, ~ /.*[.]in/){ inFile ->
        println inFile
        def company = inFile.name.replaceAll(/[.].*/,'')
        inFile.eachLine{ line ->
            if( ! ( line =~ /#/ )){
                println "    $line"
                def values = line.tokenize(',')
                if( values.size() == 15 ){
                    def name = values[0]
                    println "Searching for $name"
                    def driver = Driver.findByName( name )
                    if( driver ){
                        println "Found $driver"
                        driver.company = company
                    }else{
                        driver = new Driver( name : name, company : company ).save()
                        println "Created $driver"
                    }
                    assert driver
log.debug ">>>${values[1]}<<< a"
                    if( driver.parameterSets.size() == 0 ){
                        driver.parameterSets << new ParameterSet()
                    }
log.debug ">>>${values[1]}<<< b"
                    driver.parameterSets[0].vas   = new BigDecimal(values[1])
                    driver.parameterSets[0].qts   = new BigDecimal(values[2])
                    driver.parameterSets[0].qes   = new BigDecimal(values[3]) 
                    driver.parameterSets[0].qms   = new BigDecimal(values[4]) 
                    driver.parameterSets[0].fs    = new BigDecimal(values[5])
                    driver.parameterSets[0].mms   = new BigDecimal(values[6])
                    driver.parameterSets[0].cms   = new BigDecimal(values[7])
                    driver.parameterSets[0].nvc   = new Integer(values[8])
                    driver.parameterSets[0].re    = new BigDecimal(values[9])
                    driver.parameterSets[0].le    = new BigDecimal(values[10])
                    driver.parameterSets[0].sd    = new BigDecimal(values[11])
                    driver.parameterSets[0].xmax  = new BigDecimal(values[12])
                    driver.parameterSets[0].spl   = new BigDecimal(values[13])
                    driver.parameterSets[0].pmax  = new BigDecimal(values[14])
                    driver.parameterSets[0].save()
                    driver.save()
                }
            }
        }
    }
}

def init = { servletContext ->

        println log.name
        println "TRACE ${log.isTraceEnabled()}"
        println "DEBUG ${log.isDebugEnabled()}"
        println "INFO  ${log.isInfoEnabled()}"

    log.info """
-----------------------------------------------------------------------
Sight startup in environment ${GrailsUtil.environment}
-----------------------------------------------------------------------"""
    searchableService.stopMirroring()

    bootstrapRole('ROLE_CONTRIBUTOR')
    bootstrapRole('ROLE_ADMIN')

    bootstrapUser('ich','Franz','Alexander','a.franz@gmx.com')

    bootstrapOld()

    searchableService.startMirroring()
    searchableService.index()
}
def destroy = {
}
}
