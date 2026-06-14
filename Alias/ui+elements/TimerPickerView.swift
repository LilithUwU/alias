//
//  TimerPickerView.swift
//  Alias
//
//  Created by lilit on 14.06.26.
//
import SwiftUI

struct TimerPickerView: View {
    @Binding var selectedTime: Int
    
    private let timeOptions = [30, 60, 120]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Turn Duration")
                .font(.headline)
                .foregroundColor(.white)
            
            Picker("Turn Duration", selection: $selectedTime) {
                ForEach(timeOptions, id: \.self) { seconds in
                    Text("\(seconds)s").tag(seconds)
                }
            }
            .pickerStyle(.segmented)
            .tint(.pink)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(Color.black.opacity(0.5)))
    }
}
