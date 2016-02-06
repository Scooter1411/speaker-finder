

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class EnclosureController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Enclosure.list(params), model:[enclosureInstanceCount: Enclosure.count()]
    }

    def show(Enclosure enclosureInstance) {
        respond enclosureInstance
    }

    def create() {
        respond new Enclosure(params)
    }

    @Transactional
    def save(Enclosure enclosureInstance) {
        if (enclosureInstance == null) {
            notFound()
            return
        }

        if (enclosureInstance.hasErrors()) {
            respond enclosureInstance.errors, view:'create'
            return
        }

        enclosureInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'enclosure.label', default: 'Enclosure'), enclosureInstance.id])
                redirect enclosureInstance
            }
            '*' { respond enclosureInstance, [status: CREATED] }
        }
    }

    def edit(Enclosure enclosureInstance) {
        respond enclosureInstance
    }

    @Transactional
    def update(Enclosure enclosureInstance) {
        if (enclosureInstance == null) {
            notFound()
            return
        }

        if (enclosureInstance.hasErrors()) {
            respond enclosureInstance.errors, view:'edit'
            return
        }

        enclosureInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Enclosure.label', default: 'Enclosure'), enclosureInstance.id])
                redirect enclosureInstance
            }
            '*'{ respond enclosureInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Enclosure enclosureInstance) {

        if (enclosureInstance == null) {
            notFound()
            return
        }

        enclosureInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Enclosure.label', default: 'Enclosure'), enclosureInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'enclosure.label', default: 'Enclosure'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
