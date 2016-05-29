package rastrograo.customizacao



import org.junit.*
import grails.test.mixin.*

@TestFor(RastroAtributoController)
@Mock(RastroAtributo)
class RastroAtributoControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/rastroAtributo/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.rastroAtributoInstanceList.size() == 0
        assert model.rastroAtributoInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.rastroAtributoInstance != null
    }

    void testSave() {
        controller.save()

        assert model.rastroAtributoInstance != null
        assert view == '/rastroAtributo/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/rastroAtributo/show/1'
        assert controller.flash.message != null
        assert RastroAtributo.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/rastroAtributo/list'

        populateValidParams(params)
        def rastroAtributo = new RastroAtributo(params)

        assert rastroAtributo.save() != null

        params.id = rastroAtributo.id

        def model = controller.show()

        assert model.rastroAtributoInstance == rastroAtributo
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/rastroAtributo/list'

        populateValidParams(params)
        def rastroAtributo = new RastroAtributo(params)

        assert rastroAtributo.save() != null

        params.id = rastroAtributo.id

        def model = controller.edit()

        assert model.rastroAtributoInstance == rastroAtributo
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/rastroAtributo/list'

        response.reset()

        populateValidParams(params)
        def rastroAtributo = new RastroAtributo(params)

        assert rastroAtributo.save() != null

        // test invalid parameters in update
        params.id = rastroAtributo.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/rastroAtributo/edit"
        assert model.rastroAtributoInstance != null

        rastroAtributo.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/rastroAtributo/show/$rastroAtributo.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        rastroAtributo.clearErrors()

        populateValidParams(params)
        params.id = rastroAtributo.id
        params.version = -1
        controller.update()

        assert view == "/rastroAtributo/edit"
        assert model.rastroAtributoInstance != null
        assert model.rastroAtributoInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/rastroAtributo/list'

        response.reset()

        populateValidParams(params)
        def rastroAtributo = new RastroAtributo(params)

        assert rastroAtributo.save() != null
        assert RastroAtributo.count() == 1

        params.id = rastroAtributo.id

        controller.delete()

        assert RastroAtributo.count() == 0
        assert RastroAtributo.get(rastroAtributo.id) == null
        assert response.redirectedUrl == '/rastroAtributo/list'
    }
}
