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
		count: 5
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
					.frame(maxWidth: .infinity, alignment: .leading)
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
}

#Preview {
    ContentView()
}
