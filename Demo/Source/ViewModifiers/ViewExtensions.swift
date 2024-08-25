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

// MARK: - Transition

struct Twirl: Transition {
  
  func body(content: Content, phase: TransitionPhase) -> some View {
    content
      .scaleEffect(phase.isIdentity ? 1 : 0.5)
      .opacity(phase.isIdentity ? 1 : 0)
      .blur(radius: phase.isIdentity ? 0 : 10)
      .rotationEffect(
        .degrees(
          phase == .willAppear ? 360 :
            phase == .didDisappear ? -360 : .zero
        )
      )
      .brightness(phase == .willAppear ? 1 : 0)
  }
}
