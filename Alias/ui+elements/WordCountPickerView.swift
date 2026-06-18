//
//  WordCountPickerView.swift
//  Alias
//
//  Created by lilit on 14.06.26.
//
import SwiftUI

// MARK: - Word Count Picker
struct WordCountPickerView: View {
    @Binding var wordCount: Int
    
    private let minWords = 1
    private let maxWords = 100
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Word Count")
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
                Text("\(wordCount)")
                    .font(.headline)
                    .foregroundStyle(.pink)
            }
            
            Slider(
                value: Binding(
                    get: { Double(wordCount) },
                    set: { wordCount = Int($0) }
                ),
                in: Double(minWords)...Double(maxWords),
                step: 1
            )
            .tint(.pink)
            .accessibilityLabel("Word count slider")
            .accessibilityValue("\(wordCount) words")
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(Color.black.opacity(0.5)))
    }
}

#Preview {
    @Previewable @State var wordCount: Int = 25
    WordCountPickerView(wordCount: $wordCount)
}
