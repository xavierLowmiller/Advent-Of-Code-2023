import XCTest
import Day14

final class Day14Tests: XCTestCase {
    func testPart1Example() {
        let input = """
        O....#....
        O.OO#....#
        .....##...
        OO.#O....O
        .O.....O#.
        O.#..O.#.#
        ..O..#O..O
        .......O..
        #....###..
        #OO..#....
        """

        let panel = Panel(input)
        XCTAssertEqual(panel.loadAfterTiltingNorth, 136)
    }

    func testPart1() {
        let panel = Panel(input)
        print("Part 1:", panel.loadAfterTiltingNorth)
    }

    func testPart2Example() {
        let input = """
        O....#....
        O.OO#....#
        .....##...
        OO.#O....O
        .O.....O#.
        O.#..O.#.#
        ..O..#O..O
        .......O..
        #....###..
        #OO..#....
        """

        let panel = Panel(input)
        XCTAssertEqual(panel.loadAfterSpinning, 64)
    }

    func testPart2() {
        let panel = Panel(input)
        print("Part 2:", panel.loadAfterSpinning)
    }
}
