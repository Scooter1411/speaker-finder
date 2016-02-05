

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class InfiniteBaffleAlignmentController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond InfiniteBaffleAlignment.list(params), model:[infiniteBaffleAlignmentInstanceCount: InfiniteBaffleAlignment.count()]
    }

    def show(InfiniteBaffleAlignment infiniteBaffleAlignmentInstance) {
        respond infiniteBaffleAlignmentInstance
    }

    def create() {
        respond new InfiniteBaffleAlignment(params)
    }

    @Transactional
    def save(InfiniteBaffleAlignment infiniteBaffleAlignmentInstance) {
        if (infiniteBaffleAlignmentInstance == null) {
            notFound()
            return
        }

        if (infiniteBaffleAlignmentInstance.hasErrors()) {
            respond infiniteBaffleAlignmentInstance.errors, view:'create'
            return
        }

        infiniteBaffleAlignmentInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'infiniteBaffleAlignment.label', default: 'InfiniteBaffleAlignment'), infiniteBaffleAlignmentInstance.id])
                redirect infiniteBaffleAlignmentInstance
            }
            '*' { respond infiniteBaffleAlignmentInstance, [status: CREATED] }
        }
    }

    def edit(InfiniteBaffleAlignment infiniteBaffleAlignmentInstance) {
        respond infiniteBaffleAlignmentInstance
    }

    @Transactional
    def update(InfiniteBaffleAlignment infiniteBaffleAlignmentInstance) {
        if (infiniteBaffleAlignmentInstance == null) {
            notFound()
            return
        }

        if (infiniteBaffleAlignmentInstance.hasErrors()) {
            respond infiniteBaffleAlignmentInstance.errors, view:'edit'
            return
        }

        infiniteBaffleAlignmentInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'InfiniteBaffleAlignment.label', default: 'InfiniteBaffleAlignment'), infiniteBaffleAlignmentInstance.id])
                redirect infiniteBaffleAlignmentInstance
            }
            '*'{ respond infiniteBaffleAlignmentInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(InfiniteBaffleAlignment infiniteBaffleAlignmentInstance) {

        if (infiniteBaffleAlignmentInstance == null) {
            notFound()
            return
        }

        infiniteBaffleAlignmentInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'InfiniteBaffleAlignment.label', default: 'InfiniteBaffleAlignment'), infiniteBaffleAlignmentInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'infiniteBaffleAlignment.label', default: 'InfiniteBaffleAlignment'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
