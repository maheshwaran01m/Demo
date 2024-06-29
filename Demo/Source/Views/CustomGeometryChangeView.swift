//
//  CustomGeometryChangeView.swift
//  Demo
//
//  Created by MAHESHWARAN on 29/06/24.
//

import SwiftUI

struct CustomGeometryChangeView: View {
  
  @State private var frame = CGRect.zero
  @State private var value: CGFloat = 100
  
  var body: some View {
    VStack {
      mainView
      subView
      sliderView
    }
    .padding()
  }
  
  private var mainView: some View {
    Rectangle()
      .fill(.blue.opacity(0.8))
      .frame(width: value, height: value)
      .onGeometryChange(for: CGRect.self) { $0.frame(in: .global) } action: { frame = $0 }
      .overlay(content: overlayText)
  }
  
  private var subView: some View {
    Rectangle()
      .fill(.green.opacity(0.8))
      .frame(width: frame.width, height: frame.height)
      .overlay(content: overlayText)
  }
  
  private var sliderView: some View {
    Slider(value: $value, in: 100...200)
  }
  
  private func overlayText() -> some View {
    let value = "\(frame.width.rounded().description), \(frame.height.rounded().description)"
    return Text(value)
  }
}

#Preview {
  CustomGeometryChangeView()
}
