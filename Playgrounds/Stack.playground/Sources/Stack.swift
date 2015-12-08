//
//  Stack.swift
//  Stack
//
//  Created by Yury Lapitsky on 01.08.15.
//  Copyright (c) 2015 skyylex. All rights reserved.
//

import Foundation

public class Stack<T> {
    private var storage:Array<T> = []

    public init() {
    
    }

    public func isEmpty() -> Bool {
        return (storage.count == 0)
    }

    public func push(value: T) {
        storage.append(value)
    }

    public func pop() -> T? {
        return (storage.count > 0) ? storage.removeLast() : nil
    }

    public func popAll() {
        storage.removeAll(keepCapacity: false)
    }
}
