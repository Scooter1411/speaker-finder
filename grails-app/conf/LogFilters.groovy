import org.springframework.web.servlet.support.RequestContextUtils

/**
 * Global filter on actions to implement global logging.
 * $Id: LogFilters.groovy 2229 2015-08-13 09:06:42Z thf11q $
 */
class LogFilters {
	
    def start
	
    def filters = {
        all(controller:'login|logout', invert:true) {

            before = {
                start = System.currentTimeMillis()
				def ctrl = controllerName ?: 'home'
				def actn = actionName ?: 'index'
                log.info  "************ Invoking $ctrl controller with action '$actn'"
			}

            after = {
				def ctrl = controllerName ?: 'home'
				def actn = actionName ?: 'index'
                def delta = sprintf( '%7.3f sec', (System.currentTimeMillis() - start)/1000 )
            	log.info """************ Exiting $ctrl controller with action '$actn' after $delta
"""
            }

            afterView = {
				def ctrl = controllerName ?: 'home'
				def actn = actionName ?: 'index'
                def delta = sprintf( '%7.3f sec', (System.currentTimeMillis() - start)/1000 )
            	log.info """****** View rendered $ctrl controller with action '$actn' after $delta
"""
            }
        }
    }
}
