from __future__ import division
import math
import heapq


def nCk(n, k):
    return math.factorial(n) / (math.factorial(k) * math.factorial(n - k))


def substrings(array):
    return [array[i:j] for i in range(len(array)) for j in range(i, len(array))]


def dijkstra(graph, source):
    for vertex in graph:
        vertex.d = INFINITY
    source.d = 0
    heapq.heapify(graph)
    while not graph.empty():
        v = heapq.heappop(graph)
        for edge in v:
            relax(edge)


def relax(edge):
    if edge.a.d + edge.d < edge.b.d:
        edge.b.d = edge.a.d + edge.d
        edge.b.parent = edge.a


def bellman(graph):
    for vertex in graph.vertices:
        for edge in graph.edges:
            relax(edge)
    for edge in graph.edges:
        if edge.a.weight + edge.weight < edge.b.weight:
            raise Exception(
                "Negative cycle detected from vertices {A} to {B}".format(
                    A=edge.a,
                    B=edge.b
                    ))


WHITE = 0
GREY = 1
BLACK = 2


def dfs(graph):
    for vertex in graph.vertices:
        vertex.weight = WHITE
    for vertex in graph.vertices:
        if vertex.color is WHITE:
            traverse(vertex)


def traverse(vertex):
    vertex.color = GREY
    for neighbor in vertex.vertices:
        if neighbor.color is WHITE:
            traverse(neighbor)
    vertex.color = BLACK


# def bfs(graph, source):
#     pass


def kadane(array):
    max_ending_here = current_max = 0
    for value in array:
        max_ending_here = max(0, max_ending_here + value)
        current_max = max(max_ending_here, current_max)
    return current_max


def recursive_max_subarray(array):
        if len(array) is 0:
            return 0
        if len(array) is 1:
            return array[0]
        mid = len(array) // 2
        max_left = recursive_max_subarray(array[:mid:])
        max_right = recursive_max_subarray(array[mid::])
        max_crossover = crossover(array[:mid:], array[mid::])
        return max(max_left, max_right, max_crossover)


def crossover(left, right):
    max_left = max_right = None
    for value in left[-1::-1]:
        if max_left is None:
            max_left = value
            continue
        max_left = max(max_left, max_left + value)
    for value in right:
        if max_right is None:
            max_right = value
            continue
        max_right = max(max_right, max_right + value)
    return max_left + max_right


# print(kadane([-2, -5, 6, -2, -3, 1, 5, -6]))
# print(recursive_max_subarray([-2, -5, 6, -2, -3, 1, 5, -6]))

def lcs(A, B):
    if not A or not B:
        return 0
    if A[-1] == B[-1]:
        return lcs(A[:-1], B[:-1]) + 1
    else:
        return max(lcs(A, B[:-1]), lcs(A[:-1], B))

# print(lcs("GGTAB", "GXTXAYB"))


class LCS(object):

    def __init__(self, a, b):
        self.a = a
        self.b = b
        self.table = [[[0, [None, None]] for _ in range(len(b) + 1)] for _ in range(len(a) + 1)]

    def solve(self):
        for i in range(1, len(self.table)):
            # print(len(self.table[i]) - 1)
            for j in range(1, len(self.table[i])):
                # print(j)
                self.b[j - 1]
                if self.a[i - 1] == self.b[j - 1]:
                    parent = [i - 1, j - 1]
                    parent_value = self.table[i - 1][j - 1][0]
                    self.table[i][j] = [parent_value + 1, parent]
                else:
                    upper_parent, upper_value = [i - 1, j], self.table[i - 1][j][0]
                    left_parent = [i, j - 1]
                    left_value = self.table[i][j - 1][0]
                    if upper_value > left_value:
                        self.table[i][j] = [upper_value, upper_parent]
                    else:
                        self.table[i][j] = [left_value, left_parent]
        return self.backtrack()

    def backtrack(self):
        string = ''
        current = [len(self.table) - 1, len(self.table[-1]) - 1]
        while current[0] > 0 and current[1] > 0:
            this_cell = self.table[current[0]][current[1]]
            this_value = this_cell[0]
            parent_cell = this_cell[1]
            parent_value = self.table[parent_cell[0]][parent_cell[1]][0]
            if this_value != parent_value:
                string = self.a[current[0] - 1] + string
            current = parent_cell
        return string

# lcs = LCS('springtime', 'pioneer')
# print(lcs.solve())


def djk_iterative(G, s):
    for v in G:
        v.distance = INFINITY
        v.discovered = False
    s.disitance = 0
    Q = heapify(G)
    while Q:
        u = heappop(Q)
        u.discovered = True
        for edge in u.edges:
            if not edge.v.discovered:
                relax(edge)


def dfs_iterative(G, s):
    for v in G:
        v.distance = INFINITY
        v.discovered = False
    s.distance = 0
    stack = list()
    stack.append(s)
    while stack:
        u = stack.pop()
        if not u.discovered:
            u.discovered = True
            for edge in u.edges:
                stack.append(edge.v)


def bfs_iterative(G, s):
    for v in G:
        v.distance = INFINITY
        v.discovered = False
    s.distance = 0
    queue = list()
    queue.append(s)
    while stack:
        u = queue.pop(0)
        if not u.discovered:
            u.discovered = True
            for edge in u.edges:
                queue.append(edge.v)
