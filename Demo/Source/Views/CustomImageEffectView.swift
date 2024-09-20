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
    VStack(spacing: 20) {
      
      Image(systemName: "waveform")
        .symbolEffect(.variableColor)
        
      Image(systemName: "heart")
        .symbolEffect(.breathe)
      
      Image(systemName: "star")
        .symbolVariant(.circle)
        .symbolEffect(.pulse)
      
      Image(systemName: "fan.desk")
        .symbolEffect(.rotate)
      
      Image(systemName: "paperplane")
        .symbolEffect(.wiggle)
      
      Image(systemName: "leaf.arrow.circlepath")
        .symbolEffect(.rotate)
        .symbolEffect(.pulse)
      
      Image(systemName: "person")
        .symbolVariant(canReplacePerson ? .fill : .none)
        .symbolEffect(.pulse)
        .contentTransition(.symbolEffect(.replace))
        .onTapGesture { canReplacePerson.toggle() }
      
      Image(systemName: "heart")
        .symbolVariant(canReplaceHeart ? .fill : .none)
        .symbolEffect(.breathe)
        .contentTransition(.symbolEffect(.replace))
        .onTapGesture { canReplaceHeart.toggle() }
    }
    .font(.largeTitle)
  }
}

struct CustomImageEffectView_Previews: PreviewProvider {
  static var previews: some View {
    CustomImageEffectView()
  }
}
