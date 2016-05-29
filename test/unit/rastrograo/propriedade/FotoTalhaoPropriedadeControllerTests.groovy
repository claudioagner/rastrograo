package rastrograo.propriedade



import org.junit.*
import grails.test.mixin.*

@TestFor(FotoTalhaoPropriedadeController)
@Mock(FotoTalhaoPropriedade)
class FotoTalhaoPropriedadeControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/fotoTalhaoPropriedade/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.fotoTalhaoPropriedadeInstanceList.size() == 0
        assert model.fotoTalhaoPropriedadeInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.fotoTalhaoPropriedadeInstance != null
    }

    void testSave() {
        controller.save()

        assert model.fotoTalhaoPropriedadeInstance != null
        assert view == '/fotoTalhaoPropriedade/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/fotoTalhaoPropriedade/show/1'
        assert controller.flash.message != null
        assert FotoTalhaoPropriedade.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/fotoTalhaoPropriedade/list'

        populateValidParams(params)
        def fotoTalhaoPropriedade = new FotoTalhaoPropriedade(params)

        assert fotoTalhaoPropriedade.save() != null

        params.id = fotoTalhaoPropriedade.id

        def model = controller.show()

        assert model.fotoTalhaoPropriedadeInstance == fotoTalhaoPropriedade
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/fotoTalhaoPropriedade/list'

        populateValidParams(params)
        def fotoTalhaoPropriedade = new FotoTalhaoPropriedade(params)

        assert fotoTalhaoPropriedade.save() != null

        params.id = fotoTalhaoPropriedade.id

        def model = controller.edit()

        assert model.fotoTalhaoPropriedadeInstance == fotoTalhaoPropriedade
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/fotoTalhaoPropriedade/list'

        response.reset()

        populateValidParams(params)
        def fotoTalhaoPropriedade = new FotoTalhaoPropriedade(params)

        assert fotoTalhaoPropriedade.save() != null

        // test invalid parameters in update
        params.id = fotoTalhaoPropriedade.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/fotoTalhaoPropriedade/edit"
        assert model.fotoTalhaoPropriedadeInstance != null

        fotoTalhaoPropriedade.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/fotoTalhaoPropriedade/show/$fotoTalhaoPropriedade.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        fotoTalhaoPropriedade.clearErrors()

        populateValidParams(params)
        params.id = fotoTalhaoPropriedade.id
        params.version = -1
        controller.update()

        assert view == "/fotoTalhaoPropriedade/edit"
        assert model.fotoTalhaoPropriedadeInstance != null
        assert model.fotoTalhaoPropriedadeInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/fotoTalhaoPropriedade/list'

        response.reset()

        populateValidParams(params)
        def fotoTalhaoPropriedade = new FotoTalhaoPropriedade(params)

        assert fotoTalhaoPropriedade.save() != null
        assert FotoTalhaoPropriedade.count() == 1

        params.id = fotoTalhaoPropriedade.id

        controller.delete()

        assert FotoTalhaoPropriedade.count() == 0
        assert FotoTalhaoPropriedade.get(fotoTalhaoPropriedade.id) == null
        assert response.redirectedUrl == '/fotoTalhaoPropriedade/list'
    }
}
