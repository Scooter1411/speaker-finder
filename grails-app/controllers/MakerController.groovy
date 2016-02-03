

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class MakerController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Maker.list(params), model:[makerInstanceCount: Maker.count()]
    }

    def show(Maker makerInstance) {
        respond makerInstance
    }

    def create() {
        respond new Maker(params)
    }

    @Transactional
    def save(Maker makerInstance) {
        if (makerInstance == null) {
            notFound()
            return
        }

        if (makerInstance.hasErrors()) {
            respond makerInstance.errors, view:'create'
            return
        }

        makerInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'maker.label', default: 'Maker'), makerInstance.id])
                redirect makerInstance
            }
            '*' { respond makerInstance, [status: CREATED] }
        }
    }

    def edit(Maker makerInstance) {
        respond makerInstance
    }

    @Transactional
    def update(Maker makerInstance) {
        if (makerInstance == null) {
            notFound()
            return
        }

        if (makerInstance.hasErrors()) {
            respond makerInstance.errors, view:'edit'
            return
        }

        makerInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Maker.label', default: 'Maker'), makerInstance.id])
                redirect makerInstance
            }
            '*'{ respond makerInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Maker makerInstance) {

        if (makerInstance == null) {
            notFound()
            return
        }

        makerInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Maker.label', default: 'Maker'), makerInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'maker.label', default: 'Maker'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
