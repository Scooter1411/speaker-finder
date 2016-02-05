

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ClosedEnclosureController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond ClosedEnclosure.list(params), model:[closedEnclosureInstanceCount: ClosedEnclosure.count()]
    }

    def show(ClosedEnclosure closedEnclosureInstance) {
        respond closedEnclosureInstance
    }

    def create() {
        respond new ClosedEnclosure(params)
    }

    @Transactional
    def save(ClosedEnclosure closedEnclosureInstance) {
        if (closedEnclosureInstance == null) {
            notFound()
            return
        }

        if (closedEnclosureInstance.hasErrors()) {
            respond closedEnclosureInstance.errors, view:'create'
            return
        }

        closedEnclosureInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'closedEnclosure.label', default: 'ClosedEnclosure'), closedEnclosureInstance.id])
                redirect closedEnclosureInstance
            }
            '*' { respond closedEnclosureInstance, [status: CREATED] }
        }
    }

    def edit(ClosedEnclosure closedEnclosureInstance) {
        respond closedEnclosureInstance
    }

    @Transactional
    def update(ClosedEnclosure closedEnclosureInstance) {
        if (closedEnclosureInstance == null) {
            notFound()
            return
        }

        if (closedEnclosureInstance.hasErrors()) {
            respond closedEnclosureInstance.errors, view:'edit'
            return
        }

        closedEnclosureInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'ClosedEnclosure.label', default: 'ClosedEnclosure'), closedEnclosureInstance.id])
                redirect closedEnclosureInstance
            }
            '*'{ respond closedEnclosureInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(ClosedEnclosure closedEnclosureInstance) {

        if (closedEnclosureInstance == null) {
            notFound()
            return
        }

        closedEnclosureInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'ClosedEnclosure.label', default: 'ClosedEnclosure'), closedEnclosureInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'closedEnclosure.label', default: 'ClosedEnclosure'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
