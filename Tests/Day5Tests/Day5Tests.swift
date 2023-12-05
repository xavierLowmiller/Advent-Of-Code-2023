import XCTest
@testable import Day5

final class Day5Tests: XCTestCase {
    func testPart1Example() {
        let input = """
        seeds: 79 14 55 13

        seed-to-soil map:
        50 98 2
        52 50 48

        soil-to-fertilizer map:
        0 15 37
        37 52 2
        39 0 15

        fertilizer-to-water map:
        49 53 8
        0 11 42
        42 0 7
        57 7 4

        water-to-light map:
        88 18 7
        18 25 70

        light-to-temperature map:
        45 77 23
        81 45 19
        68 64 13

        temperature-to-humidity map:
        0 69 1
        1 0 69

        humidity-to-location map:
        60 56 37
        56 93 4
        """

        let almanac = Almanac(input)
        XCTAssertEqual(almanac.locations, [82, 43, 86, 35])
    }

    func testPart1() {
        let almanac = Almanac(input)
        XCTAssertEqual(almanac.locations.min(), 51580674)
        print("Part 1:", almanac.locations.min() ?? 0)
    }

    func testPart2Example() {
        let input = """
        seeds: 79 14 55 13

        seed-to-soil map:
        50 98 2
        52 50 48

        soil-to-fertilizer map:
        0 15 37
        37 52 2
        39 0 15

        fertilizer-to-water map:
        49 53 8
        0 11 42
        42 0 7
        57 7 4

        water-to-light map:
        88 18 7
        18 25 70

        light-to-temperature map:
        45 77 23
        81 45 19
        68 64 13

        temperature-to-humidity map:
        0 69 1
        1 0 69

        humidity-to-location map:
        60 56 37
        56 93 4
        """

        let almanac = Almanac(input)
        XCTAssertEqual(almanac.minimumByRange, 46)
    }

    func testPart2() {
        let almanac = Almanac(input)
        XCTAssertEqual(almanac.minimumByRange, 99751240)
        print("Part 2:", almanac.minimumByRange ?? 0)
    }
}
