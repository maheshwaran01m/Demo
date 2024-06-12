//
//  CustomTransitionView.swift
//  Demo
//
//  Created by MAHESHWARAN on 12/06/24.
//

import SwiftUI

struct CustomTransitionView: View {
  
  @Namespace private var transitionID
  
  var body: some View {
    List(Item.allItems, id: \.self) { item in
      NavigationLink {
        destinationView(for: item)
      } label: {
        mainView(for: item)
      }
    }
    .listStyle(.plain)
  }
  
  private func mainView(for item: Item) -> some View {
    HStack {
      Rectangle()
        .fill(item.color)
        .frame(width: 100, height: 100)
        .clipShape(.rect(cornerRadius: 16))
      
      VStack {
        LabeledContent(item.title) {
          Image(systemName: "\(item.icon).circle")
        }
      }
    }
    .matchedTransitionSource(id: item, in: transitionID) // Identifies source view
  }
  
  private func destinationView(for item: Item) -> some View {
    VStack {
      Rectangle()
        .fill(item.color)
        .frame(width: 300, height: 300)
        .clipShape(.rect(cornerRadius: 16))
      
      Text(item.title)
    }
    .padding()
    .navigationTransition(.zoom(sourceID: item, in: transitionID)) // Sets the navigation transition style
  }
  
  struct Item: Hashable {
    var id: String  = UUID().uuidString
    var title: String
    var icon: Int
    
    static var allItems: [Item] {
      (0..<10).map { Item(title: "Item \($0)", icon: $0) }
    }
    
    var color: Color = Color(
      red: .random(in: 0...1),
      green: .random(in: 0...1),
      blue: .random(in: 0...1)
    )
  }
}

#Preview {
  NavigationStack {
    CustomTransitionView()
  }
}
