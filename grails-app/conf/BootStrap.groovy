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

    searchableService.startMirroring()
    searchableService.index()
}
def destroy = {
}
}
