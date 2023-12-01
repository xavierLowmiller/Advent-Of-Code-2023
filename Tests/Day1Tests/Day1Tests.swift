import XCTest
@testable import Day1

final class Day1Tests: XCTestCase {
    func testPart1Example() {
        let input = """
        1abc2
        pqr3stu8vwx
        a1b2c3d4e5f
        treb7uchet
        """

        let trebuchet = Trebuchet(input)
        XCTAssertEqual(trebuchet.calibration, 142)
    }

    func testPart1() {
        let trebuchet = Trebuchet(input)
        print("Part 1:", trebuchet.calibration)
    }

    func testPart2Example() {
        let input = """
            two1nine
            eightwothree
            abcone2threexyz
            xtwone3four
            4nineeightseven2
            zoneight234
            7pqrstsixteen
            """

        let trebuchet = Trebuchet(input)
        XCTAssertEqual(trebuchet.realCalibration, 281)
    }

    func testPart2() {
        let trebuchet = Trebuchet(input)
        print("Part 2:", trebuchet.realCalibration)
    }
}
