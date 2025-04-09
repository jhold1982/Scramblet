//
//  GameDictionary.swift
//  Scramblet
//
//  Created by Justin Hold on 4/9/25.
//

import Foundation

struct GameDictionary {
	
	// Declares a private Set collection variable named 'words' that stores unique String values
	private var words = Set<String>()
	
	
	init() {
		
		guard let url = Bundle.main.url(forResource: "dictionary", withExtension: "txt") else {
			fatalError("Failed to locate dictionary.txt")
		}
		
		guard let string = try? String(contentsOf: url, encoding: .utf8) else {
			fatalError("Failed to load dictionary.txt")
		}
		
		let allWords = string.components(separatedBy: "\n")
		
		words = Set(allWords.filter { $0.count <= 6 })
	}
	
	func canForm(_ source: String, from target: String) -> Bool {
		
		var target = target
		
		for letter in source {
			if let pos = target.firstIndex(of: letter) {
				target.remove(at: pos)
			} else {
				return false
			}
		}
		
		return true
	}
	
	func spellableWords(from target: String) -> [String] {
		
		var result = [String]()
		
		for word in words {
			if canForm(word, from: target) {
				result.append(word)
			}
		}
		
		return result
	}
}
