package rastrograo.rastreamento



import org.junit.*
import grails.test.mixin.*

@TestFor(ConsolidacaoController)
@Mock(Consolidacao)
class ConsolidacaoControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/consolidacao/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.consolidacaoInstanceList.size() == 0
        assert model.consolidacaoInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.consolidacaoInstance != null
    }

    void testSave() {
        controller.save()

        assert model.consolidacaoInstance != null
        assert view == '/consolidacao/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/consolidacao/show/1'
        assert controller.flash.message != null
        assert Consolidacao.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/consolidacao/list'

        populateValidParams(params)
        def consolidacao = new Consolidacao(params)

        assert consolidacao.save() != null

        params.id = consolidacao.id

        def model = controller.show()

        assert model.consolidacaoInstance == consolidacao
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/consolidacao/list'

        populateValidParams(params)
        def consolidacao = new Consolidacao(params)

        assert consolidacao.save() != null

        params.id = consolidacao.id

        def model = controller.edit()

        assert model.consolidacaoInstance == consolidacao
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/consolidacao/list'

        response.reset()

        populateValidParams(params)
        def consolidacao = new Consolidacao(params)

        assert consolidacao.save() != null

        // test invalid parameters in update
        params.id = consolidacao.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/consolidacao/edit"
        assert model.consolidacaoInstance != null

        consolidacao.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/consolidacao/show/$consolidacao.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        consolidacao.clearErrors()

        populateValidParams(params)
        params.id = consolidacao.id
        params.version = -1
        controller.update()

        assert view == "/consolidacao/edit"
        assert model.consolidacaoInstance != null
        assert model.consolidacaoInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/consolidacao/list'

        response.reset()

        populateValidParams(params)
        def consolidacao = new Consolidacao(params)

        assert consolidacao.save() != null
        assert Consolidacao.count() == 1

        params.id = consolidacao.id

        controller.delete()

        assert Consolidacao.count() == 0
        assert Consolidacao.get(consolidacao.id) == null
        assert response.redirectedUrl == '/consolidacao/list'
    }
}
