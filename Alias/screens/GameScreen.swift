//
//  GameScreen.swift
//  Alias
//
//  Created by lilit on 18.01.26.
//

import SwiftUI
#Preview {
    GameScreen()
}
struct GameScreen: View {
    @State private var progress: Float = 20
    @State private var time: String = "00:00"
    var body: some View {
        
        VStack(spacing: 80){
            ProgressView(value: progress, total: 100) {
                Text("Time left..")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                Text(time)
                    .frame(maxWidth: .infinity, alignment: .trailing).font(Font.largeTitle.bold())
            } currentValueLabel: {
                Text("Current progress: \(Int(progress))%")
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            
            GuessWordView(text: "SpaceX")
            HStack{
                MyButton(
                    text:"Skip",
                    icon: "xmark.circle.fill",
                    bgColor: .red,
                    onTap: {print("Hello")
                    })
                MyButton(
                    text:"Correct",
                    icon: "checkmark.circle.fill",
                    bgColor: .green,
                    onTap: {print("Hello")
                    })
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


