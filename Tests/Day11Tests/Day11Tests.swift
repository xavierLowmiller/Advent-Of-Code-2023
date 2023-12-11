import XCTest
@testable import Day11

final class Day11Tests: XCTestCase {
    func testPart1Example() {
        let input = """
        ...#......
        .......#..
        #.........
        ..........
        ......#...
        .#........
        .........#
        ..........
        .......#..
        #...#.....
        """

        let map = GalaxyMap(input)
        XCTAssertEqual(map.sumOfDistancesBetweenGalaxies, 374)
    }

    func testPart1() {
        let map = GalaxyMap(input)
        print("Part 1:", map.sumOfDistancesBetweenGalaxies)
    }

    func testPart2Example() {
        let input = """
        ...#......
        .......#..
        #.........
        ..........
        ......#...
        .#........
        .........#
        ..........
        .......#..
        #...#.....
        """

        let map1 = GalaxyMap(input, increment: 10)
        XCTAssertEqual(map1.sumOfDistancesBetweenGalaxies, 1030)

        let map2 = GalaxyMap(input, increment: 100)
        XCTAssertEqual(map2.sumOfDistancesBetweenGalaxies, 8410)
    }

    func testPart2() {
        let map = GalaxyMap(input, increment: 1000000)
        print("Part 2:", map.sumOfDistancesBetweenGalaxies)
    }
}
