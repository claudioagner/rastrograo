package rastrograo.propriedade



import org.junit.*
import grails.test.mixin.*

@TestFor(FotoPropriedadeController)
@Mock(FotoPropriedade)
class FotoPropriedadeControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/fotoPropriedade/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.fotoPropriedadeInstanceList.size() == 0
        assert model.fotoPropriedadeInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.fotoPropriedadeInstance != null
    }

    void testSave() {
        controller.save()

        assert model.fotoPropriedadeInstance != null
        assert view == '/fotoPropriedade/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/fotoPropriedade/show/1'
        assert controller.flash.message != null
        assert FotoPropriedade.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/fotoPropriedade/list'

        populateValidParams(params)
        def fotoPropriedade = new FotoPropriedade(params)

        assert fotoPropriedade.save() != null

        params.id = fotoPropriedade.id

        def model = controller.show()

        assert model.fotoPropriedadeInstance == fotoPropriedade
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/fotoPropriedade/list'

        populateValidParams(params)
        def fotoPropriedade = new FotoPropriedade(params)

        assert fotoPropriedade.save() != null

        params.id = fotoPropriedade.id

        def model = controller.edit()

        assert model.fotoPropriedadeInstance == fotoPropriedade
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/fotoPropriedade/list'

        response.reset()

        populateValidParams(params)
        def fotoPropriedade = new FotoPropriedade(params)

        assert fotoPropriedade.save() != null

        // test invalid parameters in update
        params.id = fotoPropriedade.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/fotoPropriedade/edit"
        assert model.fotoPropriedadeInstance != null

        fotoPropriedade.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/fotoPropriedade/show/$fotoPropriedade.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        fotoPropriedade.clearErrors()

        populateValidParams(params)
        params.id = fotoPropriedade.id
        params.version = -1
        controller.update()

        assert view == "/fotoPropriedade/edit"
        assert model.fotoPropriedadeInstance != null
        assert model.fotoPropriedadeInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/fotoPropriedade/list'

        response.reset()

        populateValidParams(params)
        def fotoPropriedade = new FotoPropriedade(params)

        assert fotoPropriedade.save() != null
        assert FotoPropriedade.count() == 1

        params.id = fotoPropriedade.id

        controller.delete()

        assert FotoPropriedade.count() == 0
        assert FotoPropriedade.get(fotoPropriedade.id) == null
        assert response.redirectedUrl == '/fotoPropriedade/list'
    }
}
