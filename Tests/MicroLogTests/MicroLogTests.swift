    import XCTest
    @testable import MicroLog

    final class MicroLogTests: XCTestCase {
        func testExample() {
            XCTAssertNoThrow(MicroLog.info("This is a test info message."))
            XCTAssertNoThrow(MicroLog.warning("This is a test warning message."))
            XCTAssertNoThrow(MicroLog.error("This is a test error message."))
        }
    }
