
import XCTest

@testable import Project

class SnapshotTests: XCTestCase {

    override func setUp() {
        super.setUp()

        continueAfterFailure = false

        let app = XCUIApplication()
        app.launchEnvironment = [ "UITest": "1" ]
        setLanguage(app)
        app.launch()

    }

    override func tearDown() {

        super.tearDown()
    }

    func testSnapshot() {

        let app = XCUIApplication()

        sleep(5)
        //        snapshot("0-Screenshot")

        //        app.collectionViews.elementBoundByIndex(0).cells.elementBoundByIndex(2).tap()
        sleep(1)
        //        snapshot("1-Screenshot")

        //        app.navigationBars.elementBoundByIndex(0).childrenMatchingType(.Button).elementBoundByIndex(0).tap()
        //        app.collectionViews.elementBoundByIndex(0).cells.elementBoundByIndex(7).tap()
        sleep(10)
        //        snapshot("2-Screenshot")

    }

}
