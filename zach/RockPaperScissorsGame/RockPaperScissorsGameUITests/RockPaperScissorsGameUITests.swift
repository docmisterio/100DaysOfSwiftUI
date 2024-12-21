import Foundation
import XCTest

final class RockPaperScissorsGameUITests: XCTestCase {
    var app = XCUIApplication()
    
    override func setUpWithError() throws {
        app.launch()
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
        // you can pretend something like logout or reset test data would live here.
    }
    
    @MainActor
    func testValidateTitle() throws {
        findElement(XCUITestObjectModel.Labels.rockPaperScissorsTitle, timeOutAt: WaitTimes.standard)
    }
    
    func testGame() throws {
        if XCUITestObjectModel.Labels.win.exists {
            winWinScenario()
            handleAlert()
        } else {
            loseWinScenario()
            handleAlert()
        }
        
        @MainActor
        func testLaunchPerformance() throws {
            if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
                // This measures how long it takes to launch your application.
                measure(metrics: [XCTApplicationLaunchMetric()]) {
                    XCUIApplication().launch()
                }
            }
        }
    }
}
