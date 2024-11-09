//
//  CustomTabBarView.swift
//  Demo
//
//  Created by MAHESHWARAN on 11/06/24.
//

import SwiftUI

struct CustomTabBarView: View {
  
  var body: some View {
    TabView {
      
      Tab("One", systemImage: "one") {
        Color.red.opacity(0.3)
      }
      
      Tab("Two", systemImage: "two") {
        Color.yellow.opacity(0.3)
      }
      
      Tab("Three", systemImage: "three") {
        Color.green.opacity(0.3)
      }
    }
    .tabViewStyle(.sidebarAdaptable) // To adaptable tab bar
  }
}

#Preview {
  CustomTabBarView()
}
