import XCTest
@testable import Day10

final class Day10Tests: XCTestCase {
    func testPart1Example() {
        let input1 = """
        -L|F7
        7S-7|
        L|7||
        -L-J|
        L|-JF
        """

        let maze1 = PipeMaze(input1)
        XCTAssertEqual(maze1.mostStepsAwayFromS, 4)

        let input2 = """
        7-F7-
        .FJ|7
        SJLL7
        |F--J
        LJ.LJ
        """

        let maze2 = PipeMaze(input2)
        XCTAssertEqual(maze2.mostStepsAwayFromS, 8)
    }

    func testPart1() {
        let maze = PipeMaze(input)
        print("Part 1:", maze.mostStepsAwayFromS)
    }

    func testPart2Example() {
        let input1a = """
        ...........
        .S-------7.
        .|F-----7|.
        .||.....||.
        .||.....||.
        .|L-7.F-J|.
        .|..|.|..|.
        .L--J.L--J.
        ...........
        """

        let input1b = """
        ..........
        .S------7.
        .|F----7|.
        .||....||.
        .||....||.
        .|L-7F-J|.
        .|..||..|.
        .L--JL--J.
        ..........
        """

        let maze1a = PipeMaze(input1a)
        let maze1b = PipeMaze(input1b)
        XCTAssertEqual(maze1a.enclosedPoints, 4)
        XCTAssertEqual(maze1b.enclosedPoints, 4)

        let input2 = """
        .F----7F7F7F7F-7....
        .|F--7||||||||FJ....
        .||.FJ||||||||L7....
        FJL7L7LJLJ||LJ.L-7..
        L--J.L7...LJS7F-7L7.
        ....F-J..F7FJ|L7L7L7
        ....L7.F7||L7|.L7L7|
        .....|FJLJ|FJ|F7|.LJ
        ....FJL-7.||.||||...
        ....L---J.LJ.LJLJ...
        """

        let maze2 = PipeMaze(input2)
        XCTAssertEqual(maze2.enclosedPoints, 8)

        let input3 = """
        FF7FSF7F7F7F7F7F---7
        L|LJ||||||||||||F--J
        FL-7LJLJ||||||LJL-77
        F--JF--7||LJLJ7F7FJ-
        L---JF-JLJ.||-FJLJJ7
        |F|F-JF---7F7-L7L|7|
        |FFJF7L7F-JF7|JL---7
        7-L-JL7||F7|L7F-7F7|
        L.L7LFJ|||||FJL7||LJ
        L7JLJL-JLJLJL--JLJ.L
        """

        let maze3 = PipeMaze(input3)
        XCTAssertEqual(maze3.enclosedPoints, 10)
    }

    func testPart2() {
        let maze = PipeMaze(input)
        print("Part 2:", maze.enclosedPoints)
    }
}
