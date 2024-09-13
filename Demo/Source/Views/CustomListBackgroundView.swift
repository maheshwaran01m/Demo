//
//  CustomListBackgroundView.swift
//  Demo
//
//  Created by MAHESHWARAN on 13/09/24.
//

import SwiftUI

struct CustomListBackgroundView: View {
  
  var body: some View {
    List(0..<10, id: \.self) { index in
      Text("Row \(index)")
    }
    .scrollContentBackground(.hidden) // Hides the standard system background
    .background(linearGradientView)
  }
  
  private var linearGradientView: some ShapeStyle {
    LinearGradient(
      colors: [.blue, .purple, .mint],
      startPoint: .topLeading,
      endPoint: .bottomTrailing)
  }
}

#Preview {
  CustomListBackgroundView()
}
