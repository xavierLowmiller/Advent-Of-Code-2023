import XCTest
@testable import Day15

final class Day15Tests: XCTestCase {
    func testPart1Example() {
        XCTAssertEqual("HASH".holidayHash, 52)
        let input = "rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7"
        XCTAssertEqual(input.split(separator: ",").reduce(0) { $0 + $1.holidayHash }, 1320)
    }

    func testPart1() {
        let result = input.split(separator: ",").reduce(0) { $0 + $1.holidayHash }
        print("Part 1:", result)
    }

    func testPart2Example() {
        let input = "rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7"
        XCTAssertEqual(focusingPower(of: input), 145)
    }

    func testPart2() {
        print("Part 2:", focusingPower(of: input))
    }
}
