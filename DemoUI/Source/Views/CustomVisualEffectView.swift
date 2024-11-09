//
//  CustomVisualEffectView.swift
//  Demo
//
//  Created by MAHESHWARAN on 24/08/24.
//
import SwiftUI

struct CustomVisualEffectView: View {
  
  var body: some View {
    ScrollView {
      VStack(spacing: 16) {
        ForEach(0..<30, id: \.self) { index in
          RoundedRectangle(cornerRadius: 24)
            .fill(.green)
            .frame(height: 100)
            .overlay { Text("\(index)") }
            .visualEffect { visualEffectView($0, $1) }
          
        }
      }
    }
    .background(Color.primary)
  }
  
  nonisolated
  func visualEffectView(_ content: EmptyVisualEffect,
                        _ proxy: GeometryProxy) ->  some VisualEffect {
    return content
      .hueRotation(.degrees(proxy.frame(in: .global).origin.y / 10))
  }
  
  nonisolated
  func visualEffectScaleView(_ content: EmptyVisualEffect,
                             _ proxy: GeometryProxy) ->  some VisualEffect {
    
    let frame = proxy.frame(in: .scrollView(axis: .vertical))
    let distance = min(0, frame.minY)
    
    return content
      .hueRotation(.degrees(frame.origin.y / 10))
      .scaleEffect(1 + distance / 500)
      .offset(y: -distance / 1.25)
      .brightness(-distance / 400)
      .blur(radius: -distance / 50)
  }
}

#Preview {
  CustomVisualEffectView()
}
