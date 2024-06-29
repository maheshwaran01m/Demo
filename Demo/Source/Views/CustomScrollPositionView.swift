//
//  CustomScrollPositionView.swift
//  Demo
//
//  Created by MAHESHWARAN on 29/06/24.
//

import SwiftUI

struct CustomScrollPositionView: View {
  
  @State private var position = ScrollPosition(edge: .top)
  
  var body: some View {
    ScrollView {
      ForEach(0..<100) { i in
        Text("Item \(i)")
          .padding()
          .frame(maxWidth: .infinity, alignment: .leading)
          .background(Color.blue.opacity(0.2), in: .capsule)
          .id(i)
      }
    }
    .padding(.horizontal, 8)
    .scrollPosition($position)
    .safeAreaInset(edge: .bottom, content: bottomView)
  }
  
  private func bottomView() -> some View {
    HStack {
      Button("Top") { position.scrollTo(edge: .top) }
      Button("Bottom") { position.scrollTo(edge: .bottom) }
      Button("Random") { position.scrollTo(id: Int.random(in: 0..<100)) }
    }
    .buttonStyle(.borderedProminent)
    .padding(5)
    .frame(maxWidth: .infinity)
    .background(Color.gray.opacity(0.6))
  }
}

#Preview {
  CustomScrollPositionView()
}
