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
}

enum SliderPositions {
    static let one: CGFloat = 1
    static let zero: CGFloat = 0
}

enum ProgressBarPercentages {
    static let OneHundredPercent: String = "100%"
    static let zeroPercent: String = "0%"

}

extension XCTestCase {    
    /// we never wanna use this but if we have to use this it's here
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
}




