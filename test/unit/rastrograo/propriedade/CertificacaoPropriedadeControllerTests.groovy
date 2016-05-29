package rastrograo.propriedade



import org.junit.*
import grails.test.mixin.*

@TestFor(CertificacaoPropriedadeController)
@Mock(CertificacaoPropriedade)
class CertificacaoPropriedadeControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/certificacaoPropriedade/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.certificacaoPropriedadeInstanceList.size() == 0
        assert model.certificacaoPropriedadeInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.certificacaoPropriedadeInstance != null
    }

    void testSave() {
        controller.save()

        assert model.certificacaoPropriedadeInstance != null
        assert view == '/certificacaoPropriedade/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/certificacaoPropriedade/show/1'
        assert controller.flash.message != null
        assert CertificacaoPropriedade.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/certificacaoPropriedade/list'

        populateValidParams(params)
        def certificacaoPropriedade = new CertificacaoPropriedade(params)

        assert certificacaoPropriedade.save() != null

        params.id = certificacaoPropriedade.id

        def model = controller.show()

        assert model.certificacaoPropriedadeInstance == certificacaoPropriedade
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/certificacaoPropriedade/list'

        populateValidParams(params)
        def certificacaoPropriedade = new CertificacaoPropriedade(params)

        assert certificacaoPropriedade.save() != null

        params.id = certificacaoPropriedade.id

        def model = controller.edit()

        assert model.certificacaoPropriedadeInstance == certificacaoPropriedade
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/certificacaoPropriedade/list'

        response.reset()

        populateValidParams(params)
        def certificacaoPropriedade = new CertificacaoPropriedade(params)

        assert certificacaoPropriedade.save() != null

        // test invalid parameters in update
        params.id = certificacaoPropriedade.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/certificacaoPropriedade/edit"
        assert model.certificacaoPropriedadeInstance != null

        certificacaoPropriedade.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/certificacaoPropriedade/show/$certificacaoPropriedade.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        certificacaoPropriedade.clearErrors()

        populateValidParams(params)
        params.id = certificacaoPropriedade.id
        params.version = -1
        controller.update()

        assert view == "/certificacaoPropriedade/edit"
        assert model.certificacaoPropriedadeInstance != null
        assert model.certificacaoPropriedadeInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/certificacaoPropriedade/list'

        response.reset()

        populateValidParams(params)
        def certificacaoPropriedade = new CertificacaoPropriedade(params)

        assert certificacaoPropriedade.save() != null
        assert CertificacaoPropriedade.count() == 1

        params.id = certificacaoPropriedade.id

        controller.delete()

        assert CertificacaoPropriedade.count() == 0
        assert CertificacaoPropriedade.get(certificacaoPropriedade.id) == null
        assert response.redirectedUrl == '/certificacaoPropriedade/list'
    }
}
