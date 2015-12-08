import Foundation

let root = Node<Int>(newValue: 40)
let tree = BinaryTree<Int>(root: root, orderRule: OrderResult.RightGreaterOrEqual)

tree.addNode(Node<Int>(newValue: 10))
tree.addNode(Node<Int>(newValue: -10))
tree.addNode(Node<Int>(newValue: 22))
tree.addNode(Node<Int>(newValue: 70))
tree.addNode(Node<Int>(newValue: 44))
tree.addNode(Node<Int>(newValue: 55))
tree.addNode(Node<Int>(newValue: 445))
tree.addNode(Node<Int>(newValue: 5333))
tree.addNode(Node<Int>(newValue: 443))
tree.addNode(Node<Int>(newValue: 4433))
tree.addNode(Node<Int>(newValue: 44333))

tree.addNode(Node<Int>(newValue: 443333))
tree.addNode(Node<Int>(newValue: 20))
tree.addNode(Node<Int>(newValue: 0))
tree.addNode(Node<Int>(newValue: 30))

let deep = tree.deep
let maxSymbolsInValue = 5

print("\n\n Text-drawn binary tree \n\n")

tree.traverseUpsideDown({ nodes in
    
    let node = nodes.first
    let additionalOffset = node!.root ? 0 : node!.level
    let spaces = (0...(deep * (maxSymbolsInValue - additionalOffset))).map { _ in return " " }
    let offsetString = spaces.reduce("") { $0 + $1}
    
    let horizontalSpaces = (0...maxSymbolsInValue * 2).map { _ in return " " }
    let horizontalSpaceString = horizontalSpaces.reduce("") { $0 + $1}
    
    let levelString = nodes.reduce("") { current, node in
        return current + horizontalSpaceString + String(node.value)
    }
    print(offsetString + levelString)
})

print("\n\n Plain sorted list \n\n")

tree.traverse { (node : Node<Int>) -> Void in
    print(String(node.value))
}

