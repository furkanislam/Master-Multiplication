//
//  MultiplicationQuestion.swift
//  MultiplicationTable
//
//  Created by Furkan İSLAM on 9.02.2025.
//

import Foundation


struct MultiplicationQuestion: Identifiable {
    let id = UUID()         // Her soru için benzersiz bir kimlik
    let number1: Int
    let number2: Int
    let correctAnswer: Int
    
    
    init(number1: Int, number2: Int) {
        self.number1 = number1
        self.number2 = number2
        self.correctAnswer = number1 * number2
    }
}
