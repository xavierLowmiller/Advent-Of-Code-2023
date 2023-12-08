import AOCAlgorithms

struct Network {
    struct Node: Identifiable {
        let id: String
        let left: Node.ID
        let right: Node.ID

        init(_ input: Substring) {
            let pattern = #/(.{3}) = \((.{3}), (.{3})\)/#
            guard let m = input.firstMatch(of: pattern) else { fatalError() }
            id = String(m.output.1)
            left = String(m.output.2)
            right = String(m.output.3)
        }
    }

    enum Instruction {
        case left, right

        init?(c: Character) {
            switch c {
            case "L":
                self = .left
            case "R":
                self = .right
            default:
                return nil
            }
        }
    }

    var instructions: [Instruction]
    var nodes: [Node.ID: Node]

    init(_ input: String) {
        let sections = input.split(separator: "\n\n")
        instructions = sections[0].compactMap(Instruction.init)
        let nodes = sections[1].split(separator: "\n").map(Node.init)
        self.nodes = nodes.reduce(into: [:]) {
            $0[$1.id] = $1
        }
    }
    
    var stepsToGoal: Int {
        return stepsToGoal(of: "AAA", predicate: { $0 == "ZZZ" })
    }

    var stepsToGoalAsGhost: Int {
        let currentNodes: [Node.ID] = nodes.keys.filter { $0.hasSuffix("A") }

        let individualSteps = currentNodes.map {
            return stepsToGoal(of: $0, predicate: { $0.hasSuffix("Z") })
        }

        return individualSteps.reduce(1) {
            lcm($0, $1)
        }
    }

    private func stepsToGoal(of node: Node.ID, predicate: (Node.ID) -> Bool) -> Int {
        var steps = 0
        var currentNode = node
        while !predicate(currentNode) {
            defer { steps += 1 }
            let instruction = instructions[steps % instructions.count]
            let nextNode = nodes[currentNode]!
            switch instruction {
            case .left:
                currentNode = nextNode.left
            case .right:
                currentNode = nextNode.right
            }
        }
        return steps
    }
}
