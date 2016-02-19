

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class VentedEnclosureController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond VentedEnclosure.list(params), model:[ventedEnclosureInstanceCount: VentedEnclosure.count()]
    }

    def show(VentedEnclosure ventedEnclosureInstance) {
        respond ventedEnclosureInstance
    }

    def create() {
        respond new VentedEnclosure(params)
    }

    @Transactional
    def save(VentedEnclosure ventedEnclosureInstance) {
        if (ventedEnclosureInstance == null) {
            notFound()
            return
        }

        if (ventedEnclosureInstance.hasErrors()) {
            respond ventedEnclosureInstance.errors, view:'create'
            return
        }

        ventedEnclosureInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'ventedEnclosure.label', default: 'VentedEnclosure'), ventedEnclosureInstance.id])
                redirect ventedEnclosureInstance
            }
            '*' { respond ventedEnclosureInstance, [status: CREATED] }
        }
    }

    def edit(VentedEnclosure ventedEnclosureInstance) {
        respond ventedEnclosureInstance
    }

    @Transactional
    def update(VentedEnclosure ventedEnclosureInstance) {
        if (ventedEnclosureInstance == null) {
            notFound()
            return
        }

        if (ventedEnclosureInstance.hasErrors()) {
            respond ventedEnclosureInstance.errors, view:'edit'
            return
        }

        ventedEnclosureInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'VentedEnclosure.label', default: 'VentedEnclosure'), ventedEnclosureInstance.id])
                redirect ventedEnclosureInstance
            }
            '*'{ respond ventedEnclosureInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(VentedEnclosure ventedEnclosureInstance) {

        if (ventedEnclosureInstance == null) {
            notFound()
            return
        }

        ventedEnclosureInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'VentedEnclosure.label', default: 'VentedEnclosure'), ventedEnclosureInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'ventedEnclosure.label', default: 'VentedEnclosure'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
