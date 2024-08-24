//
//  CustomScrollTransitionView.swift
//  Demo
//
//  Created by MAHESHWARAN on 23/08/24.
//

import SwiftUI

struct CustomScrollTransitionView: View {
  
  var body: some View {
    ScrollView(.horizontal) {
      LazyHStack(spacing: 22) {
        mainView
      }
      .scrollTargetLayout()
    }
    .contentMargins(.horizontal, 44)
    .scrollTargetBehavior(.paging)
  }
  
  private var mainView: some View {
    ForEach(0..<4, id: \.self) { index in
      imageView(for: index)
        .scrollTransition(axis: .horizontal) { content, phase in
          content
            .offset(x: phase.isIdentity ? 0 : phase.value * -250)
        }
        .containerRelativeFrame(.horizontal)
        .clipShape(.rect(cornerRadius: 16))
    }
  }
  
  private func imageView(for index: Int) -> some View {
    Image("photo-\(index)")
      .resizable()
      .scaledToFill()
      .frame(width: 500, height: 500)
      .clipShape(.rect(cornerRadius: 16))
  }
}

#Preview {
  CustomScrollTransitionView()
}
