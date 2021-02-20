import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(sportmonks_kitTests.allTests),
    ]
}
#endif
