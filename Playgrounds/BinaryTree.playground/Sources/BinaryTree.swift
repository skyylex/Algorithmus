//
//  BinaryTree.swift
//  BinaryTree-Sample
//
//  Created by Yury Lapitsky on 7/29/15.
//  Copyright (c) 2015 skyylex. All rights reserved.
//


public enum OrderResult {
    case LeftGreater
    case RightGreaterOrEqual
}

public class Node<T : Comparable> {
    public var value: T

    public var root: Bool = false
    public var leaf: Bool { return (self.rightChild == nil) && (self.leftChild == nil) }
    
    public var level: Int = 0
    
    public var leftChild: Node?
    public var rightChild: Node?
    
    public init(newValue: T) {
       value = newValue
    }
    
    public func compare(otherNode: Node) -> OrderResult {
        return (self.value > otherNode.value) ? .LeftGreater : .RightGreaterOrEqual
    }
}


public struct BinaryTree<T: Comparable> {
    public let rootNode: Node<T>
    public let order: OrderResult
    
    public var deep: Int {
        var result = 0
        traverse({ node in
            result = node.level > result ? node.level : result
        })
        
        return result
    }
    
    public init(root: Node<T>, orderRule: OrderResult) {
        rootNode = root
        order = orderRule
    }
    
    public func addNode(new: Node<T>) {
        addNode(new, currentRoot: rootNode)
    }
    
    private func addNode(new: Node<T>, currentRoot: Node<T>?) {
        let root = currentRoot ?? self.rootNode
        
        if root.value > new.value {
            if let leftNode = root.leftChild {
                addNode(new, currentRoot: leftNode)
            } else {
                root.leftChild = new
                new.level = root.level + 1
            }
        } else {
            if let rightNode = root.rightChild {
                addNode(new, currentRoot: rightNode)
            } else {
                root.rightChild = new
                new.level = root.level + 1
            }
        }
    }
    
    public func traverseUpsideDown(action: (([Node<T>]) -> Void)?) {
        let maxDeep = self.deep
        let levelElements = (0...self.deep).map { (level : Int) -> [Node<T>] in
            var elements = [Node<T>]()
            self.traverse { node in
                if node.level == level {
                    elements.append(node)
                }
            }
            return elements
        }
        
        if let validAction = action {
            for elements in levelElements {
                validAction(elements)
            }
        }
    }
    
    public func traverse(action: ((Node<T>) -> Void)?) {
        traverse(self.rootNode, action:action ?? nil)
    }
    
    public func traverse(current: Node<T>, action:((Node<T>) -> Void)?) {
        if let left = current.leftChild {
            traverse(left, action: action)
        }
        
        if let validAction = action {
            validAction(current)
        }
        
        if let right = current.rightChild {
            traverse(right, action: action)
        }
    }
}
