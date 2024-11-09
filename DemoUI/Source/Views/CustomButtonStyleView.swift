//
//  CustomButtonStyleView.swift
//  Demo
//
//  Created by MAHESHWARAN on 31/08/24.
//

import SwiftUI

import SwiftUI

struct CustomButtonStyleView: View {
  
  var body: some View {
    VStack(alignment: .center, spacing: 24) {
      titleView()
      
      Button("Custom Button") { }
        .buttonStyle(ShapeButtonStyle())
      
      Button("Border Button") { }
        .buttonStyle(BorderButtonStyle())
      
      Button("Gradient Button") { }
        .buttonStyle(GradientButtonStyle())
      
      Button("Border Button") { }
        .buttonStyle(GradientBorderButtonStyle())
      
      Button("Dynamic Button") { }
        .buttonStyle(DynamicButtonStyle())
    }
  }
  
  private func titleView(for value: String = "Custom Buttons") -> some View {
    Text(value)
      .font(.caption)
      .foregroundStyle(Color.gray)
  }
  
  // MARK: - ShapeButtonStyle
  
  struct ShapeButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
      configuration.label
        .foregroundStyle(.link)
        .padding(8)
        .background(color(using: configuration.isPressed),
                    in: .rect(cornerRadius: 16))
    }
    
    func color(using isPressed: Bool) -> Color {
      isPressed ? Color.green.opacity(0.3) : .gray.opacity(0.3)
    }
  }
  
  // MARK: - BorderButtonStyle
  
  struct BorderButtonStyle<S: Shape>: ButtonStyle {
    
    private let shape: S
    
    init(_ shape: S = RoundedRectangle(cornerRadius: 16)) {
      self.shape = shape
    }
    
    func makeBody(configuration: Configuration) -> some View {
      configuration.label
        .foregroundStyle(.red)
        .padding(8)
        .background(color(using: configuration.isPressed),
                    in: shape)
        .border(shape, width: configuration.isPressed ? 2 : 1, color: .black)
    }
    
    func color(using isPressed: Bool) -> Color {
      isPressed ? .gray.opacity(0.1) : .clear
    }
  }
  
  // MARK: - Gradient ButtonStyle
  
  struct GradientButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
      configuration.label
        .foregroundStyle(.primary.opacity(0.7))
        .padding(8)
        .background(content: linearGradientView)
        .clipShape(.rect(cornerRadius: 16))
        .isEnabled(configuration.isPressed) {
          $0.overlay(RoundedRectangle(cornerRadius: 16).stroke(.black, lineWidth: 1))
        }
    }
    
    func linearGradientView() -> some View {
      LinearGradient(
        colors: [.blue.opacity(0.6), .red.opacity(0.3), .orange.opacity(0.8)],
        startPoint: .topLeading, endPoint: .bottomTrailing)
    }
  }
  
  // MARK: - Gradient Border ButtonStyle
  
  struct GradientBorderButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
      configuration.label
        .foregroundStyle(.link)
        .padding(8)
        .clipShape(.rect(cornerRadius: 16))
        .overlay {
          RoundedRectangle(cornerRadius: 16)
            .stroke(linearGradientView.opacity(configuration.isPressed ? 0.5 : 1), lineWidth: 3)
        }
    }
    
    private func color(using isPressed: Bool) -> Color {
      isPressed ? .gray.opacity(0.1) : .clear
    }
    
    private var linearGradientView: some ShapeStyle {
      LinearGradient(
        colors: [.blue, .red, .orange, .green],
        startPoint: .topLeading, endPoint: .bottomTrailing)
    }
  }
  
  // MARK: - Dynamic ButtonStyle
  
  struct DynamicButtonStyle: ButtonStyle {
    
    @State private var isRunning = false
    
    func makeBody(configuration: Configuration) -> some View {
      configuration.label
        .foregroundStyle(.link)
        .padding(8)
        .background(color(using: configuration.isPressed))
        .border(.rect(cornerRadius: 16), color: .gray.opacity(0.6))
        .overlay {
          RoundedRectangle(cornerRadius: 16)
            .strokeBorder(style: strokeStyle)
            .foregroundStyle(linearGradientView)
        }
        .onAppear { isRunning.toggle() }
        .animation(.easeOut.speed(0.1).repeatForever(autoreverses: false), value: isRunning)
    }
    
    private func color(using isPressed: Bool) -> Color {
      isPressed ? .gray.opacity(0.1) : .clear
    }
    
    private var strokeStyle: StrokeStyle {
      .init(
        lineWidth: 3,
        lineCap: .round,
        lineJoin: .round,
        dash: [-32, 320],
        dashPhase: isRunning ? 200 : -120
      )
    }
    
    private var linearGradientView: some ShapeStyle {
      LinearGradient(
        colors: [.blue, .red, .orange, .green],
        startPoint: .topLeading, endPoint: .bottomTrailing)
    }
  }
}

#Preview {
  CustomButtonStyleView()
}
