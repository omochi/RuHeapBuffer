//
//  HeapBuffer.swift
//  RuProcess
//
//  Created by omochimetaru on 2017/03/31.
//
//

public class HeapBuffer<T> {
    public init(from: UnsafePointer<T>?, count: Int) {
        if count == 0 {
            buffer = UnsafeMutableBufferPointer<T>(start: nil, count: 0)
        } else {
            let pointer = UnsafeMutablePointer<T>.allocate(capacity: count)
            pointer.initialize(from: from!, count: count)
            buffer = UnsafeMutableBufferPointer<T>(start: pointer, count: count)
        }
    }

    deinit {
        baseAddress?.deallocate(capacity: count)
    }

    public var baseAddress: UnsafeMutablePointer<T>? {
        return buffer.baseAddress
    }

    public var count: Int {
        return buffer.count
    }

    public var rawBuffer: UnsafeMutableBufferPointer<T> {
        return buffer
    }

    public subscript(index: Int) -> T {
        get {
            return buffer[index]
        }
        set {
            buffer[index] = newValue
        }
    }

    private var buffer: UnsafeMutableBufferPointer<T>
}
