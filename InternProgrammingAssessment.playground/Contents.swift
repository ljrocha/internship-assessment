import UIKit
import CoreLocation

// ------------------------------
// ***** SOFTBALL QUESTIONS *****
// ------------------------------

// Write a function that takes a paragraph of text and tells you what the most popular word is

func mostPopularWord(in string: String) -> String? {
    var wordCount = [String: Int]()

    var nonLettersCharacterSet = CharacterSet.letters.inverted
    nonLettersCharacterSet.remove("'")

    for word in string.components(separatedBy: nonLettersCharacterSet) where !word.isEmpty {
        wordCount[word.lowercased(), default: 0] += 1
    }

    return wordCount.max { $0.value < $1.value }?.key
}

// Write a function that takes a string and returns it in reverse order

func reversed(_ string: String) -> String {
    String(string.reversed())
}

/* (bonus) Write a function that takes a string, that will contain single digit numbers,
 letters, and question marks, and check if there are exactly 3 question marks between every
 pair of two numbers that add up to 10. If so, then your program should return the string true,
 otherwise it should return the string false. If there aren't any two numbers that add up to 10 in the string,
 then your program should return false as well
 */

func verifyFormat(in string: String) -> String {
    var previousDigits = [Int: Set<Int>]()
    var currentQuestionMarkCount = 0
    var foundPair = false

    for character in string {
        if let digit = Int(String(character)) {
            guard !previousDigits.isEmpty else {
                currentQuestionMarkCount = 0
                previousDigits[digit, default: []].insert(0)
                continue
            }

            let complement = 10 - digit
            if let previousQuestionMarkCountValues = previousDigits[complement] {
                foundPair = true
                for previousQuestionMarkCount in previousQuestionMarkCountValues {
                    guard currentQuestionMarkCount - previousQuestionMarkCount == 3 else { return "false" }
                }
            }

            previousDigits[digit, default: []].insert(currentQuestionMarkCount)
        } else if character == "?" {
            currentQuestionMarkCount += 1
        }
    }

    return String(foundPair)
}

/* (bonus) Write a function that takes a paragraph (string data type) and returns the largest word
 in the string. If there are two or more words that are the same length, return the first word from
 the string with that length. Ignore punctuation and assume the string will not be empty.
 */

func largestWord(in string: String) -> String {
    var nonLettersCharacterSet = CharacterSet.letters.inverted
    nonLettersCharacterSet.remove("'")
    
    var maxWordSize = 0
    var maxWord = ""
    for word in string.components(separatedBy: nonLettersCharacterSet) where !word.isEmpty {
        let wordSize = word.count
        if wordSize > maxWordSize {
            maxWordSize = wordSize
            maxWord = word
        }
    }

    return maxWord
}

// ---------------------
// ***** ALGORITHM *****
// ---------------------

struct Address {
    let number: Int
    let streetName: String
    let city: String
    let state: String
    let zipCode: Int
}

struct Person {
    let name: String
    let birthday: Date
    var location: CLLocation
    var address: Address
}

/* Write a function that takes a person and returns the person in the array that is
 physically closest to that person.
 */

func closestPerson(to individual: Person, in persons: [Person]) -> Person? {
    return persons.min { $0.location.distance(from: individual.location) < $1.location.distance(from: individual.location) }
}

/* (bonus) Write a function that takes an array of people objects and returns a grouping
 by address specifically city and state. For example group people that are from the same city
 and state (Los Angeles, CA).
*/

func groupByCityAndState(_ persons: [Person]) -> [String: [Person]] {
    var result = [String: [Person]]()
    
    persons.forEach {
        let location = "\($0.address.city), \($0.address.state)"
        result[location, default: []].append($0)
    }
    
    return result
}
