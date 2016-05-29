package rastrograo.customizacao



import org.junit.*
import grails.test.mixin.*

@TestFor(RastroFaseController)
@Mock(RastroFase)
class RastroFaseControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/rastroFase/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.rastroFaseInstanceList.size() == 0
        assert model.rastroFaseInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.rastroFaseInstance != null
    }

    void testSave() {
        controller.save()

        assert model.rastroFaseInstance != null
        assert view == '/rastroFase/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/rastroFase/show/1'
        assert controller.flash.message != null
        assert RastroFase.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/rastroFase/list'

        populateValidParams(params)
        def rastroFase = new RastroFase(params)

        assert rastroFase.save() != null

        params.id = rastroFase.id

        def model = controller.show()

        assert model.rastroFaseInstance == rastroFase
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/rastroFase/list'

        populateValidParams(params)
        def rastroFase = new RastroFase(params)

        assert rastroFase.save() != null

        params.id = rastroFase.id

        def model = controller.edit()

        assert model.rastroFaseInstance == rastroFase
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/rastroFase/list'

        response.reset()

        populateValidParams(params)
        def rastroFase = new RastroFase(params)

        assert rastroFase.save() != null

        // test invalid parameters in update
        params.id = rastroFase.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/rastroFase/edit"
        assert model.rastroFaseInstance != null

        rastroFase.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/rastroFase/show/$rastroFase.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        rastroFase.clearErrors()

        populateValidParams(params)
        params.id = rastroFase.id
        params.version = -1
        controller.update()

        assert view == "/rastroFase/edit"
        assert model.rastroFaseInstance != null
        assert model.rastroFaseInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/rastroFase/list'

        response.reset()

        populateValidParams(params)
        def rastroFase = new RastroFase(params)

        assert rastroFase.save() != null
        assert RastroFase.count() == 1

        params.id = rastroFase.id

        controller.delete()

        assert RastroFase.count() == 0
        assert RastroFase.get(rastroFase.id) == null
        assert response.redirectedUrl == '/rastroFase/list'
    }
}
