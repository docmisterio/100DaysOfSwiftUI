import XCTest
/// Best to collect like items in enums for use later, bonus points for good naming so everything is clear.

enum WaitTimes {
    static let standard: TimeInterval = 2
    static let extended: TimeInterval = 5
}

enum typedText {
    static let test = "test"
}

enum Failures {
    static let couldNotFindElement = "Element Could Not Be Found"
    static let couldNotTapOnElement = "Element Could Not Be Tapped On"
    static let couldNotConvertPercentageToString = "Could Not Convert Percentage to String"
    static let couldNotFindContinueButton = "Could Not Find Continue Button"
}

extension XCTestCase {    
    func sleep(forSeconds numberOfSeconds: TimeInterval) {
        Thread.sleep(forTimeInterval: numberOfSeconds)
    }
    
    func findElement(_ element: XCUIElement, timeOutAt numberOfSeconds: TimeInterval, andTap tap: Bool? = nil) {
        guard element.waitForExistence(timeout: 2) else {
            XCTFail(Failures.couldNotFindElement)
            return
        }
        if tap == true {
            element.tap()
        }
    }
    
    func verifyElement(_ element: XCUIElement) {
        XCTAssertTrue(element.exists)
    }
    
    func winWinScenario() {
        switch true {
        case XCUITestObjectModel.Labels.rock.exists:
            findElement(XCUITestObjectModel.Buttons.paper, timeOutAt: WaitTimes.standard, andTap: true)
            
        case XCUITestObjectModel.Labels.paper.exists:
            findElement(XCUITestObjectModel.Buttons.scissors, timeOutAt: WaitTimes.standard, andTap: true)
        case XCUITestObjectModel.Labels.scissors.exists:
            findElement(XCUITestObjectModel.Buttons.rock, timeOutAt: WaitTimes.standard, andTap: true)
        default:
            XCTFail(Failures.couldNotFindElement)
        }
    }
    
    func loseWinScenario() {
        switch true {
        case XCUITestObjectModel.Labels.rock.exists:
            findElement(XCUITestObjectModel.Buttons.scissors, timeOutAt: WaitTimes.standard, andTap: true)
        case XCUITestObjectModel.Labels.paper.exists:
            findElement(XCUITestObjectModel.Buttons.rock, timeOutAt: WaitTimes.standard, andTap: true)
        case XCUITestObjectModel.Labels.scissors.exists:
            findElement(XCUITestObjectModel.Buttons.paper, timeOutAt: WaitTimes.standard, andTap: true)
        default:
            XCTFail(Failures.couldNotFindElement)
        }
    }
    
    func handleAlert() {
        XCTAssert(XCUITestObjectModel.Alerts.Buttons.continueButton.exists, Failures.couldNotFindContinueButton)
    }
}




