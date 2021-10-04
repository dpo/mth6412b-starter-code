include("mainphase1.jl")

a = Node("a", [0, 0])
b = Node("b", [0, 0])
c = Node("c", [0, 0])
d = Node("d", [0, 0])
e = Node("e", [0, 0])
f = Node("f", [0, 0])
g = Node("g", [0, 0])
h = Node("h", [0, 0])
i = Node("i", [0, 0])
Gexcours = Graph("Gtest", [a, b, c, d, e, f, g, h, i],
[Edge("a↔b", (a, b), 4),
Edge("b↔c", (b, c), 8),
Edge("c↔d", (c, d), 7),
Edge("d↔e", (d, e), 9),
Edge("e↔f", (e, f), 10),
Edge("f↔g", (f, g), 2),
Edge("a↔h", (a, h), 8),
Edge("i↔h", (i, h), 7),
Edge("b↔h", (b, h), 11),
Edge("g↔i", (g, i), 6),
Edge("f↔d", (f, d), 14),
Edge("c↔f", (c, f), 4),
Edge("g↔h", (g, h), 1),
Edge("c↔i", (c, i), 2)])