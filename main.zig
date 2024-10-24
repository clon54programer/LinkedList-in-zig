const std = @import("std");
const print = std.debug.print;
const expect = std.testing.expect;

fn LinkedList(comptime T: type) type {
    return struct {
        pub const Node = struct {
            data: T,
            next: ?*Node,

            pub fn AddNode(self: *Node, next: ?*Node) void {
                self.next = next;

                //self.*.next = next
                // Esta linea es peligrosa porque estaria
                // en casos en donde el puntero next
                // sea nulo, mandaria error.

            }

            pub fn AddData(self: *Node, data: T) void {
                self.*.data = data;
            }
        };
    };
}

test LinkedList {
    const LinkedInteger = LinkedList(u64);

    var node: LinkedInteger.Node = undefined;
    var node_2: LinkedInteger.Node = undefined;
    var node_3: LinkedInteger.Node = undefined;

    node = .{
        .data = 1,
        .next = &node_2,
    };

    node_2 = .{
        .data = 2,
        .next = &node_3,
    };

    node_3 = .{
        .data = 3,
        .next = null,
    };

    var heap: ?*LinkedInteger.Node = &node;

    while (heap != null) {
        print("Data: {}\n", .{heap.?.data});
        heap = heap.?.next;
    }
    print("Fin de la lista\n", .{});
    try expect(heap == null);
}

test "AddNode" {
    const LinkedInteger = LinkedList(u64);

    var node: LinkedInteger.Node = undefined;
    var node_2: LinkedInteger.Node = undefined;
    var node_3: LinkedInteger.Node = undefined;

    node = .{
        .data = 1,
        .next = null,
    };
    node.AddNode(&node_2);

    node_2 = .{
        .data = 2,
        .next = null,
    };

    node_2.AddNode(&node_3);

    node_3 = .{
        .data = 3,
        .next = null,
    };

    var heap: ?*LinkedInteger.Node = &node;

    while (heap != null) {
        print("Data: {}\n", .{heap.?.data});
        heap = heap.?.next;
    }
    print("Fin de la lista\n", .{});

    try expect(heap == null);

    node_3.AddData(12);

    try expect(node_3.data == 12);
}
