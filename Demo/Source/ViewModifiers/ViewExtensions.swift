//
//  ViewExtensions.swift
//  Demo
//
//  Created by MAHESHWARAN on 02/06/24.
//

import SwiftUI

extension View {
  
  @ViewBuilder
  func isEnabled<Content: View>(_ show: Bool = true, @ViewBuilder content: (Self) -> Content) -> some View {
    if show {
      content(self)
    } else {
      self
    }
  }
  
  func border(_ shape: some Shape, width: CGFloat = 1, color: Color = .clear, isEnabled: Bool = true) -> some View {
    self
      .clipShape(shape)
      .isEnabled(isEnabled) {
        $0.overlay(shape.stroke(color, lineWidth: width))
      }
  }
}

// MARK: - ShapeStyle

extension ShapeStyle where Self == Color {
  
  static var randomColor: Self {
    Color(
      red: .random(in: 0...1),
      green: .random(in: 0...1),
      blue: .random(in: 0...1)
    )
  }
}
