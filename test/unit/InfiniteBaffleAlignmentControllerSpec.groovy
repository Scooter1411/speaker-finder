

import grails.test.mixin.*
import spock.lang.*

@TestFor(InfiniteBaffleAlignmentController)
@Mock(InfiniteBaffleAlignment)
class InfiniteBaffleAlignmentControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void "Test the index action returns the correct model"() {

        when:"The index action is executed"
            controller.index()

        then:"The model is correct"
            !model.infiniteBaffleAlignmentInstanceList
            model.infiniteBaffleAlignmentInstanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when:"The create action is executed"
            controller.create()

        then:"The model is correctly created"
            model.infiniteBaffleAlignmentInstance!= null
    }

    void "Test the save action correctly persists an instance"() {

        when:"The save action is executed with an invalid instance"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'POST'
            def infiniteBaffleAlignment = new InfiniteBaffleAlignment()
            infiniteBaffleAlignment.validate()
            controller.save(infiniteBaffleAlignment)

        then:"The create view is rendered again with the correct model"
            model.infiniteBaffleAlignmentInstance!= null
            view == 'create'

        when:"The save action is executed with a valid instance"
            response.reset()
            populateValidParams(params)
            infiniteBaffleAlignment = new InfiniteBaffleAlignment(params)

            controller.save(infiniteBaffleAlignment)

        then:"A redirect is issued to the show action"
            response.redirectedUrl == '/infiniteBaffleAlignment/show/1'
            controller.flash.message != null
            InfiniteBaffleAlignment.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when:"The show action is executed with a null domain"
            controller.show(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the show action"
            populateValidParams(params)
            def infiniteBaffleAlignment = new InfiniteBaffleAlignment(params)
            controller.show(infiniteBaffleAlignment)

        then:"A model is populated containing the domain instance"
            model.infiniteBaffleAlignmentInstance == infiniteBaffleAlignment
    }

    void "Test that the edit action returns the correct model"() {
        when:"The edit action is executed with a null domain"
            controller.edit(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the edit action"
            populateValidParams(params)
            def infiniteBaffleAlignment = new InfiniteBaffleAlignment(params)
            controller.edit(infiniteBaffleAlignment)

        then:"A model is populated containing the domain instance"
            model.infiniteBaffleAlignmentInstance == infiniteBaffleAlignment
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when:"Update is called for a domain instance that doesn't exist"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'PUT'
            controller.update(null)

        then:"A 404 error is returned"
            response.redirectedUrl == '/infiniteBaffleAlignment/index'
            flash.message != null


        when:"An invalid domain instance is passed to the update action"
            response.reset()
            def infiniteBaffleAlignment = new InfiniteBaffleAlignment()
            infiniteBaffleAlignment.validate()
            controller.update(infiniteBaffleAlignment)

        then:"The edit view is rendered again with the invalid instance"
            view == 'edit'
            model.infiniteBaffleAlignmentInstance == infiniteBaffleAlignment

        when:"A valid domain instance is passed to the update action"
            response.reset()
            populateValidParams(params)
            infiniteBaffleAlignment = new InfiniteBaffleAlignment(params).save(flush: true)
            controller.update(infiniteBaffleAlignment)

        then:"A redirect is issues to the show action"
            response.redirectedUrl == "/infiniteBaffleAlignment/show/$infiniteBaffleAlignment.id"
            flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when:"The delete action is called for a null instance"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'DELETE'
            controller.delete(null)

        then:"A 404 is returned"
            response.redirectedUrl == '/infiniteBaffleAlignment/index'
            flash.message != null

        when:"A domain instance is created"
            response.reset()
            populateValidParams(params)
            def infiniteBaffleAlignment = new InfiniteBaffleAlignment(params).save(flush: true)

        then:"It exists"
            InfiniteBaffleAlignment.count() == 1

        when:"The domain instance is passed to the delete action"
            controller.delete(infiniteBaffleAlignment)

        then:"The instance is deleted"
            InfiniteBaffleAlignment.count() == 0
            response.redirectedUrl == '/infiniteBaffleAlignment/index'
            flash.message != null
    }
}
