class Node {
    let value: Character?
    var children = Array<Node>()
    let level: Int
    
    var root = false
    var isLeaf: Bool {
        return children.count == 0
    }
    
    init(isRoot: Bool, value: Character? = nil, level: Int = 0) {
        self.root = isRoot
        self.value = value
        self.level = level
    }
}

class Trie {
    let root = Node(isRoot: true)
    
    func allSequences() -> [[Character]] {
        let sequences = allSequences([], currentNode: root)
        return sequences
    }
    
    func search(symbols: [Character]) -> [[Character]] {
        return search(symbols, currentSequence:[], currentNode:root)
    }
    
    private func search(symbols: [Character], currentSequence: Array<Character>, currentNode: Node) -> [[Character]] {
        var resultSequences = [[Character]]()
        var canMoveFurther = false
        var extendedSequence = Array<Character>()
        
        if currentNode.root == false {
            if let currentValue = currentNode.value {
                if symbols.count < currentNode.level || currentValue == symbols[currentNode.level - 1] {
                    extendedSequence = currentSequence + [currentValue]
                    canMoveFurther = true
                }
            }
        } else {
            canMoveFurther = true
        }
        
        if canMoveFurther {
            if currentNode.isLeaf {
                resultSequences.append(extendedSequence)
            } else {
                for childNode in currentNode.children {
                    resultSequences += search(symbols, currentSequence: extendedSequence, currentNode:childNode)
                }
            }
        }
        
        return resultSequences
    }
    
    private func allSequences(currentSequence: Array<Character>, currentNode: Node) -> [[Character]] {
        var resultSequences = [[Character]]()
        
        var extendedSequence = Array<Character>()
        if let currentValue = currentNode.value {
            extendedSequence = currentSequence + [currentValue]
            print(currentNode.level)
        }
        
        if currentNode.isLeaf {
            resultSequences.append(extendedSequence)
        } else {
            for childNode in currentNode.children {
                resultSequences += allSequences(extendedSequence, currentNode:childNode)
            }
        }
        
        return resultSequences
    }
    
    internal func insertSequence(newSequence:[Character]) {
        insertSequence(newSequence, currentNode: root)
    }
    
    internal func insertSequence(sequence: Array<Character>, currentNode:Node, level: Int = 0) {
        var parrentNode = currentNode
        if let currentValueToInsert = sequence.first {
            let existingNodes = currentNode.children.filter { $0.value == currentValueToInsert }
            if let firstExistingNode = existingNodes.first {
                let subSequence = sequence[1...(sequence.count - 1)]
                self.insertSequence(Array(subSequence), currentNode: firstExistingNode, level: level + 1)
            } else {
                var currentLevel = level + 1
                for value in sequence {
                    let node = Node(isRoot: false, value:value, level: currentLevel)
                    parrentNode.children.append(node)
                    parrentNode = node
                    currentLevel += 1
                }
            }
        }
    }
}

let trie = Trie()
trie.insertSequence(Array("hello".characters))
trie.insertSequence(Array("helicopter".characters))
trie.insertSequence(Array("hammond".characters))

print(trie.allSequences())
print(trie.search(["h"]))
print(trie.search(["h", "e", "l", "l"]))