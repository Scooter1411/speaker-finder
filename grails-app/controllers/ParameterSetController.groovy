

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ParameterSetController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond ParameterSet.list(params), model:[parameterSetInstanceCount: ParameterSet.count()]
    }

    def show(ParameterSet parameterSetInstance) {
        respond parameterSetInstance
    }

    def create() {
        respond new ParameterSet(params)
    }

    @Transactional
    def save(ParameterSet parameterSetInstance) {
        if (parameterSetInstance == null) {
            notFound()
            return
        }

        if (parameterSetInstance.hasErrors()) {
            respond parameterSetInstance.errors, view:'create'
            return
        }

        parameterSetInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'parameterSet.label', default: 'ParameterSet'), parameterSetInstance.id])
                redirect parameterSetInstance
            }
            '*' { respond parameterSetInstance, [status: CREATED] }
        }
    }

    def edit(ParameterSet parameterSetInstance) {
        respond parameterSetInstance
    }

    @Transactional
    def update(ParameterSet parameterSetInstance) {
        if (parameterSetInstance == null) {
            notFound()
            return
        }

        if (parameterSetInstance.hasErrors()) {
            respond parameterSetInstance.errors, view:'edit'
            return
        }

        parameterSetInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'ParameterSet.label', default: 'ParameterSet'), parameterSetInstance.id])
                redirect parameterSetInstance
            }
            '*'{ respond parameterSetInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(ParameterSet parameterSetInstance) {

        if (parameterSetInstance == null) {
            notFound()
            return
        }

        parameterSetInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'ParameterSet.label', default: 'ParameterSet'), parameterSetInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'parameterSet.label', default: 'ParameterSet'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
