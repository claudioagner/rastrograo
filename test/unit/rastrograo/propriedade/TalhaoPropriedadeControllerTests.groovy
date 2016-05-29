package rastrograo.propriedade



import org.junit.*
import grails.test.mixin.*

@TestFor(TalhaoPropriedadeController)
@Mock(TalhaoPropriedade)
class TalhaoPropriedadeControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/talhaoPropriedade/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.talhaoPropriedadeInstanceList.size() == 0
        assert model.talhaoPropriedadeInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.talhaoPropriedadeInstance != null
    }

    void testSave() {
        controller.save()

        assert model.talhaoPropriedadeInstance != null
        assert view == '/talhaoPropriedade/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/talhaoPropriedade/show/1'
        assert controller.flash.message != null
        assert TalhaoPropriedade.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/talhaoPropriedade/list'

        populateValidParams(params)
        def talhaoPropriedade = new TalhaoPropriedade(params)

        assert talhaoPropriedade.save() != null

        params.id = talhaoPropriedade.id

        def model = controller.show()

        assert model.talhaoPropriedadeInstance == talhaoPropriedade
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/talhaoPropriedade/list'

        populateValidParams(params)
        def talhaoPropriedade = new TalhaoPropriedade(params)

        assert talhaoPropriedade.save() != null

        params.id = talhaoPropriedade.id

        def model = controller.edit()

        assert model.talhaoPropriedadeInstance == talhaoPropriedade
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/talhaoPropriedade/list'

        response.reset()

        populateValidParams(params)
        def talhaoPropriedade = new TalhaoPropriedade(params)

        assert talhaoPropriedade.save() != null

        // test invalid parameters in update
        params.id = talhaoPropriedade.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/talhaoPropriedade/edit"
        assert model.talhaoPropriedadeInstance != null

        talhaoPropriedade.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/talhaoPropriedade/show/$talhaoPropriedade.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        talhaoPropriedade.clearErrors()

        populateValidParams(params)
        params.id = talhaoPropriedade.id
        params.version = -1
        controller.update()

        assert view == "/talhaoPropriedade/edit"
        assert model.talhaoPropriedadeInstance != null
        assert model.talhaoPropriedadeInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/talhaoPropriedade/list'

        response.reset()

        populateValidParams(params)
        def talhaoPropriedade = new TalhaoPropriedade(params)

        assert talhaoPropriedade.save() != null
        assert TalhaoPropriedade.count() == 1

        params.id = talhaoPropriedade.id

        controller.delete()

        assert TalhaoPropriedade.count() == 0
        assert TalhaoPropriedade.get(talhaoPropriedade.id) == null
        assert response.redirectedUrl == '/talhaoPropriedade/list'
    }
}
