//
//  SnigletValidations.swift
//  Give Me a Sniglet
//
//  Created by Marquis Kurt on 15/11/21.
//

import Foundation

class Sniglet {
    public typealias Validator = SnigletValidator

    private var model: Validator

    public static var commonSyllables: [String] = ["CVCVCV", "CCCVVCC", "CVC", "CVVC", "CVVCC", "CCV"]
    var vowels = "aeiouy"
    var consonants = "bcdfghjklmnprqstvwxz"

    public static var shared: Sniglet { Sniglet() }

    public struct Result: Hashable, Identifiable {
        var id = UUID()
        var word: String
        var validation: String
        var confidence: Double

        public static func empty() -> Result {
            Result(word: "empty", validation: "valid", confidence: 0.0)
        }

        public static func null() -> Result {
            Result(word: "null", validation: "valid", confidence: 0.0)
        }

        public static func error() -> Result {
            Result(word: "error", validation: "valid", confidence: 0.0)
        }
    }

    init() {
        model = try! SnigletValidator(configuration: .init())
    }

    public func getNewWords(count: Int = 1) -> [Result] {
        var generatedWords: [String] = []

        var minof = UserDefaults.standard.integer(forKey: "algoMinBound")
        if minof <= 0 {
            minof = 3
            UserDefaults.standard.set(3, forKey: "algoMinBound")
        }

        var maxof = UserDefaults.standard.integer(forKey: "algoMaxBound")
        if maxof <= 0 {
            maxof = 8
            UserDefaults.standard.set(8, forKey: "algoMaxBound")
        }

        var batchSize = UserDefaults.standard.integer(forKey: "algoBatchSize")
        if batchSize <= 0 {
            batchSize = 25
            UserDefaults.standard.set(25, forKey: "algoBatchSize")
        }

        for _ in 0..<batchSize {
            var newWord = makeWord(limit: minof..<maxof, with: Sniglet.commonSyllables.randomElement() ?? "CV")
            if newWord.count < 8 {
                for _ in newWord.count..<8 {
                    newWord += "*"
                }
            }
            generatedWords.append(newWord)
        }

        var wordResults: [Result] = []

        do {
            let batchInput = generatedWords.map { word in word.asSnigletValidatorInput() }
            let batchResults = try model.predictions(inputs: batchInput).enumerated()
                .map { index, result in
                    Result(word: generatedWords[index].replacingOccurrences(of: "*", with: ""),
                           validation: result.Valid, confidence: result.ValidProbability["valid"] ?? 0)
                }
                .filter { result in result.validation == "valid" }

            for _ in 0..<count {
                wordResults.append(batchResults.randomElement() ?? .null())
            }
            return wordResults
        } catch {
            return [.error()]
        }

    }

    public func makeWord(limit wordRange: Range<Int> = 3..<12, with syllabicStruct: String = "CV") -> String {
        var currentSyllableIdx = 0
        var result = ""
        for _ in 0...Int.random(in: wordRange) {
            if syllabicStruct[currentSyllableIdx] == "V" {
                result.append(vowels.randomElement() ?? "e")
            } else {
                result.append(self.consonants.randomElement() ?? "t")
            }
            
            currentSyllableIdx += 1
            if currentSyllableIdx >= syllabicStruct.count {
                currentSyllableIdx = 0
            }
        }

        return result
    }

    /// Returns a randomly-generated word from a range and a specified syllabic structure.
    public func makeWord(min: Int = 3, max: Int = 12, with syllabicStruct: String = "CV") -> String {
        makeWord(limit: min..<max, with: syllabicStruct)
    }

}

extension String {
    func splitCharacters() -> [String] {
        self.map { char in String(char) }
    }

    func asSnigletValidatorInput() -> SnigletValidatorInput {
        let wordSplit = self.splitCharacters()
        return SnigletValidatorInput(
            char01: wordSplit[0], char02: wordSplit[1], char03: wordSplit[2], char04: wordSplit[3],
            char05: wordSplit[4], char06: wordSplit[5], char07: wordSplit[6], char08: wordSplit[7])
    }
}

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}
