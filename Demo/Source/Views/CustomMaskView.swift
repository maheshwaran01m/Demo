//
//  CustomMaskView.swift
//  Example
//
//  Created by MAHESHWARAN on 23/10/23.
//

import SwiftUI

struct CustomMaskView: View {
  
  @State private var rating: Int = 0
  @State private var progress: Int = 0

  var body: some View {
    VStack(spacing: 20) {
      starsView
        .overlay(content: maskView)
      
      progressView
        .overlay(content: maskProgessView)
    }
  }
  
  private var starsView: some View {
    HStack {
      ForEach(1..<6) { index in
        Image(systemName: "star.fill")
          .font(.largeTitle)
          .foregroundStyle(.gray)
          .onTapGesture {
            withAnimation(.easeInOut) {
              rating = (index == rating) ? 0 : index
            }
          }
      }
    }
  }
  
  private func maskView() -> some View {
    GeometryReader { proxy in
      ZStack(alignment: .leading) {
        Rectangle()
          .foregroundStyle(.yellow)
          .frame(width: CGFloat(rating) / 5 *  proxy.size.width)
      }
    }
    .mask(starsView)
    .allowsHitTesting(false)
  }
  
  private var progressView: some View {
    HStack {
      ForEach(1..<7) { index in
        Image(systemName: "circle.fill")
          .font(.title)
          .foregroundStyle(.gray)
          .onTapGesture {
            withAnimation(.easeInOut) {
              progress = index == progress ? 0 : index
            }
          }
      }
    }
  }
  
  private func maskProgessView() -> some View {
    GeometryReader { proxy in
      ZStack(alignment: .leading) {
        Rectangle()
          .foregroundStyle(.green)
          .frame(width: CGFloat(progress) / 6 *  proxy.size.width)
      }
    }
    .mask(progressView)
    .allowsHitTesting(false)
  }
}

struct CustomMaskView_Previews: PreviewProvider {
  static var previews: some View {
    CustomMaskView()
  }
}
