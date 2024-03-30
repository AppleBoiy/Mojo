## Array 1 Dimensional
##
## Implement a 1D array (with integer elements)

struct Array1D:
    var data: Pointer[Int]
    var size: Int

    fn __init__(inout self: Self, size: Int):
        self.size = size
        self.data = Pointer[Int].alloc(size)

    fn __copyinit__(inout self: Self, other: Array1D):
        self.size = other.size
        self.data = Pointer[Int].alloc(self.size)
        for idx in range(self.size):
            self.data.store(idx, other.data.load(idx))

    @always_inline
    fn __getitem__(borrowed self: Self, idx: Int) -> Int:
        return self.data.load(idx)

    @always_inline
    fn __setitem__(inout self: Self, idx: Int, value: Int):
        self.data.store(idx, value)

    fn __del__(owned self: Self):
        self.data.free()

    @always_inline
    fn toString(borrowed self: Self) -> String:
        var str: String = "["
        for idx in range(self.size):
            str += String(self.data.load(idx))
            if idx < self.size - 1:
                str += ", "
        return str + "]"

    @always_inline
    fn sorted(borrowed self: Self) -> Array1D:
        ## Sort the array w/ bubble sort
        var sortedArray = Array1D(self.size)
        for idx in range(self.size):
            sortedArray[idx] = self[idx]
        for i in range(self.size):
            for j in range(i + 1, self.size):
                if sortedArray[i] > sortedArray[j]:
                    var temp = sortedArray[i]
                    sortedArray[i] = sortedArray[j]
                    sortedArray[j] = temp
        return sortedArray

    @always_inline
    fn __add__(borrowed self: Self, other: Self) -> Array1D:
        var newArray = Array1D(self.size + other.size)
        for idx in range(self.size):
            newArray[idx] = self[idx]
        for idx in range(other.size):
            newArray[self.size + idx] = other[idx]
        return newArray

    @always_inline
    fn __radd__(borrowed self: Self, other: Self) -> Array1D:
        return self + other

    @always_inline
    fn __mul__(borrowed self: Self, other: Int) -> Array1D:
        var newArray = Array1D(self.size * other)
        for i in range(other):
            for j in range(self.size):
                newArray[i * self.size + j] = self[j]
        return newArray

    @always_inline
    fn __rmul__(borrowed self: Self, other: Int) -> Array1D:
        return self * other

    fn find(borrowed self: Self, value: Int) -> Int:
        for idx in range(self.size):
            if self[idx] == value:
                return idx
        return -1
