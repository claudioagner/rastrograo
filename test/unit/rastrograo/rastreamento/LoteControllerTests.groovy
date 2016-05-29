package rastrograo.rastreamento



import org.junit.*
import grails.test.mixin.*

@TestFor(LoteController)
@Mock(Lote)
class LoteControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/lote/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.loteInstanceList.size() == 0
        assert model.loteInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.loteInstance != null
    }

    void testSave() {
        controller.save()

        assert model.loteInstance != null
        assert view == '/lote/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/lote/show/1'
        assert controller.flash.message != null
        assert Lote.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/lote/list'

        populateValidParams(params)
        def lote = new Lote(params)

        assert lote.save() != null

        params.id = lote.id

        def model = controller.show()

        assert model.loteInstance == lote
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/lote/list'

        populateValidParams(params)
        def lote = new Lote(params)

        assert lote.save() != null

        params.id = lote.id

        def model = controller.edit()

        assert model.loteInstance == lote
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/lote/list'

        response.reset()

        populateValidParams(params)
        def lote = new Lote(params)

        assert lote.save() != null

        // test invalid parameters in update
        params.id = lote.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/lote/edit"
        assert model.loteInstance != null

        lote.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/lote/show/$lote.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        lote.clearErrors()

        populateValidParams(params)
        params.id = lote.id
        params.version = -1
        controller.update()

        assert view == "/lote/edit"
        assert model.loteInstance != null
        assert model.loteInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/lote/list'

        response.reset()

        populateValidParams(params)
        def lote = new Lote(params)

        assert lote.save() != null
        assert Lote.count() == 1

        params.id = lote.id

        controller.delete()

        assert Lote.count() == 0
        assert Lote.get(lote.id) == null
        assert response.redirectedUrl == '/lote/list'
    }
}
