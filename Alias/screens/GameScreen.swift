//
//  GameScreen.swift
//  Alias
//
//  Created by lilit on 18.01.26.
//

import SwiftUI
import Combine

#Preview {
    GameScreen()
}

struct GameScreen: View {
    @Environment(MainViewModel.self) private var viewModel
    @State private var list : [String] = []
    private let totalTime: Int = 5
    @State private var timeElapsed: Int = 5
    @State private var skippedCount = 0
    @State private var correctCount = 0
    @State private var timeOut: Bool = false
    @State private var textScale: CGFloat = 0.5
    @State private var navigateToGameOver = false
    @State private var teamName: String = "Antonio Banderas"
    
    var progress: Double {
        return max(0, min(1, Double(totalTime - timeElapsed) / Double(totalTime))) * 100
    }
    
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                GridBackground()
                
                VStack(spacing: 40) {
                    VStack(alignment: .trailing, spacing: 8) {
                        Text("Time left")
                            .foregroundColor(.white.opacity(0.7))
                            .font(.subheadline)
                        Text("\(timeElapsed) s")
                            .font(.system(size: 48, weight: .bold, design: .rounded))
                            .foregroundStyle(timeElapsed == 0 ? .red : .primary)
                            .onReceive(timer) { _ in
                                if timeElapsed > 0 {
                                    timeElapsed -= 1
                                } else {
                                    timer.upstream.connect().cancel()
                                    timeOut = true
                                }
                                
                            }
                        
                        ProgressView(value: progress, total: 100)
                            .tint(.cyan)
                            .scaleEffect(y: 2)
                        
                        Text("\(Int(progress))%")
                            .foregroundColor(.white.opacity(0.7))
                            .font(.caption)
                    }
                    .padding()
                    .background(Color.white.opacity(0.05))
                    .cornerRadius(15)
                    
                    
                    List(list, id: \.self) { item in
                        Text(item)
                            .lineLimit(1)
                            .opacity(item == list.first ? 0.0 : 0.5)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                            .listRowInsets(EdgeInsets())
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                            .foregroundColor(Color.white.opacity(0.5))
                            .onTapGesture {
                                guard timeElapsed > 0, !list.isEmpty else { return }
                                if let index = list.firstIndex(of: item) {
                                       list.remove(at: index)
                                       correctCount += 1
                                }
                            }
                    }
                    .listStyle(.plain)
                    
                    Text(list.first ?? "")
                        .foregroundColor(Color.orange)
                        .font(.system(size: 60, weight: .bold))
                    
                    
                    Spacer()
                    
                    HStack(spacing: 20) {
                        ControlButton(
                            text: "Skip (\(skippedCount))",
                            icon: "xmark.circle.fill",
                            bgColor: .red,
                            onTap: {
                                print("Skip")
                                guard timeElapsed > 0, !list.isEmpty else { return }
                                list.removeFirst()
                                skippedCount += 1
                            }
                        )
                        
                        ControlButton(
                            text: "Correct (\(correctCount))",
                            icon: "checkmark.circle.fill",
                            bgColor: .green,
                            onTap: {
                                print("Correct")
                                guard timeElapsed > 0, !list.isEmpty else { return }
                                list.removeFirst()
                                correctCount += 1
                            }
                        )
                    }
                }
                .padding(20)
                
                if timeOut {
                    Color.black.opacity(0.6)
                        .ignoresSafeArea()
                    Text("Time out!")
                        .font(.system(size: 80, weight: .bold))
                        .foregroundColor(Color.red)
                        .scaleEffect(textScale)
                        .onAppear {
                            withAnimation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0)) {
                                textScale = 1.0
                            }
                            Task { @MainActor in
                                try? await Task.sleep(for: .seconds(3))
                                navigateToGameOver = true
                            }
                        }
                }
            }
        }
        .navigationDestination(isPresented: $navigateToGameOver) {
            GameOverScreen(
                correctCount: correctCount,
                skippedCount: skippedCount,
                teamName: teamName
            )
        }
        .navigationTitle(teamName)
        .onAppear {
             list = viewModel.currentWords
        }
    }
}

