package rastrograo.tabela



import org.junit.*
import grails.test.mixin.*

@TestFor(TipoProdutoController)
@Mock(TipoProduto)
class TipoProdutoControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/tipoProduto/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.tipoProdutoInstanceList.size() == 0
        assert model.tipoProdutoInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.tipoProdutoInstance != null
    }

    void testSave() {
        controller.save()

        assert model.tipoProdutoInstance != null
        assert view == '/tipoProduto/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/tipoProduto/show/1'
        assert controller.flash.message != null
        assert TipoProduto.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/tipoProduto/list'

        populateValidParams(params)
        def tipoProduto = new TipoProduto(params)

        assert tipoProduto.save() != null

        params.id = tipoProduto.id

        def model = controller.show()

        assert model.tipoProdutoInstance == tipoProduto
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/tipoProduto/list'

        populateValidParams(params)
        def tipoProduto = new TipoProduto(params)

        assert tipoProduto.save() != null

        params.id = tipoProduto.id

        def model = controller.edit()

        assert model.tipoProdutoInstance == tipoProduto
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/tipoProduto/list'

        response.reset()

        populateValidParams(params)
        def tipoProduto = new TipoProduto(params)

        assert tipoProduto.save() != null

        // test invalid parameters in update
        params.id = tipoProduto.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/tipoProduto/edit"
        assert model.tipoProdutoInstance != null

        tipoProduto.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/tipoProduto/show/$tipoProduto.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        tipoProduto.clearErrors()

        populateValidParams(params)
        params.id = tipoProduto.id
        params.version = -1
        controller.update()

        assert view == "/tipoProduto/edit"
        assert model.tipoProdutoInstance != null
        assert model.tipoProdutoInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/tipoProduto/list'

        response.reset()

        populateValidParams(params)
        def tipoProduto = new TipoProduto(params)

        assert tipoProduto.save() != null
        assert TipoProduto.count() == 1

        params.id = tipoProduto.id

        controller.delete()

        assert TipoProduto.count() == 0
        assert TipoProduto.get(tipoProduto.id) == null
        assert response.redirectedUrl == '/tipoProduto/list'
    }
}
