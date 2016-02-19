

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class TubeController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Tube.list(params), model:[tubeInstanceCount: Tube.count()]
    }

    def show(Tube tubeInstance) {
        respond tubeInstance
    }

    def create() {
        respond new Tube(params)
    }

    @Transactional
    def save(Tube tubeInstance) {
        if (tubeInstance == null) {
            notFound()
            return
        }

        if (tubeInstance.hasErrors()) {
            respond tubeInstance.errors, view:'create'
            return
        }

        tubeInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'tube.label', default: 'Tube'), tubeInstance.id])
                redirect tubeInstance
            }
            '*' { respond tubeInstance, [status: CREATED] }
        }
    }

    def edit(Tube tubeInstance) {
        respond tubeInstance
    }

    @Transactional
    def update(Tube tubeInstance) {
        if (tubeInstance == null) {
            notFound()
            return
        }

        if (tubeInstance.hasErrors()) {
            respond tubeInstance.errors, view:'edit'
            return
        }

        tubeInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Tube.label', default: 'Tube'), tubeInstance.id])
                redirect tubeInstance
            }
            '*'{ respond tubeInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Tube tubeInstance) {

        if (tubeInstance == null) {
            notFound()
            return
        }

        tubeInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Tube.label', default: 'Tube'), tubeInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'tube.label', default: 'Tube'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
