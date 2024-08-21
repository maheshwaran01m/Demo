//
//  CustomMeshGradientView.swift
//  Demo
//
//  Created by MAHESHWARAN on 20/08/24.
//

import SwiftUI

struct CustomMeshGradientView: View {
  
  @State private var value: Double = .zero
  
  var body: some View {
    MeshGradient(width: 3, height: 3, points: points, colors: colors)
      .overlay(alignment: .bottom, content: sliderView)
      .ignoresSafeArea()
  }
  
  private func sliderView() -> some View {
    Slider(value: $value, in: 1...5)
      .padding()
      .background(.background)
  }
  
  private var points: [SIMD2<Float>] {
    [.init(0, 0), .init(0.5, 0), .init(1, 0),
     .init(0, 0.5), .init(0.5, 0.5), .init(1, 0.5),
     .init(0, 1), .init(0.5, 1), .init(1, 1)
    ]
  }
  
  private var colors: [Color] {
    [Color.red.mix(with: Color.mint, by: value),
     .purple, .yellow,
     Color.green.mix(with: Color.teal, by: value),
     .orange, .brown, .blue, .yellow, .green,
     Color.teal.mix(with: Color.blue, by: value)
    ]
  }
}

#Preview {
  CustomMeshGradientView()
}
