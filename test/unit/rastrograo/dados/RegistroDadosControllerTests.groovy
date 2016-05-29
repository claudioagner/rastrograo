package rastrograo.dados



import org.junit.*
import grails.test.mixin.*

@TestFor(RegistroDadosController)
@Mock(RegistroDados)
class RegistroDadosControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/registroDados/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.registroDadosInstanceList.size() == 0
        assert model.registroDadosInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.registroDadosInstance != null
    }

    void testSave() {
        controller.save()

        assert model.registroDadosInstance != null
        assert view == '/registroDados/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/registroDados/show/1'
        assert controller.flash.message != null
        assert RegistroDados.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/registroDados/list'

        populateValidParams(params)
        def registroDados = new RegistroDados(params)

        assert registroDados.save() != null

        params.id = registroDados.id

        def model = controller.show()

        assert model.registroDadosInstance == registroDados
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/registroDados/list'

        populateValidParams(params)
        def registroDados = new RegistroDados(params)

        assert registroDados.save() != null

        params.id = registroDados.id

        def model = controller.edit()

        assert model.registroDadosInstance == registroDados
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/registroDados/list'

        response.reset()

        populateValidParams(params)
        def registroDados = new RegistroDados(params)

        assert registroDados.save() != null

        // test invalid parameters in update
        params.id = registroDados.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/registroDados/edit"
        assert model.registroDadosInstance != null

        registroDados.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/registroDados/show/$registroDados.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        registroDados.clearErrors()

        populateValidParams(params)
        params.id = registroDados.id
        params.version = -1
        controller.update()

        assert view == "/registroDados/edit"
        assert model.registroDadosInstance != null
        assert model.registroDadosInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/registroDados/list'

        response.reset()

        populateValidParams(params)
        def registroDados = new RegistroDados(params)

        assert registroDados.save() != null
        assert RegistroDados.count() == 1

        params.id = registroDados.id

        controller.delete()

        assert RegistroDados.count() == 0
        assert RegistroDados.get(registroDados.id) == null
        assert response.redirectedUrl == '/registroDados/list'
    }
}
