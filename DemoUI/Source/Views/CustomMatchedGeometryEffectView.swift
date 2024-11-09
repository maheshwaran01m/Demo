//
//  CustomMatchedGeometryEffectView.swift
//  Demo
//
//  Created by MAHESHWARAN on 28/09/24.
//

import SwiftUI

struct CustomMatchedGeometryEffectView: View {
  
  @Namespace private var transitionID
  
  @State private var canMerge = false
    
  var body: some View {
    VStack(spacing: 30) {
      Text("With Animation")
        .font(.callout)
        .foregroundStyle(Color.secondary)
      
      Circle()
        .fill(.blue.opacity(0.6))
        .matchedGeometryEffect(
          id: "transitionID",
          in: transitionID,
          isSource: true)
        .frame(width: 80, height: 80)
        .onTapGesture(perform: performTapAction)
      
      Circle()
        .fill(.red.opacity(0.2))
        .matchedGeometryEffect(
          id: canMerge ? "transitionID" : "",
          in: transitionID, isSource: false)
        .frame(width: 180, height: 180)
        .onTapGesture(perform: performTapAction)
    }
  }
  
  private func performTapAction() {
    withAnimation(.spring()) {
      canMerge.toggle()
    }
  }
}

// MARK: - Preview

struct CustomMatchedGeometryEffectView_Previews: PreviewProvider {
  static var previews: some View {
    CustomMatchedGeometryEffectView()
  }
}
