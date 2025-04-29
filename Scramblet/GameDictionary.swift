//
//  GameDictionary.swift
//  Scramblet
//
//  Created by Justin Hold on 4/9/25.
//

import Foundation

/// A struct that loads a dictionary file and provides functionality to find words that can be spelled using letters from a target string.
///
/// The GameDictionary loads words from a text file in the app bundle and provides methods to:
/// - Check if a word can be formed using letters from a target string
/// - Find all possible words that can be formed from a target string, sorted by length and alphabetically
struct GameDictionary {
	/// A private Set collection to store unique dictionary words.
	/// Using a Set provides efficient lookup operations with O(1) complexity.
	private var words = Set<String>()
	
	/// Initializes a new game dictionary by loading words from a dictionary.txt file in the app bundle.
	///
	/// The initializer performs the following steps:
	/// 1. Locates the dictionary.txt file in the app bundle
	/// 2. Loads the file contents as a string
	/// 3. Splits the string into individual words
	/// 4. Filters words to only include those with 6 or fewer characters
	/// 5. Stores the filtered words in the words Set
	///
	/// - Throws: `fatalError` if the dictionary file cannot be found or loaded
	init() {
		// Attempt to locate the dictionary file in the main bundle
		guard let url = Bundle.main.url(forResource: "dictionary", withExtension: "txt") else {
			fatalError("Failed to locate dictionary.txt")
		}
		
		// Attempt to load the contents of the file as a string
		guard let string = try? String(contentsOf: url, encoding: .utf8) else {
			fatalError("Failed to load dictionary.txt")
		}
		
		// Split the string into individual words
		let allWords = string.components(separatedBy: "\n")
		
		// Filter words to only include those with 6 or fewer characters
		words = Set(allWords.filter { $0.count <= 6 })
	}
	
	/// Determines if a source word can be formed using letters from a target string.
	///
	/// This method checks if each letter in the source word can be found in the target string.
	/// Once a letter is used from the target, it cannot be used again.
	///
	/// - Parameters:
	///   - source: The word to check if it can be formed
	///   - target: The string containing available letters
	/// - Returns: `true` if the source word can be formed using letters from the target, `false` otherwise
	func canForm(_ source: String, from target: String) -> Bool {
		// Create a mutable copy of the target string
		var target = target
		
		// Check each letter in the source word
		for letter in source {
			// Look for the current letter in the target string
			if let pos = target.firstIndex(of: letter) {
				// If found, remove it from the target to prevent reuse
				target.remove(at: pos)
			} else {
				// If any letter cannot be found, the word cannot be formed
				return false
			}
		}
		
		// If all letters were found, the word can be formed
		return true
	}
	
	/// Finds all words in the dictionary that can be spelled using letters from the target string.
	///
	/// This method:
	/// 1. Checks each word in the dictionary to see if it can be formed from the target string
	/// 2. Collects all valid words into an array
	/// 3. Sorts the results first by length (shortest first), then alphabetically for words of the same length
	///
	/// - Parameter target: The string containing available letters
	/// - Returns: An array of words that can be formed, sorted by length and then alphabetically
	func spellableWords(from target: String) -> [String] {
		// Initialize an empty array to collect results
		var result = [String]()
		
		// Check each word in the dictionary
		for word in words {
			// Add the word to results if it can be formed from the target
			if canForm(word, from: target) {
				result.append(word)
			}
		}
		
		// Sort results by length first, then alphabetically for words of the same length
		result.sort { first, second in
			if first.count == second.count {
				first < second
			} else {
				first.count < second.count
			}
		}
		
		return result
	}
}
