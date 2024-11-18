import Foundation
import XCTest

class XCUITestObjectModel: XCTestCase {
    var yourScore: Int = 0
    
    enum Buttons {
       static let rock = XCUIApplication().buttons["🪨"]
        static let paper = XCUIApplication().buttons["📃"]
        static let scissors = XCUIApplication().buttons["✂️"]
    }
    
    enum Labels {
        static let rockPaperScissorsTitle = XCUIApplication().staticTexts["Rock, Paper, Scissors"]
        static let win = XCUIApplication().staticTexts["Win"]
        static let lose = XCUIApplication().staticTexts["Lose"]
        static let rock = XCUIApplication().staticTexts["🪨"]
        static let paper = XCUIApplication().staticTexts["📃"]
        static let scissors = XCUIApplication().staticTexts["✂️"]
    }
    
    enum Alerts {
        static let tieTitle = XCUIApplication().alerts["Tie"]
        static let WinTitle = XCUIApplication().alerts["Win"]
        static let LoseTitle = XCUIApplication().alerts["Lose"]
        
        static func yourScoreAlert(score: Int) -> XCUIElement {
                return XCUIApplication().alerts["Your Score is \(score)."]
            }
        
        enum Buttons {
            static let continueButton = XCUIApplication().buttons["Continue"]
        }
    }
}

enum RockPaperScissors: String, CaseIterable {
    case rock = "🪨"
    case paper = "📃"
    case scissors = "✂️"
}
