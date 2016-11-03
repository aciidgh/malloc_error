import XCTest
import Dispatch
@testable import malloc

class mallocTests: XCTestCase {
    func testExample() {

        let finishedCondition = NSCondition()
        var finished = false
        DispatchQueue.global().async {
            finishedCondition.lock()
                finished = true
                finishedCondition.signal()
            finishedCondition.unlock()
        }

        finishedCondition.lock()
            while !finished {
                finishedCondition.wait()
            }
        finishedCondition.unlock()

        XCTAssertTrue(finished)
    }


    static var allTests : [(String, (mallocTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
