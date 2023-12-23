import Testing
@testable import Day12

@MainActor
struct Day12Tests {
  @Test func part1Example() {
    let input = """
        ???.### 1,1,3
        .??..??...?##. 1,1,3
        ?#?#?#?#?#?#?#? 1,3,1,6
        ????.#...#... 4,1,1
        ????.######..#####. 1,6,5
        ?###???????? 3,2,1
        """

    #expect("???.### 1,1,3".possibleArrangements() == 1)
    #expect(".??..??...?##. 1,1,3".possibleArrangements() == 4)
    #expect("?#?#?#?#?#?#?#? 1,3,1,6".possibleArrangements() == 1)
    #expect("????.#...#... 4,1,1".possibleArrangements() == 1)
    #expect("????.######..#####. 1,6,5".possibleArrangements() == 4)
    #expect("?###???????? 3,2,1".possibleArrangements() == 10)

    let arrangements = input.possibleArrangements()
    #expect(arrangements == 21)
  }

  @Test func part1() {
    let arrangements = input.possibleArrangements()
    print("Part 1:", arrangements)
  }

  @Test func part2Example() {
    let input = """
    ???.### 1,1,3
    .??..??...?##. 1,1,3
    ?#?#?#?#?#?#?#? 1,3,1,6
    ????.#...#... 4,1,1
    ????.######..#####. 1,6,5
    ?###???????? 3,2,1
    """

    #expect("???.### 1,1,3".possibleArrangements(repetitions: 5) == 1)
    #expect(".??..??...?##. 1,1,3".possibleArrangements(repetitions: 5) == 16384)
    #expect("?#?#?#?#?#?#?#? 1,3,1,6".possibleArrangements(repetitions: 5) == 1)
    #expect("????.#...#... 4,1,1".possibleArrangements(repetitions: 5) == 16)
    #expect("????.######..#####. 1,6,5".possibleArrangements(repetitions: 5) == 2500)
    #expect("?###???????? 3,2,1".possibleArrangements(repetitions: 5) == 506250)

    let arrangements = input.possibleArrangements(repetitions: 5)
    #expect(arrangements == 525152)
  }

  @Test func part2() {
    let arrangements = input.possibleArrangements(repetitions: 5)
    print("Part 2:", arrangements)
  }
}
