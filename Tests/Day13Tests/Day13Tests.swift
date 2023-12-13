import XCTest
@testable import Day13

final class Day13Tests: XCTestCase {
    func testPart1Example() {
        let input = """
        #.##..##.
        ..#.##.#.
        ##......#
        ##......#
        ..#.##.#.
        ..##..##.
        #.#.##.#.

        #...##..#
        #....#..#
        ..##..###
        #####.##.
        #####.##.
        ..##..###
        #....#..#
        """

        let blocks = input.split(separator: "\n\n")

        XCTAssertEqual(blocks[0].symmetryIndex(of: blocks[0].rows, maxDiff: 0), nil)
        XCTAssertEqual(blocks[0].symmetryIndex(of: blocks[0].columns, maxDiff: 0), 5)
        XCTAssertEqual(blocks[1].symmetryIndex(of: blocks[1].rows, maxDiff: 0), 4)
        XCTAssertEqual(blocks[1].symmetryIndex(of: blocks[1].columns, maxDiff: 0), nil)

        let patterns = Patterns(input)
        XCTAssertEqual(patterns.reflectionSummary(maxDiff: 0), 405)
    }

    func testPart1() {
        let patterns = Patterns(input)
        print("Part 1:", patterns.reflectionSummary(maxDiff: 0))
    }

    func testPart2Example() {
        let input = """
        #.##..##.
        ..#.##.#.
        ##......#
        ##......#
        ..#.##.#.
        ..##..##.
        #.#.##.#.

        #...##..#
        #....#..#
        ..##..###
        #####.##.
        #####.##.
        ..##..###
        #....#..#
        """

        let blocks = input.split(separator: "\n\n")

        XCTAssertEqual(blocks[0].symmetryIndex(of: blocks[0].rows, maxDiff: 1), 3)
        XCTAssertEqual(blocks[0].symmetryIndex(of: blocks[0].columns, maxDiff: 1), nil)
        XCTAssertEqual(blocks[1].symmetryIndex(of: blocks[1].rows, maxDiff: 1), 1)
        XCTAssertEqual(blocks[1].symmetryIndex(of: blocks[1].columns, maxDiff: 1), nil)

        let patterns = Patterns(input)
        XCTAssertEqual(patterns.reflectionSummary(maxDiff: 1), 400)
    }

    func testPart2() {
        let patterns = Patterns(input)
        print("Part 2:", patterns.reflectionSummary(maxDiff: 1))
    }
}
