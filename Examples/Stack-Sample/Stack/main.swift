//
//  main.swift
//  Stack
//
//  Created by Yury Lapitsky on 01.08.15.
//  Copyright (c) 2015 skyylex. All rights reserved.
//

import Foundation

extension String {
    internal func reverseString() -> String {
        let stack = Stack<Character>()
        for symbol in self {
            stack.push(symbol)
        }
        
        var reversedString = ""
        while stack.isEmpty() != true {
            reversedString.append(stack.pop() ?? Character(""))
        }
        
        return reversedString
    }
}

let sourceString = "#aibohphobia$"

println("Source: " + sourceString.reverseString())
println("Reversed: " + sourceString.reverseString())



