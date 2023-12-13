extends Node

var trie

## Load the text file and create a trie of it.
class TrieNode:
	var children = {} # Dictionary to store child nodes
	var is_end_of_word = false # Flag to indicate the end of a word

	# Initialize TrieNode
	func _init():
		children = {}
		is_end_of_word = false

class Trie:
	var root = TrieNode.new() # The root node of the trie

	# Constructor function for Trie
	func _init():
		root = TrieNode.new()

	# Insert a word into the trie
	func insert(word: String) -> void:
		var node = root

		for char in word:
			if not node.children.has(char):
				node.children[char] = TrieNode.new()

			node = node.children[char]

		node.is_end_of_word = true

	# Read words from a text file and build the trie
	func build_from_file(file_path: String) -> void:
		var file = FileAccess.open(file_path, FileAccess.READ)
		
		if file:
			while not file.eof_reached():
				var word = file.get_line().strip_edges()
				insert(word)
			
			file.close()

	# Check if a word exists in the trie
	func search(word: String) -> bool:
		var node = root

		for char in word:
			if not node.children.has(char):
				return false

			node = node.children[char]

		return node.is_end_of_word

	# Simple search function
	func simple_search(word: String) -> void:
		if search(word):
			print(word, " exists in the trie.")
		else:
			print(word, " does not exist in the trie.")

# Called when the node enters the scene tree for the first time.
func _ready():
	trie = Trie.new()
	trie.build_from_file("res://assets/words_alpha.txt")
