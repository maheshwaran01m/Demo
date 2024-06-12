//
//  CustomSheetView.swift
//  Demo
//
//  Created by MAHESHWARAN on 11/06/24.
//

import SwiftUI

struct CustomSheetView: View {
  
  @State private var selectedItem: Item?
  
  var body: some View {
    Text("Show Sheet")
      .onTapGesture {
        selectedItem = Item()
      }
      .sheet(item: $selectedItem) {
        Text("Height: \($0.height)")
          .padding()
          .frame(height: $0.height)
          .presentationSizing(.fitted) // adaptable based on height
        /*
         .presentationSizing(
         .page
         .fitted(horizontal: false, vertical: true)
         .sticky(horizontal: false, vertical: true)
         )
         */
      }
  }
  
  struct Item: Identifiable {
    var id: String
    
    init(id: String = UUID().uuidString) {
      self.id = id
    }
    
    var height: CGFloat {
      CGFloat((100...300).randomElement() ?? 200)
    }
  }
}

#Preview {
  CustomSheetView()
}
