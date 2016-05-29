package rastrograo.propriedade



import org.junit.*
import grails.test.mixin.*

@TestFor(PropriedadeController)
@Mock(Propriedade)
class PropriedadeControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/propriedade/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.propriedadeInstanceList.size() == 0
        assert model.propriedadeInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.propriedadeInstance != null
    }

    void testSave() {
        controller.save()

        assert model.propriedadeInstance != null
        assert view == '/propriedade/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/propriedade/show/1'
        assert controller.flash.message != null
        assert Propriedade.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/propriedade/list'

        populateValidParams(params)
        def propriedade = new Propriedade(params)

        assert propriedade.save() != null

        params.id = propriedade.id

        def model = controller.show()

        assert model.propriedadeInstance == propriedade
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/propriedade/list'

        populateValidParams(params)
        def propriedade = new Propriedade(params)

        assert propriedade.save() != null

        params.id = propriedade.id

        def model = controller.edit()

        assert model.propriedadeInstance == propriedade
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/propriedade/list'

        response.reset()

        populateValidParams(params)
        def propriedade = new Propriedade(params)

        assert propriedade.save() != null

        // test invalid parameters in update
        params.id = propriedade.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/propriedade/edit"
        assert model.propriedadeInstance != null

        propriedade.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/propriedade/show/$propriedade.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        propriedade.clearErrors()

        populateValidParams(params)
        params.id = propriedade.id
        params.version = -1
        controller.update()

        assert view == "/propriedade/edit"
        assert model.propriedadeInstance != null
        assert model.propriedadeInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/propriedade/list'

        response.reset()

        populateValidParams(params)
        def propriedade = new Propriedade(params)

        assert propriedade.save() != null
        assert Propriedade.count() == 1

        params.id = propriedade.id

        controller.delete()

        assert Propriedade.count() == 0
        assert Propriedade.get(propriedade.id) == null
        assert response.redirectedUrl == '/propriedade/list'
    }
}
