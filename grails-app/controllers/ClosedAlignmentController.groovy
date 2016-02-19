

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ClosedAlignmentController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond ClosedAlignment.list(params), model:[closedAlignmentInstanceCount: ClosedAlignment.count()]
    }

    def show(ClosedAlignment closedAlignmentInstance) {
        respond closedAlignmentInstance
    }

    def create() {
        respond new ClosedAlignment(params)
    }

    @Transactional
    def save(ClosedAlignment closedAlignmentInstance) {
        if (closedAlignmentInstance == null) {
            notFound()
            return
        }

        if (closedAlignmentInstance.hasErrors()) {
            respond closedAlignmentInstance.errors, view:'create'
            return
        }

        closedAlignmentInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'closedAlignment.label', default: 'ClosedAlignment'), closedAlignmentInstance.id])
                redirect closedAlignmentInstance
            }
            '*' { respond closedAlignmentInstance, [status: CREATED] }
        }
    }

    def edit(ClosedAlignment closedAlignmentInstance) {
        respond closedAlignmentInstance
    }

    @Transactional
    def update(ClosedAlignment closedAlignmentInstance) {
        if (closedAlignmentInstance == null) {
            notFound()
            return
        }

        if (closedAlignmentInstance.hasErrors()) {
            respond closedAlignmentInstance.errors, view:'edit'
            return
        }

        closedAlignmentInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'ClosedAlignment.label', default: 'ClosedAlignment'), closedAlignmentInstance.id])
                redirect closedAlignmentInstance
            }
            '*'{ respond closedAlignmentInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(ClosedAlignment closedAlignmentInstance) {

        if (closedAlignmentInstance == null) {
            notFound()
            return
        }

        closedAlignmentInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'ClosedAlignment.label', default: 'ClosedAlignment'), closedAlignmentInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'closedAlignment.label', default: 'ClosedAlignment'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
