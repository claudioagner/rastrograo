package rastrograo.estrutura



import org.junit.*
import grails.test.mixin.*

@TestFor(AtributoController)
@Mock(Atributo)
class AtributoControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/atributo/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.atributoInstanceList.size() == 0
        assert model.atributoInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.atributoInstance != null
    }

    void testSave() {
        controller.save()

        assert model.atributoInstance != null
        assert view == '/atributo/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/atributo/show/1'
        assert controller.flash.message != null
        assert Atributo.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/atributo/list'

        populateValidParams(params)
        def atributo = new Atributo(params)

        assert atributo.save() != null

        params.id = atributo.id

        def model = controller.show()

        assert model.atributoInstance == atributo
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/atributo/list'

        populateValidParams(params)
        def atributo = new Atributo(params)

        assert atributo.save() != null

        params.id = atributo.id

        def model = controller.edit()

        assert model.atributoInstance == atributo
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/atributo/list'

        response.reset()

        populateValidParams(params)
        def atributo = new Atributo(params)

        assert atributo.save() != null

        // test invalid parameters in update
        params.id = atributo.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/atributo/edit"
        assert model.atributoInstance != null

        atributo.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/atributo/show/$atributo.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        atributo.clearErrors()

        populateValidParams(params)
        params.id = atributo.id
        params.version = -1
        controller.update()

        assert view == "/atributo/edit"
        assert model.atributoInstance != null
        assert model.atributoInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/atributo/list'

        response.reset()

        populateValidParams(params)
        def atributo = new Atributo(params)

        assert atributo.save() != null
        assert Atributo.count() == 1

        params.id = atributo.id

        controller.delete()

        assert Atributo.count() == 0
        assert Atributo.get(atributo.id) == null
        assert response.redirectedUrl == '/atributo/list'
    }
}
