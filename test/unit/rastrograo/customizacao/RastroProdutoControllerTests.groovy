package rastrograo.customizacao



import org.junit.*
import grails.test.mixin.*

@TestFor(RastroProdutoController)
@Mock(RastroProduto)
class RastroProdutoControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/rastroProduto/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.rastroProdutoInstanceList.size() == 0
        assert model.rastroProdutoInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.rastroProdutoInstance != null
    }

    void testSave() {
        controller.save()

        assert model.rastroProdutoInstance != null
        assert view == '/rastroProduto/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/rastroProduto/show/1'
        assert controller.flash.message != null
        assert RastroProduto.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/rastroProduto/list'

        populateValidParams(params)
        def rastroProduto = new RastroProduto(params)

        assert rastroProduto.save() != null

        params.id = rastroProduto.id

        def model = controller.show()

        assert model.rastroProdutoInstance == rastroProduto
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/rastroProduto/list'

        populateValidParams(params)
        def rastroProduto = new RastroProduto(params)

        assert rastroProduto.save() != null

        params.id = rastroProduto.id

        def model = controller.edit()

        assert model.rastroProdutoInstance == rastroProduto
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/rastroProduto/list'

        response.reset()

        populateValidParams(params)
        def rastroProduto = new RastroProduto(params)

        assert rastroProduto.save() != null

        // test invalid parameters in update
        params.id = rastroProduto.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/rastroProduto/edit"
        assert model.rastroProdutoInstance != null

        rastroProduto.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/rastroProduto/show/$rastroProduto.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        rastroProduto.clearErrors()

        populateValidParams(params)
        params.id = rastroProduto.id
        params.version = -1
        controller.update()

        assert view == "/rastroProduto/edit"
        assert model.rastroProdutoInstance != null
        assert model.rastroProdutoInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/rastroProduto/list'

        response.reset()

        populateValidParams(params)
        def rastroProduto = new RastroProduto(params)

        assert rastroProduto.save() != null
        assert RastroProduto.count() == 1

        params.id = rastroProduto.id

        controller.delete()

        assert RastroProduto.count() == 0
        assert RastroProduto.get(rastroProduto.id) == null
        assert response.redirectedUrl == '/rastroProduto/list'
    }
}
