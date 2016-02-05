

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class VentedAlignmentController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond VentedAlignment.list(params), model:[ventedAlignmentInstanceCount: VentedAlignment.count()]
    }

    def show(VentedAlignment ventedAlignmentInstance) {
        respond ventedAlignmentInstance
    }

    def create() {
        respond new VentedAlignment(params)
    }

    @Transactional
    def save(VentedAlignment ventedAlignmentInstance) {
        if (ventedAlignmentInstance == null) {
            notFound()
            return
        }

        if (ventedAlignmentInstance.hasErrors()) {
            respond ventedAlignmentInstance.errors, view:'create'
            return
        }

        ventedAlignmentInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'ventedAlignment.label', default: 'VentedAlignment'), ventedAlignmentInstance.id])
                redirect ventedAlignmentInstance
            }
            '*' { respond ventedAlignmentInstance, [status: CREATED] }
        }
    }

    def edit(VentedAlignment ventedAlignmentInstance) {
        respond ventedAlignmentInstance
    }

    @Transactional
    def update(VentedAlignment ventedAlignmentInstance) {
        if (ventedAlignmentInstance == null) {
            notFound()
            return
        }

        if (ventedAlignmentInstance.hasErrors()) {
            respond ventedAlignmentInstance.errors, view:'edit'
            return
        }

        ventedAlignmentInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'VentedAlignment.label', default: 'VentedAlignment'), ventedAlignmentInstance.id])
                redirect ventedAlignmentInstance
            }
            '*'{ respond ventedAlignmentInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(VentedAlignment ventedAlignmentInstance) {

        if (ventedAlignmentInstance == null) {
            notFound()
            return
        }

        ventedAlignmentInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'VentedAlignment.label', default: 'VentedAlignment'), ventedAlignmentInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'ventedAlignment.label', default: 'VentedAlignment'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
