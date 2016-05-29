package rastrograo.estrutura



import org.junit.*
import grails.test.mixin.*

@TestFor(CultivarController)
@Mock(Cultivar)
class CultivarControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/cultivar/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.cultivarInstanceList.size() == 0
        assert model.cultivarInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.cultivarInstance != null
    }

    void testSave() {
        controller.save()

        assert model.cultivarInstance != null
        assert view == '/cultivar/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/cultivar/show/1'
        assert controller.flash.message != null
        assert Cultivar.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/cultivar/list'

        populateValidParams(params)
        def cultivar = new Cultivar(params)

        assert cultivar.save() != null

        params.id = cultivar.id

        def model = controller.show()

        assert model.cultivarInstance == cultivar
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/cultivar/list'

        populateValidParams(params)
        def cultivar = new Cultivar(params)

        assert cultivar.save() != null

        params.id = cultivar.id

        def model = controller.edit()

        assert model.cultivarInstance == cultivar
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/cultivar/list'

        response.reset()

        populateValidParams(params)
        def cultivar = new Cultivar(params)

        assert cultivar.save() != null

        // test invalid parameters in update
        params.id = cultivar.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/cultivar/edit"
        assert model.cultivarInstance != null

        cultivar.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/cultivar/show/$cultivar.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        cultivar.clearErrors()

        populateValidParams(params)
        params.id = cultivar.id
        params.version = -1
        controller.update()

        assert view == "/cultivar/edit"
        assert model.cultivarInstance != null
        assert model.cultivarInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/cultivar/list'

        response.reset()

        populateValidParams(params)
        def cultivar = new Cultivar(params)

        assert cultivar.save() != null
        assert Cultivar.count() == 1

        params.id = cultivar.id

        controller.delete()

        assert Cultivar.count() == 0
        assert Cultivar.get(cultivar.id) == null
        assert response.redirectedUrl == '/cultivar/list'
    }
}
