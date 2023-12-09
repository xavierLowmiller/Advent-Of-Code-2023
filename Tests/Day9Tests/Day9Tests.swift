import XCTest
@testable import Day9

final class Day9Tests: XCTestCase {
    func testPart1Example() {
        let input = """
        0 3 6 9 12 15
        1 3 6 10 15 21
        10 13 16 21 30 45
        """

        let sequences = Sequences(input)
        XCTAssertEqual(sequences.sumOfExtrapolatedValues, 114)
    }

    func testPart1() {
        let sequences = Sequences(input)
        print("Part 1:", sequences.sumOfExtrapolatedValues)
    }

    func testPart2Example() {
        let input = """
        0 3 6 9 12 15
        1 3 6 10 15 21
        10 13 16 21 30 45
        """

        let sequences = Sequences(input)
        XCTAssertEqual(sequences.sumOfBackwardsExtrapolatedValues, 2)
    }

    func testPart2() {
        let sequences = Sequences(input)
        print("Part 2:", sequences.sumOfBackwardsExtrapolatedValues)
    }
}
