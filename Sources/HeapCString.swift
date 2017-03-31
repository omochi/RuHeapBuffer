//
//  HeapCString.swift
//  RuHeapBuffer
//
//  Created by omochimetaru on 2017/03/31.
//
//

public typealias HeapCString = HeapBuffer<CChar>

public extension HeapBuffer where T == CChar {
    public convenience init(string: String) {
        let cstr = string.utf8CString

        var pointer: UnsafePointer<CChar>?
        var size: Int = 0
        cstr.withUnsafeBufferPointer {
            pointer = $0.baseAddress
            size = $0.count
        }

        self.init(from: pointer, count: size)
    }
}
