import XCTest
@testable import Day24

final class Day24Tests: XCTestCase {
    func testPart1Example() {
        let input = """
        19, 13, 30 @ -2,  1, -2
        18, 19, 22 @ -1, -1, -2
        20, 25, 34 @ -2, -2, -4
        12, 31, 28 @ -1, -2, -1
        20, 19, 15 @  1, -5, -3
        """

        XCTAssertEqual(intersections(of: input, range: 7...27), 2)
    }

    func testPart1() {
        print("Part 1:", intersections(of: input, range: 200000000000000...400000000000000))
    }

    func testPart2Example() {}

    func testPart2() {
        print("Part 2:")
    }
}
