import XCTest
@testable import Day3

final class Day3Tests: XCTestCase {
    func testPart1Example() {
        let input = """
        467..114..
        ...*......
        ..35..633.
        ......#...
        617*......
        .....+.58.
        ..592.....
        ......755.
        ...$.*....
        .664.598..
        """

        let schematic = Schematic(input)
        XCTAssertEqual(schematic.sumOfEngineParts, 4361)
    }

    func testPart1() {
        let schematic = Schematic(input)
        print("Part 1:", schematic.sumOfEngineParts)
    }

    func testPart2Example() {
        let input = """
        467..114..
        ...*......
        ..35..633.
        ......#...
        617*......
        .....+.58.
        ..592.....
        ......755.
        ...$.*....
        .664.598..
        """

        let schematic = Schematic(input)
        XCTAssertEqual(schematic.sumOfGearRatios, 467835)
    }

    func testPart2() {
        let schematic = Schematic(input)
        print("Part 2:", schematic.sumOfGearRatios)
    }
}
