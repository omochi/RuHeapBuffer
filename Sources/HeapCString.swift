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
        self.init(items: string.utf8CString)
    }
}
