struct Rating {
    let x: Int
    let m: Int
    let a: Int
    let s: Int

    init(_ input: Substring) {
        guard let m = input.firstMatch(of: #/{x=(\d+),m=(\d+),a=(\d+),s=(\d+)}/#),
              let _x = Int(m.output.1),
              let _m = Int(m.output.2),
              let _a = Int(m.output.3),
              let _s = Int(m.output.4)
        else { fatalError() }
        self.x = _x
        self.m = _m
        self.a = _a
        self.s = _s
    }

    var sum: Int {
        x + m + a + s
    }
}

struct Workflow: Identifiable {
    let id: String
    struct Rule {
        let condition: String
        let predicate: (Rating) -> Bool
        let child: Workflow.ID

        init(condition: String, predicate: @escaping (Rating) -> Bool, child: Workflow.ID) {
            self.condition = String(condition.split(separator: ":")[0])
            self.predicate = predicate
            self.child = child
        }
    }
    var rules: [Rule]

    init(_ input: Substring) {
        let m = input.firstMatch(of: #/(?<id>.+){(?<rules>.+)}/#)!
        id = String(m.output.id)
        rules = m.output.rules.split(separator: ",").map(String.init).map {
            if let m = $0.firstMatch(of: #/x<(\d+):(.+)/#) {
                let v = Int(m.output.1)!
                let child = String(m.output.2)
                return Rule(condition: $0, predicate: { rating in rating.x < v }, child: child)
            } else if let m = $0.firstMatch(of: #/m<(\d+):(.+)/#) {
                let v = Int(m.output.1)!
                let child = String(m.output.2)
                return Rule(condition: $0, predicate: { rating in rating.m < v }, child: child)
            } else if let m = $0.firstMatch(of: #/a<(\d+):(.+)/#) {
                let v = Int(m.output.1)!
                let child = String(m.output.2)
                return Rule(condition: $0, predicate: { rating in rating.a < v }, child: child)
            } else if let m = $0.firstMatch(of: #/s<(\d+):(.+)/#) {
                let v = Int(m.output.1)!
                let child = String(m.output.2)
                return Rule(condition: $0, predicate: { rating in rating.s < v }, child: child)
            } else if let m = $0.firstMatch(of: #/x>(\d+):(.+)/#) {
                let v = Int(m.output.1)!
                let child = String(m.output.2)
                return Rule(condition: $0, predicate: { rating in rating.x > v }, child: child)
            } else if let m = $0.firstMatch(of: #/m>(\d+):(.+)/#) {
                let v = Int(m.output.1)!
                let child = String(m.output.2)
                return Rule(condition: $0, predicate: { rating in rating.m > v }, child: child)
            } else if let m = $0.firstMatch(of: #/a>(\d+):(.+)/#) {
                let v = Int(m.output.1)!
                let child = String(m.output.2)
                return Rule(condition: $0, predicate: { rating in rating.a > v }, child: child)
            } else if let m = $0.firstMatch(of: #/s>(\d+):(.+)/#) {
                let v = Int(m.output.1)!
                let child = String(m.output.2)
                return Rule(condition: $0, predicate: { rating in rating.s > v }, child: child)
            } else {
                let child = String($0)
                return Rule(condition: $0, predicate: { _ in true }, child: child)
            }
        }
    }

    func nextId(for rating: Rating) -> Workflow.ID {
        for rule in rules {
            if rule.predicate(rating) {
                return rule.child
            }
        }
        fatalError()
    }
}

private func parse(_ input: String) -> ([Workflow.ID: Workflow], [Rating]) {
    (
        Dictionary(grouping: input.split(separator: "\n\n")[0].split(separator: "\n").map(Workflow.init)) { $0.id }.compactMapValues(\.first),
        input.split(separator: "\n\n")[1].split(separator: "\n").map(Rating.init)
    )
}

func sumRatingsOfAcceptedParts(_ input: String) -> Int {
    let (workflows, ratings) = parse(input)

    return ratings.filter {
        var id: Workflow.ID = "in"
        while id != "A" && id != "R" {
            id = workflows[id]!.nextId(for: $0)
        }
        return id == "A"
    }
    .reduce(0) { $0 + $1.sum }
}

private struct Ranges {
    var x = 1...4000
    var m = 1...4000
    var a = 1...4000
    var s = 1...4000

    var acceptableCombinations: Int {
        x.count * m.count * a.count * s.count
    }

    func split(by rules: [Workflow.Rule]) -> ([Workflow.ID: Self], validRanges: [Self]) {
        var validRanges: [Self] = []
        var next: [Workflow.ID: Self] = [:]
        var remaining = self

        for rule in rules {
            var split = remaining

            if let m = rule.condition.firstMatch(of: #/x<(\d+)/#) {
                let v = Int(m.output.1)!
                split.x = split.x.lowerBound...(v - 1)
                remaining.x = v...remaining.x.upperBound
            } else if let m = rule.condition.firstMatch(of: #/m<(\d+)/#) {
                let v = Int(m.output.1)!
                split.m = split.m.lowerBound...(v - 1)
                remaining.m = v...remaining.m.upperBound
            } else if let m = rule.condition.firstMatch(of: #/a<(\d+)/#) {
                let v = Int(m.output.1)!
                split.a = split.a.lowerBound...(v - 1)
                remaining.a = v...remaining.a.upperBound
            } else if let m = rule.condition.firstMatch(of: #/s<(\d+)/#) {
                let v = Int(m.output.1)!
                split.s = split.s.lowerBound...(v - 1)
                remaining.s = v...remaining.s.upperBound
            } else if let m = rule.condition.firstMatch(of: #/x>(\d+)/#) {
                let v = Int(m.output.1)!
                split.x = (v + 1)...split.x.upperBound
                remaining.x = remaining.x.lowerBound...v
            } else if let m = rule.condition.firstMatch(of: #/m>(\d+)/#) {
                let v = Int(m.output.1)!
                split.m = (v + 1)...split.m.upperBound
                remaining.m = remaining.m.lowerBound...v
            } else if let m = rule.condition.firstMatch(of: #/a>(\d+)/#) {
                let v = Int(m.output.1)!
                split.a = (v + 1)...split.a.upperBound
                remaining.a = remaining.a.lowerBound...v
            } else if let m = rule.condition.firstMatch(of: #/s>(\d+)/#) {
                let v = Int(m.output.1)!
                split.s = (v + 1)...split.s.upperBound
                remaining.s = remaining.s.lowerBound...v
            } else {
                // Do nothing
                assert(!rule.condition.contains("<"))
                assert(!rule.condition.contains(">")) 
            }

            switch rule.child {
            case "A":
                validRanges.append(split)
            case "R":
                // Do nothing
                break
            default:
                next[rule.child] = split
            }
        }

        return (next, validRanges)
    }
}

func maximallyAcceptedCombinations(_ input: String) -> Int {
    let (workflows, _) = parse(input)

    var currentRanges = ["in": Ranges()]
    var validRanges: [Ranges] = []

    while !currentRanges.isEmpty {
        for (node, ranges) in currentRanges {
            currentRanges[node] = nil

            let rules = workflows[node]!.rules
            let (next, valid) = ranges.split(by: rules)
            currentRanges.merge(next) { $1 }
            validRanges.append(contentsOf: valid)
        }
    }

    return validRanges.reduce(0) { $0 + $1.acceptableCombinations}
}
