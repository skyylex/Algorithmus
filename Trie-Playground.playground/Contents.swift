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
        let sequences = search([])
        return sequences
    }
    
    func search(symbols: [Character]) -> [[Character]] {
        return search(symbols, currentSequence:[], currentNode:root)
    }
    
    private func search(symbols: [Character], currentSequence: Array<Character>, currentNode: Node) -> [[Character]] {
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
                return [extendedSequence]
            } else {
                let foundSequences = currentNode.children.map { search(symbols, currentSequence: extendedSequence, currentNode:$0) }
                return foundSequences.reduce([[Character]]()) { $0 + $1}
            }
        }
        
        return [[Character]]()
    }
    
    internal func insertSequence(newSequence:[Character]) {
        insertSequence(newSequence, currentNode: root)
    }
    
    internal func insertSequence(sequence: Array<Character>, currentNode:Node, level: Int = 0) {
        if let currentValueToInsert = sequence.first {
            let existingNodes = currentNode.children.filter { $0.value == currentValueToInsert }
            if let firstExistingNode = existingNodes.first {
                let subSequence = sequence[1...(sequence.count - 1)]
                self.insertSequence(Array(subSequence), currentNode: firstExistingNode, level: level + 1)
            } else {
                directInsert(sequence, parentNode:currentNode, currentLevel:level + 1)
            }
        }
    }
    
    private func directInsert(sequence: Array<Character>, parentNode: Node, currentLevel: Int) {
        if let first = sequence.first {
            let node = Node(isRoot:false, value:first, level:currentLevel)
            parentNode.children.append(node)
            if sequence.count >= 2 {
                let otherSequencePart = sequence[1...(sequence.count - 1)]
                directInsert(Array(otherSequencePart), parentNode:node, currentLevel:currentLevel + 1)
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