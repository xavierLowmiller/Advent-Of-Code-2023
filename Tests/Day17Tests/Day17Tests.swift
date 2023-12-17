import XCTest
import Day17

final class Day17Tests: XCTestCase {
    func testPart1Example() {
        let input = """
        2413432311323
        3215453535623
        3255245654254
        3446585845452
        4546657867536
        1438598798454
        4457876987766
        3637877979653
        4654967986887
        4564679986453
        1224686865563
        2546548887735
        4322674655533
        """

        XCTAssertEqual(pathOfMinimumHeatLoss(input, range: 0..<3), 102)
    }

    func testPart1() {
        print("Part 1:", pathOfMinimumHeatLoss(input, range: 0..<3))
    }

    func testPart2Example() {
        let input1 = """
        2413432311323
        3215453535623
        3255245654254
        3446585845452
        4546657867536
        1438598798454
        4457876987766
        3637877979653
        4654967986887
        4564679986453
        1224686865563
        2546548887735
        4322674655533
        """

        XCTAssertEqual(pathOfMinimumHeatLoss(input1, range: 4..<10), 94)

        let input2 = """
        111111111111
        999999999991
        999999999991
        999999999991
        999999999991
        """

        XCTAssertEqual(pathOfMinimumHeatLoss(input2, range: 4..<10), 71)
    }

    func testPart2() {
        print("Part 2:", pathOfMinimumHeatLoss(input, range: 4..<10))
    }
}
