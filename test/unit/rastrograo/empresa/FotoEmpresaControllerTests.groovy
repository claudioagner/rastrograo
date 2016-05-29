package rastrograo.empresa



import org.junit.*
import grails.test.mixin.*

@TestFor(FotoEmpresaController)
@Mock(FotoEmpresa)
class FotoEmpresaControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/fotoEmpresa/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.fotoEmpresaInstanceList.size() == 0
        assert model.fotoEmpresaInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.fotoEmpresaInstance != null
    }

    void testSave() {
        controller.save()

        assert model.fotoEmpresaInstance != null
        assert view == '/fotoEmpresa/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/fotoEmpresa/show/1'
        assert controller.flash.message != null
        assert FotoEmpresa.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/fotoEmpresa/list'

        populateValidParams(params)
        def fotoEmpresa = new FotoEmpresa(params)

        assert fotoEmpresa.save() != null

        params.id = fotoEmpresa.id

        def model = controller.show()

        assert model.fotoEmpresaInstance == fotoEmpresa
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/fotoEmpresa/list'

        populateValidParams(params)
        def fotoEmpresa = new FotoEmpresa(params)

        assert fotoEmpresa.save() != null

        params.id = fotoEmpresa.id

        def model = controller.edit()

        assert model.fotoEmpresaInstance == fotoEmpresa
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/fotoEmpresa/list'

        response.reset()

        populateValidParams(params)
        def fotoEmpresa = new FotoEmpresa(params)

        assert fotoEmpresa.save() != null

        // test invalid parameters in update
        params.id = fotoEmpresa.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/fotoEmpresa/edit"
        assert model.fotoEmpresaInstance != null

        fotoEmpresa.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/fotoEmpresa/show/$fotoEmpresa.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        fotoEmpresa.clearErrors()

        populateValidParams(params)
        params.id = fotoEmpresa.id
        params.version = -1
        controller.update()

        assert view == "/fotoEmpresa/edit"
        assert model.fotoEmpresaInstance != null
        assert model.fotoEmpresaInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/fotoEmpresa/list'

        response.reset()

        populateValidParams(params)
        def fotoEmpresa = new FotoEmpresa(params)

        assert fotoEmpresa.save() != null
        assert FotoEmpresa.count() == 1

        params.id = fotoEmpresa.id

        controller.delete()

        assert FotoEmpresa.count() == 0
        assert FotoEmpresa.get(fotoEmpresa.id) == null
        assert response.redirectedUrl == '/fotoEmpresa/list'
    }
}
