//
//  CustomPhaseAnimatorView.swift
//  DemoUI
//
//  Created by MAHESHWARAN on 24/11/24.
//

import SwiftUI

struct CustomPhaseAnimatorView: View {
  
  private let lights: [TrafficLight] = [.red, .yellow, .green, .red]
  private let progess: [Progress] = Progress.allCases + [.v0]
  
  var body: some View {
    VStack(spacing: 30) {
      headerTitleView(for: "Traffic Light")
      
      trafficLightView
      
      Divider()
      headerTitleView(for: "Progress Bar")
      
      progressView
    }
  }
  
  func headerTitleView(for text: String) -> some View {
    Text(text)
      .font(.body)
      .foregroundStyle(.secondary)
  }
}

// MARK: - Traffic Light

extension CustomPhaseAnimatorView {
  
  private var trafficLightView: some View {
    PhaseAnimator(
      lights,
      content: trafficLightContentView,
      animation: { $0.animation }
    )
  }
  
  private func trafficLightContentView(for phase: TrafficLight) -> some View {
    VStack {
      ForEach(TrafficLight.allCases, id: \.self) { light in
        Circle()
          .fill(phase == light ? phase.color : .black.opacity(0.3))
          .frame(width: 40, height: 40)
      }
    }
    .padding()
    .background(.gray.opacity(0.3), in: .rect(cornerRadius: 12.0))
  }
  
  
  enum TrafficLight: Int, CaseIterable {
    case red = 0, yellow, green
    
    var color: Color {
      switch self {
      case .red: .red
      case .yellow: .yellow
      case .green: .green
      }
    }
    
    var animation: Animation {
      switch self {
      case .red: return .linear(duration: 0.2).delay(0.2)
      case .yellow: return .linear(duration: 0.2).delay(2.0)
      case .green: return .linear(duration: 0.2).delay(0.2)
      }
    }
  }
}

// MARK: - Progress Bar

extension CustomPhaseAnimatorView {
  
  private var progressView: some View {
    PhaseAnimator(
      progess,
      content: progessContentView,
      animation: { $0.animation }
    )
  }
  
  private func progessContentView(for phase: Progress) -> some View {
    VStack {
      GeometryReader { proxy in
        ZStack(alignment: .leading) {
          RoundedRectangle(cornerRadius: 16)
            .fill(.gray.opacity(0.5))
          
          RoundedRectangle(cornerRadius: 16)
            .fill(phase.color)
            .frame(width: phase.width(for: proxy))
        }
      }
      .frame(height: 10)
      .padding(.horizontal)
      
      Text(phase.progessText)
        .font(.body)
        .monospaced()
        .foregroundStyle(.secondary)
    }
  }
  
  enum Progress: Double, CaseIterable {
    
    case v0 = 0, v20 = 20, v40 = 40, v60 = 60, v80 = 80, v100 = 100
    
    var color: Color {
      switch self {
      case .v80: .green.opacity(0.6)
      case .v100: .green
      default: .blue
      }
    }
    
    var animation: Animation {
      switch self {
      case .v0: return .linear(duration: 0.2).delay(0.2)
      case .v100: return .linear(duration: 0.2).delay(0.2)
      default: return .linear(duration: 0.2).delay(2.0)
      }
    }
    
    var progessText: String {
      let value = self == .v100 ? "Downloaded" : "Downloading"
      
      return value + " " + rawValue.description
    }
    
    func width(for proxy: GeometryProxy) -> CGFloat {
      let value = max(rawValue, Self.v0.rawValue) / Self.v100.rawValue
      
      return CGFloat(value) * proxy.size.width
    }
  }
}

// MARK: - Preview

#Preview {
  CustomPhaseAnimatorView()
}
