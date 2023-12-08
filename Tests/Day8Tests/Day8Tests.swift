import XCTest
@testable import Day8

final class Day8Tests: XCTestCase {
    func testPart1Example() {
        let input1 = """
        RL

        AAA = (BBB, CCC)
        BBB = (DDD, EEE)
        CCC = (ZZZ, GGG)
        DDD = (DDD, DDD)
        EEE = (EEE, EEE)
        GGG = (GGG, GGG)
        ZZZ = (ZZZ, ZZZ)
        """

        let network1 = Network(input1)
        XCTAssertEqual(network1.stepsToGoal, 2)

        let input2 = """
        LLR

        AAA = (BBB, BBB)
        BBB = (AAA, ZZZ)
        ZZZ = (ZZZ, ZZZ)
        """

        let network2 = Network(input2)
        XCTAssertEqual(network2.stepsToGoal, 6)
    }

    func testPart1() {
        let network = Network(input)
        print("Part 1:", network.stepsToGoal)
    }

    func testPart2Example() {
        let input = """
        LR

        11A = (11B, XXX)
        11B = (XXX, 11Z)
        11Z = (11B, XXX)
        22A = (22B, XXX)
        22B = (22C, 22C)
        22C = (22Z, 22Z)
        22Z = (22B, 22B)
        XXX = (XXX, XXX)
        """
        
        let network = Network(input)
        XCTAssertEqual(network.stepsToGoalAsGhost, 6)
    }

    func testPart2() {
        let network = Network(input)
        print("Part 2:", network.stepsToGoalAsGhost)
    }
}
