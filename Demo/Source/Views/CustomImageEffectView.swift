//
//  CustomImageEffectView.swift
//  Demo
//
//  Created by MAHESHWARAN on 20/09/24.
//

import SwiftUI

struct CustomImageEffectView: View {
  
  @State private var canReplacePerson = false
  @State private var canReplaceHeart = false
  
  var body: some View {
    VStack(alignment: .leading, spacing: 20) {
      
      imageDetailView(
        for: "waveform",
        effect: .variableColor,
        title: "Variable Color")
      
      imageDetailView(
        for: "heart",
        effect: .breathe,
        title: "Breathe")
      
      imageDetailView(
        for: "star",
        effect: .pulse,
        title: "Pulse")
      .symbolVariant(.circle)
      
      imageDetailView(
        for: "fan.desk",
        effect: .rotate,
        title: "Rotate")
      
      imageDetailView(
        for: "paperplane",
        effect: .wiggle,
        title: "Wiggle")
      
      imageDetailView(
        for: "leaf.arrow.circlepath",
        effect: .rotate,
        title: "Rotate + Pulse")
      .symbolEffect(.pulse)
      
      imageDetailView(
        for: "person",
        effect: .pulse,
        title: "Pulse + Replace")
      .symbolVariant(canReplacePerson ? .fill : .none)
      .contentTransition(.symbolEffect(.replace))
      .onTapGesture { canReplacePerson.toggle() }
      
      imageDetailView(
        for: "heart",
        effect: .breathe,
        title: "Breathe + Replace")
      .symbolVariant(canReplaceHeart ? .fill : .none)
      .contentTransition(.symbolEffect(.replace))
      .onTapGesture { canReplaceHeart.toggle() }
    }
    .font(.largeTitle)
  }
}

extension CustomImageEffectView {
  
  private func imageDetailView<T: SymbolEffect & IndefiniteSymbolEffect>(
    for imageName: String,
    effect: T,
    title: String) -> some View {
      
      HStack {
        Image(systemName: imageName)
          .symbolEffect(effect)
        
        Text(title)
          .font(.caption)
          .foregroundStyle(.secondary)
      }
    }
}

struct CustomImageEffectView_Previews: PreviewProvider {
  static var previews: some View {
    CustomImageEffectView()
  }
}
