//
//  HeapBuffer.swift
//  RuProcess
//
//  Created by omochimetaru on 2017/03/31.
//
//

public class HeapBuffer<T> {
    public convenience init(pointer: UnsafePointer<T>?, count: Int) {
        if count == 0 {
            self.init(pointerNoCopy: nil, count: 0, freeWhenDone: true)
        } else {
            let p = UnsafeMutablePointer<T>.allocate(capacity: count)
            p.initialize(from: pointer!, count: count)
            self.init(pointerNoCopy: p, count: count, freeWhenDone: true)
        }
    }

    public convenience init<C: Collection>(items: C)
        where C.Iterator.Element == T
    {
        if items.count == 0 {
            self.init(pointerNoCopy: nil, count: 0, freeWhenDone: true)
        } else {
            let count: Int = C.IndexDistance(0).distance(to: items.count)
            let pointer = UnsafeMutablePointer<T>.allocate(capacity: count)
            var p = pointer
            var i = items.startIndex
            while i < items.endIndex {
                p.initialize(to: items[i])
                p = p.advanced(by: 1)
                i = items.index(after: i)
            }
            self.init(pointerNoCopy: pointer, count: count, freeWhenDone: true)
        }
    }

    public init(pointerNoCopy: UnsafeMutablePointer<T>?, count: Int, freeWhenDone: Bool) {
        self.pointer = pointerNoCopy
        self.count = count
        self.freeWhenDone = freeWhenDone
    }

    deinit {
        if freeWhenDone, let p = pointer {
            p.deallocate(capacity: count)
        }
    }

    public let pointer: UnsafeMutablePointer<T>?
    public let count: Int
    private let freeWhenDone: Bool
}
