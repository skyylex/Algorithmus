enum OrderResult {
    case LeftGreater
    case RightGreaterOrEqual
}

class Node<T : Comparable> {
    var value: T

    var root: Bool = false
    var leaf: Bool { return (self.rightChild == nil) && (self.leftChild == nil) }
    
    var leftChild: Node?
    var rightChild: Node?
    
    init(newValue: T) {
       value = newValue
    }
    
    func compare(otherNode: Node) -> OrderResult {
        return (self.value > otherNode.value) ? .LeftGreater : .RightGreaterOrEqual
    }
}


struct BinaryTree<T: Comparable> {
    let rootNode: Node<T>
    let order: OrderResult
    
    init(root: Node<T>, orderRule: OrderResult) {
        rootNode = root
        order = orderRule
    }
    
    internal func addNode(new: Node<T>, currentRoot: Node<T>?) {
        let root = currentRoot ?? self.rootNode
        
        if root.value > new.value {
            if let leftNode = root.leftChild {
                addNode(new, currentRoot: leftNode)
            } else {
                root.leftChild = new
            }
        } else {
            if let rightNode = root.rightChild {
                addNode(new, currentRoot: rightNode)
            } else {
                root.rightChild = new
            }
        }
    }
    
    internal func bypass(action: ((Node<T>?) -> Void)?) {
        bypass(self.rootNode, action:action ?? nil)
    }
    
    private func bypass(current: Node<T>, action:((Node<T>?) -> Void)?) {
        if let validAction = action {
            validAction(nil)
        }
        
        if let left = current.leftChild {
            bypass(left, action: action)
            
            if let right = current.rightChild {
                bypass(right, action: action)
            }
        } else if let right = current.rightChild {
            bypass(right, action: action)
        }
    }
}
