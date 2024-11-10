//
//  CustomLayoutView.swift
//  DemoUI
//
//  Created by MAHESHWARAN on 10/11/24.
//

import SwiftUI

struct CustomLayoutView: View {
  
  @State private var layoutType = LayoutType.zStack
  
  var body: some View {
    AnyLayout(layoutType.layout) {
      contentView
    }
    .toolbar(content: changeLayoutButton)
  }
  
  private var contentView: some View {
    ForEach(ColorView.allColors, id: \.color) { view in
      view.color
        .frame(width: view.width, height: view.height)
    }
  }
  
  @ToolbarContentBuilder
  private func changeLayoutButton() -> some ToolbarContent {
    ToolbarItem(placement: .navigationBarTrailing) {
      
      Button(action: changeLayoutButtonAction) {
        Image(systemName: "circle.grid.3x3.circle")
          .imageScale(.large)
      }
    }
  }
  
  private func changeLayoutButtonAction() {
    withAnimation {
      let index = layoutType.index < LayoutType.allCases.count - 1 ?
      layoutType.index + 1 : 0
      
      layoutType = LayoutType.allCases[index]
    }
  }
}

// MARK: - LayoutType

extension CustomLayoutView {
  
  enum LayoutType: Int, CaseIterable {
    case zStack, hStack, hStackTop, hStackBottom,
         vStack, vStackLeading, vStackTrailing
    
    var index: Int {
      LayoutType.allCases.firstIndex(where: { $0 == self }) ?? 0
    }
    
    var layout: any Layout {
      switch self {
      case .zStack: return ZStackLayout()
      case .hStack: return HStackLayout()
      case .hStackTop: return HStackLayout(alignment: .top, spacing: 5)
      case .hStackBottom: return HStackLayout(alignment: .bottom, spacing: 5)
      case .vStack: return VStackLayout()
      case .vStackLeading: return VStackLayout(alignment: .leading, spacing: 5)
      case .vStackTrailing: return VStackLayout(alignment: .trailing, spacing: 5)
      }
    }
  }
}

// MARK: - ColorView

extension CustomLayoutView {
  
  struct ColorView {
    var color: Color
    var width: CGFloat
    var height: CGFloat
    
    static var allColors: [ColorView] {
      [.init(color: .red, width: 60, height: 75),
       .init(color: .teal, width: 100, height: 100),
       .init(color: .purple, width: 40, height: 80),
       .init(color: .indigo, width: 120, height: 100)]
    }
  }
}

// MARK: - Preview

#Preview {
  NavigationStack {
    CustomLayoutView()
  }
}
