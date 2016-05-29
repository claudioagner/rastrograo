package rastrograo.empresa



import org.junit.*
import grails.test.mixin.*

@TestFor(CertificacaoEmpresaController)
@Mock(CertificacaoEmpresa)
class CertificacaoEmpresaControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/certificacaoEmpresa/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.certificacaoEmpresaInstanceList.size() == 0
        assert model.certificacaoEmpresaInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.certificacaoEmpresaInstance != null
    }

    void testSave() {
        controller.save()

        assert model.certificacaoEmpresaInstance != null
        assert view == '/certificacaoEmpresa/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/certificacaoEmpresa/show/1'
        assert controller.flash.message != null
        assert CertificacaoEmpresa.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/certificacaoEmpresa/list'

        populateValidParams(params)
        def certificacaoEmpresa = new CertificacaoEmpresa(params)

        assert certificacaoEmpresa.save() != null

        params.id = certificacaoEmpresa.id

        def model = controller.show()

        assert model.certificacaoEmpresaInstance == certificacaoEmpresa
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/certificacaoEmpresa/list'

        populateValidParams(params)
        def certificacaoEmpresa = new CertificacaoEmpresa(params)

        assert certificacaoEmpresa.save() != null

        params.id = certificacaoEmpresa.id

        def model = controller.edit()

        assert model.certificacaoEmpresaInstance == certificacaoEmpresa
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/certificacaoEmpresa/list'

        response.reset()

        populateValidParams(params)
        def certificacaoEmpresa = new CertificacaoEmpresa(params)

        assert certificacaoEmpresa.save() != null

        // test invalid parameters in update
        params.id = certificacaoEmpresa.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/certificacaoEmpresa/edit"
        assert model.certificacaoEmpresaInstance != null

        certificacaoEmpresa.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/certificacaoEmpresa/show/$certificacaoEmpresa.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        certificacaoEmpresa.clearErrors()

        populateValidParams(params)
        params.id = certificacaoEmpresa.id
        params.version = -1
        controller.update()

        assert view == "/certificacaoEmpresa/edit"
        assert model.certificacaoEmpresaInstance != null
        assert model.certificacaoEmpresaInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/certificacaoEmpresa/list'

        response.reset()

        populateValidParams(params)
        def certificacaoEmpresa = new CertificacaoEmpresa(params)

        assert certificacaoEmpresa.save() != null
        assert CertificacaoEmpresa.count() == 1

        params.id = certificacaoEmpresa.id

        controller.delete()

        assert CertificacaoEmpresa.count() == 0
        assert CertificacaoEmpresa.get(certificacaoEmpresa.id) == null
        assert response.redirectedUrl == '/certificacaoEmpresa/list'
    }
}
