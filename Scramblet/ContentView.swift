//
//  ContentView.swift
//  Scramblet
//
//  Created by Justin Hold on 4/9/25.
//

import SwiftUI

struct ContentView: View {
	
	// MARK: - Properties
	@State private var dictionary = GameDictionary()
	@State private var targetWord: String = ""
	@State private var spellableWords = [String]()
	@State private var foundWords = Set<String>()
	
	@State private var letters = [Letter]()
	@State private var currentWord = [Letter]()
	
	let columns = Array(
		repeating: GridItem(
			.flexible(
				minimum: 100,
				maximum: 150
			),
			spacing: 0
		),
		count: 3
	)
	
	// MARK: - View Body
    var body: some View {
		
		VStack(spacing: 20) {
			LazyVGrid(columns: columns) {
				ForEach(spellableWords, id: \.self) { word in
					Text(
						foundWords.contains(word)
						? word.uppercased()
						: String(repeating: "•", count: word.count)
					)
					.font(.title3)
					.frame(maxWidth: .infinity, alignment: .center)
				}
			}
			
			HStack {
				ForEach(currentWord) { letter in
					Button {
						remove(letter)
					} label: {
						Text(letter.text.uppercased())
							.font(.largeTitle)
							.frame(width: 44, height: 44)
							.foregroundStyle(.white)
							.background(.blue)
					}
					.buttonStyle(.plain)
				}
				
				if currentWord.isEmpty {
					Text("A")
						.frame(width: 44, height: 44)
						.hidden()
				}
			}
			
			HStack {
				ForEach(letters) { letter in
					Button {
						use(letter)
					} label: {
						Text(letter.text.uppercased())
							.font(.largeTitle)
							.frame(width: 44, height: 44)
					}
					.disabled(currentWord.contains(letter))
				}
			}
			
			Button("Submit", action: submit)
				.disabled(currentWord.count < 3)
        }
		.padding()
		.onAppear(perform: load)
    }
	
	// MARK: - Functions
	func load() {
		
		targetWord = [
			"advert",
			"bestow",
			"brains",
			"carbon",
			"finally",
			"randsom",
			"signed",
			"tingle"
		].randomElement()!
		
		spellableWords = dictionary.spellableWords(from: targetWord)
		
		spellableWords = rotate(items: spellableWords, columns: 3)
		
		letters = targetWord.shuffled().map {
			Letter(text: String($0))
		}
	}
	
	func use(_ letter: Letter) {
		withAnimation {
			currentWord.append(letter)
		}
	}
	
	func remove(_ letter: Letter) {
		withAnimation {
			if let index = currentWord.firstIndex(of: letter) {
				currentWord.remove(at: index)
			}
		}
	}
	
	func submit() {
		
		// join the spelled word into a single string
		let spelled = currentWord.map(\.text).joined()
		
		guard foundWords.contains(spelled) == false else { return}
		
		if spellableWords.contains(spelled) {
			foundWords.insert(spelled)
		}
		
		currentWord.removeAll()
	}
	
	func rotate(items: [String], columns: Int) -> [String] {
		
		let rows = (items.count + columns - 1) / columns
		var result = [String]()
		
		for row in 0..<rows {
			for col in 0..<columns {
				let index = col * rows + row
				if index < items.count {
					result.append(items[index])
				}
			}
			
		}
		return result
	}
	
}

#Preview {
    ContentView()
}
