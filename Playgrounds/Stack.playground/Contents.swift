extension String {
    internal func reverseString() -> String {
        let stack = Stack<Character>()
        for symbol in self.characters {
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

print("Source: " + sourceString.reverseString())
print("Reversed: " + sourceString.reverseString())