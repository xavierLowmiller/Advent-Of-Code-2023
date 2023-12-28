struct Vertex: Identifiable, Hashable {
    var id: Substring
}

struct Edge: Hashable {
    var v1: Vertex
    var v2: Vertex
}

struct Graph {
    var vertices: Set<Vertex> = []
    var edges: Set<Edge> = []

    init(_ input: String) {
        for line in input.split(separator: "\n") {
            let parts = line.split(separator: ": ")
            let source = Vertex(id: parts[0])
            vertices.insert(source)
            for conn in parts[1].split(separator: " ") {
                let conn = Vertex(id: conn)
                vertices.insert(conn)
                if source.id < conn.id {
                    edges.insert(Edge(v1: source, v2: conn))
                } else {
                    edges.insert(Edge(v1: conn, v2: source))
                }
            }
        }
        assert(!edges.contains(where: { $0.v1 == $0.v2 }))
        assert(!edges.contains(where: { edge in
            !vertices.contains(where: { $0 == edge.v1 }) &&
            !vertices.contains(where: { $0 == edge.v2 })
        }))
    }

    var minCut: (count1: Int, count2: Int, cutCount: Int) {
        var mergeCount: [Vertex: Int] = Dictionary(grouping: vertices) { $0.self }.mapValues { _ in 1 }

        var vertices = vertices
        var edges = Array(edges)

        while vertices.count > 2 {
            let e = edges.randomElement()!

            vertices.remove(e.v2)
            mergeCount[e.v1, default: 1] += mergeCount[e.v2, default: 1]
            mergeCount.removeValue(forKey: e.v2)

            edges = edges.compactMap {
                var edge = $0
                if edge.v1 == e.v2 {
                    edge.v1 = e.v1
                }
                if edge.v2 == e.v2 {
                    edge.v2 = e.v1
                }

                return edge.v1 != edge.v2 ? edge : nil
            }
        }

        if edges.count == 3 {
            print(edges.map { (String($0.v1.id), String($0.v2.id))})
        }

        return (
            mergeCount.values.first!,
            mergeCount.values.dropFirst().first!,
            edges.count
        )
    }
}

public func scoreAfterDisconnectingGroups(_ input: String) -> Int {
    let graph = Graph(input)

    var a = 0
    var b = 0
    var cutCount = 0
    while cutCount != 3 {
        (a, b, cutCount) = graph.minCut
    }

    return a * b
}
