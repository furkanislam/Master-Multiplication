    //
    //  MultiplicationGameViewModel.swift
    //  MultiplicationTable
    //
    //  Created by Furkan İSLAM on 9.02.2025.
    //

    import SwiftUI

    class MultiplicationGameViewModel: ObservableObject {
        
        @Published var selectedNumber = 2 // Kullanıcının seçtiği çarpım tablosu
        @Published var questionCount = 10 // Kullanıcının seçtiği soru sayısı
        @Published var questions: [MultiplicationQuestion] = [] // Soruların listesi
        @Published var currentQuestionIndex = 0 // Şu anki soru
        @Published var userAnswer: String = "" // Kullanıcı cevabı
        @Published var score = 0 // Puan
        @Published var isCorrect: Bool? = nil // Doğru mu yanlış mı?
        @Published var animateColor = false // Animasyon için
        @Published var showAlert = false
        @Published var alertMessage = "" // alert mesajı
        @Published var buttonColor: Color = .blue
        @Published var animateCorrectAnswer = false
        @Published var animateWrongAnswer = false
        @Published var animateScore = false
        
        
        
        
        init() {
            startGame()
        }
        
        
        // Yeni oyun başlat
        func startGame() {
            
            questions = (1...questionCount).map {_ in MultiplicationQuestion(number1: selectedNumber, number2: Int.random(in: 1...10)) }
            currentQuestionIndex = 0
            userAnswer = ""
            score = 0
            isCorrect = nil
            animateColor = false
        }
        
        // Kullanıcının cevabını kontrol et
        
        func checkAnswer() {
            guard let userInt = Int(userAnswer), currentQuestionIndex < questions.count else { return }
            
            if userInt == questions[currentQuestionIndex].correctAnswer {
                score += 1
                isCorrect = true
                animateCorrectAnswer.toggle()
                animateScore.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.nextQuestion()
                }
            } else {
                isCorrect = false
                alertMessage = "Doğru cevap : \(questions[currentQuestionIndex].correctAnswer) \nToplam Puan : \(score)"
                showAlert = true
                animateWrongAnswer.toggle()
                score = 0
            }
        }
        // Sonraki soruya geç
        func nextQuestion() {
            if currentQuestionIndex < questions.count - 1{
                currentQuestionIndex += 1
            } else {
                currentQuestionIndex = 0
            }

            userAnswer = "" // cevap alanını temizle
        }
    }

    extension UIApplication {
        func endEditing(_ force: Bool) {
            if let windowScene = connectedScenes.first as? UIWindowScene {
                windowScene.windows.first?.rootViewController?.view.endEditing(force)
            }
        }
    }

    func dismissKeyboard() {
          UIApplication.shared.endEditing(true) // Klavyeyi kapat
      }
