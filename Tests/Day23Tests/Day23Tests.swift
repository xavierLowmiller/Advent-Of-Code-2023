import Testing

#if DEBUG
  @testable import Day23
#else
  import Day23
#endif

struct Day23Tests {
  let testInput = """
    #.#####################
    #.......#########...###
    #######.#########.#.###
    ###.....#.>.>.###.#.###
    ###v#####.#v#.###.#.###
    ###.>...#.#.#.....#...#
    ###v###.#.#.#########.#
    ###...#.#.#.......#...#
    #####.#.#.#######.#.###
    #.....#.#.#.......#...#
    #.#####.#.#.#########v#
    #.#...#...#...###...>.#
    #.#.#v#######v###.###v#
    #...#.>.#...>.>.#.###.#
    #####v#.#.###v#.#.###.#
    #.....#...#...#.#.#...#
    #.#########.###.#.#.###
    #...###...#...#...#.###
    ###.###.#.###v#####v###
    #...#...#.#.>.>.#.>.###
    #.###.###.#.###.#.#v###
    #.....###...###...#...#
    #####################.#
    """

  @Test func part1Example() {
    #expect(longestPathFromStartToFinish(in: testInput, canGoUpSlopes: false) == 94)
  }

  @Test func part1() {
    let steps = longestPathFromStartToFinish(in: input, canGoUpSlopes: false)
    #expect(steps == 2094)
    print("Part 1:", steps)
  }

  @Test func part2Example() {
    #expect(longestPathFromStartToFinish(in: testInput, canGoUpSlopes: true) == 154)
  }

  @Test func part2() {
    let answer = longestPathFromStartToFinish(in: input, canGoUpSlopes: true)
    #expect(answer == 6442)
    print("Part 2:", answer)
  }
}
