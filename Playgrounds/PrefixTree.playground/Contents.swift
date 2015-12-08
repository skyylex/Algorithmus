let trie = PrefixTree()
trie.insertSequence(Array("hello".characters))
trie.insertSequence(Array("helicopter".characters))
trie.insertSequence(Array("hammond".characters))

print(trie.allSequences())
print(trie.search(["h"]))
print(trie.search(["h", "e", "l", "l"]))
