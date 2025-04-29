//
//  Letter.swift
//  Scramblet
//
//  Created by Justin Hold on 4/14/25.
//

import Foundation

/// A model representing a single letter or character.
///
/// The `Letter` struct is designed to represent an individual letter or character
/// within a text-based application. It conforms to `Equatable` for comparison operations
/// and `Identifiable` to support use in SwiftUI lists and collections.
///
/// - Note: Each instance automatically generates a unique identifier through UUID().
///
/// ## Example Usage:
/// ```swift
/// let letterA = Letter(text: "A")
/// let letterB = Letter(text: "B")
///
/// if letterA != letterB {
///     print("These letters are different")
/// }
/// ```
struct Letter: Equatable, Identifiable {
	/// A unique identifier for the letter.
	///
	/// This property is automatically generated when a new instance is created
	/// and is used for identity comparison in collections.
	var id = UUID()
	
	/// The textual content of the letter.
	///
	/// This property stores the actual character or string that the letter represents.
	/// It can be a single character or multiple characters, depending on the application's needs.
	var text: String
}
