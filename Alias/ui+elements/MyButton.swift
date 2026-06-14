//
//  UIEmements.swift
//  Alias
//
//  Created by lilit on 15.01.26.
//
import SwiftUI

#Preview {
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


struct MyButton: View {
    var text: String
    var icon: String
    var bgColor: Color
    var onTap: () -> Void
    var body: some View {
        
        Button(action: {
            onTap()
        }) {
            VStack(spacing: 8) { 
                Image(systemName: icon)
                    .font(.largeTitle)
                Text(text).fontWeight(.bold)
                    .font(Font.title3)
            }
        }
        .frame(width: 180, height: 100)
        .background(bgColor)
        .foregroundColor(.white)
        .border(Color.black, width: 3)
    }
}
