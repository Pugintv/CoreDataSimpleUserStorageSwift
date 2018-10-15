//
//  PasswordValidator.swift
//  CoreDataSimpleUserStorageSwift
//
//  Created by Victor Rosas on 10/8/18.
//  Copyright © 2018 Victor Rosas. All rights reserved.
//

import Foundation
class PasswordValidator {
    
    func hasLetters(textInput:String)->Bool{
        let characters = NSCharacterSet.letters
        let charRange = textInput.rangeOfCharacter(from: characters)
        return (charRange != nil)
    }
    
    func hasNumbers(textInput:String)->Bool{
        let numbers = NSCharacterSet.decimalDigits
        let numbersRange = textInput.rangeOfCharacter(from: numbers)
        return (numbersRange != nil)
    }
    
    func isInRange(topRange:Int,bottomRange:Int,textInput:String)->Bool{ //Refactor length to be input
        return (topRange > textInput.count && textInput.count > bottomRange)
    }
    
    func hasSequenceRepetition(textInput:String)->Bool{//Will return true if pattern matches
        let regex = try? NSRegularExpression(pattern: "(\\w{2,})\\1", options: [])//If regex throw error is nil
        let boolTest = regex?.firstMatch(in: textInput,options:[], range: NSRange(location: 0, length: textInput.utf16.count))
        return boolTest != nil
    }
    
    func containsInvalidChars(textInput:String)->Bool{
        let notValidChars = NSCharacterSet.alphanumerics.inverted
        let notValidCharsRange = textInput.rangeOfCharacter(from: notValidChars)
        return (notValidCharsRange != nil)
    }
    
    func isValid(textInput:String)->Bool{
        return (hasLetters(textInput:textInput) && hasNumbers(textInput:textInput) && isInRange(topRange: 12, bottomRange: 5, textInput: textInput) && !hasSequenceRepetition(textInput:textInput) && !containsInvalidChars(textInput:textInput))
    }
    
}
