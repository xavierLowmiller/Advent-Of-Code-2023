private struct Key: Hashable {
  let remainingSequence: String
  let remainingLengths: [Int]
}

@MainActor
private var cache: [Key: Int] = [:]

@MainActor
func combinations(of input: String, lengths: [Int]) -> Int {
  if let hit = cache[Key(remainingSequence: input, remainingLengths: lengths)] {
    return hit
  }

  let result: Int
  defer { cache[Key(remainingSequence: input, remainingLengths: lengths)] = result }

  if lengths.isEmpty {
    result = input.contains("#") ? 0 : 1
    return result
  }

  guard input.count >= lengths.reduce(0, +) + lengths.count - 1 else { result = 0; return result }
  let length = lengths[0]


  switch input.first {
  case ".":
    result = combinations(of: String(input.drop(while: { $0 == "." })), lengths: lengths)

  case "#":
    guard input.prefix(length).allSatisfy({ $0 == "#" || $0 == "?" })
    else {
      result = 0
      break
    }

    if input.dropFirst(length).isEmpty {
      result = 1
      break
    }

    guard let separator = input.dropFirst(length).first, separator == "." || separator == "?"
    else {
      result = 0
      break
    }
    result = combinations(of: String(input.dropFirst(length + 1)), lengths: Array(lengths.dropFirst()))

  case "?":
    let option1 = ("#" + input.dropFirst())
    let option2 = ("." + input.dropFirst())
    result = combinations(of: option1, lengths: lengths) + combinations(of: option2, lengths: lengths)

  default:
    fatalError()
  }
  return result
}

extension StringProtocol {
  @MainActor
  func possibleArrangements(repetitions: Int = 1) -> Int {
    if contains("\n") {
      return split(separator: "\n").reduce(0) {
        $0 + $1.possibleArrangements(repetitions: repetitions)
      }
    } else {
      let input = Array(repeating: String(split(separator: " ")[0]), count: repetitions).joined(separator: "?")
      let lengths = Array(repeating: split(separator: " ")[1].split(separator: ",").compactMap { Int($0) }, count: repetitions).flatMap { $0 }
      return combinations(of: input, lengths: lengths)
    }
  }
}
