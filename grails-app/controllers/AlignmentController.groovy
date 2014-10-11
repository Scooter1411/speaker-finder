

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class AlignmentController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Alignment.list(params), model:[alignmentInstanceCount: Alignment.count()]
    }

    def show(Alignment alignmentInstance) {
        respond alignmentInstance
    }

    def create() {
        respond new Alignment(params)
    }

    @Transactional
    def save(Alignment alignmentInstance) {
        if (alignmentInstance == null) {
            notFound()
            return
        }

        if (alignmentInstance.hasErrors()) {
            respond alignmentInstance.errors, view:'create'
            return
        }

        alignmentInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'alignment.label', default: 'Alignment'), alignmentInstance.id])
                redirect alignmentInstance
            }
            '*' { respond alignmentInstance, [status: CREATED] }
        }
    }

    def edit(Alignment alignmentInstance) {
        respond alignmentInstance
    }

    @Transactional
    def update(Alignment alignmentInstance) {
        if (alignmentInstance == null) {
            notFound()
            return
        }

        if (alignmentInstance.hasErrors()) {
            respond alignmentInstance.errors, view:'edit'
            return
        }

        alignmentInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Alignment.label', default: 'Alignment'), alignmentInstance.id])
                redirect alignmentInstance
            }
            '*'{ respond alignmentInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Alignment alignmentInstance) {

        if (alignmentInstance == null) {
            notFound()
            return
        }

        alignmentInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Alignment.label', default: 'Alignment'), alignmentInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'alignment.label', default: 'Alignment'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
