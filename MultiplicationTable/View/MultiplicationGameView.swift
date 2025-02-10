//
//  ContentView.swift
//  MultiplicationTable
//
//  Created by Furkan İSLAM on 9.02.2025.
//

import SwiftUI
struct MultiplicationGameView: View {
    
    @StateObject var viewModel = MultiplicationGameViewModel()
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                // Arka plandaki renk paleti
                
                LinearGradient(
                    gradient: Gradient(colors: [Color.pink, Color.purple, Color.blue, Color.green]), startPoint: .topLeading, endPoint: .bottomTrailing
                )
                .edgesIgnoringSafeArea(.all) // Bu satır, ekranın tamamını kaplar

                ScrollView {
                    VStack(spacing: 25){
                        
                        Picker("Çarpım Tablosu", selection: $viewModel.selectedNumber) {
                            ForEach(1...9, id: \.self) { number in
                                Text("\(number)'ler").tag(number)
                            }
                        }
                        .shadow(radius: 10)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.7), Color.green]), startPoint: .leading, endPoint: .trailing).cornerRadius(12)
                        )
                        .foregroundColor(.white)
                        .font(.headline)
                        .shadow(radius: 10)
                        
                        .pickerStyle(SegmentedPickerStyle())
                        .padding()
                        .onChange(of: viewModel.selectedNumber) {
                            viewModel.startGame()
                        }
                        
                        Text("Seçilen Çarpım Tablosu : \(viewModel.selectedNumber)")
                            .font(.headline)
                            .padding(.vertical)
                            .foregroundStyle(.white)
                        
                        
                        // Animasyon renk değişimi
                        
                        Text("\(viewModel.questions.isEmpty ? 0 : viewModel.questions[viewModel.currentQuestionIndex].number1) x \(viewModel.questions.isEmpty ? 0 : viewModel.questions[viewModel.currentQuestionIndex].number2) = ?")
                            .font(.title)
                            .padding()
                            .frame(width: 200, height: 200)
                            .background(viewModel.isCorrect == nil ? Color.clear : (viewModel.isCorrect! ? Color.green : Color.red))
                            .cornerRadius(30)
                            .animation(.easeInOut(duration: 0.3), value: viewModel.animateColor)
                            .foregroundStyle(.white)
                        
                        TextField("Cevabınızı Girin :", text: $viewModel.userAnswer)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            .padding()
                            .keyboardType(.numberPad)
                            .font(.headline)
                        
                        Button(action: viewModel.checkAnswer) {
                            Text("Cevabı Kontrol Et")
                                .padding()
                                .frame(maxWidth: 200)
                                .background(viewModel.buttonColor)
                                .foregroundStyle(.white)
                                .cornerRadius(20)
                                .font(.title2)
                                .shadow(radius: 5)
                        }
                        .padding()
                        
                        Text("Puan : \(viewModel.score)")
                            .font(.title2)
                            .padding()
                            .frame(width: 200, height: 50)
                            .background(RoundedRectangle(cornerRadius: 20).fill(Color.yellow))
                            .shadow(radius: 5)
                            .scaleEffect(viewModel.animateScore ? 1.2 : 1.0)
                            .animation(.spring(), value: viewModel.animateScore)
                        
                        Button(action: viewModel.startGame) {
                            Text("Yeniden Başlat")
                                .padding()
                                .background(Color.purple)
                                .foregroundStyle(.white)
                                .cornerRadius(20)
                                .shadow(radius: 20)
                                .font(.headline)
                        }
                        .padding()
                    }
                    .onAppear {
                        viewModel.startGame()
                    }
                    .padding()
                    .alert(isPresented: $viewModel.showAlert) {
                        Alert(title: Text("Yanlış Cevap !"), message: Text(viewModel.alertMessage),dismissButton: .default(Text("Tamam")))
                    }
                    
                    .onChange(of: viewModel.selectedNumber) {
                        viewModel.startGame()
                    }
                    
                }
                .onTapGesture {
                    dismissKeyboard() // Ekrana dokununca klavye kapanır
                }
            }
            
        }
        
    }
}

#Preview {
    MultiplicationGameView()
}
