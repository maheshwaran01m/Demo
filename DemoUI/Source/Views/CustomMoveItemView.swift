//
//  CustomMoveItemView.swift
//  Examples
//
//  Created by MAHESHWARAN on 06/08/23.
//

import SwiftUI

struct CustomMoveItemView: View {
  
  @State private var draggedItem: String?
  @State private var users = (0...20).map { String($0) }
  
  var body: some View {
    ScrollView {
      dragView
    }
  }
  
  // MARK: - List
  
  @State private var records = User.preview
  
  private var listDragView: some View {
    List($records, editActions: .move) { $record in
      Text(record.name)
    }
  }
  
  struct User: Identifiable, Equatable {
    let id: String
    let name: String
    
    init(id: String, name: String, listID: Int) {
      self.id = id
      self.name = name
    }
    
    static var preview: [User] {
      (0...10).map {
      User(id: "\($0)", name: "User \($0)", listID: $0)
      }
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
      lhs.id == rhs.id
    }
  }
  
  // MARK: - Move
  
  var listOnMoveView: some View {
    List {
      ForEach(users, id: \.self) { user in
        Text(user)
      }
      .onMove(perform: move)
    }
    .toolbar(content: EditButton.init)
  }
  
  func move(from source: IndexSet, to destination: Int) {
    users.move(fromOffsets: source, toOffset: destination)
  }
  
  // MARK: - Drag
  
  var dragView: some View {
    VStack {
      ForEach(users, id: \.self) { item in
        Text(item)
          .padding()
          .frame(maxWidth: .infinity)
          .background(Color.blue.opacity(0.15), in: .capsule)
          .contentShape(.dragPreview, .capsule)
          .onDrag({
            self.draggedItem = item
            return .init()
          }, preview: previewDragView)
          .onDrop(of: [.text],
                  delegate: DropViewDelegate(destinationItem: item, items: $users, draggedItem: $draggedItem)
          )
      }
    }
  }
  
  private func previewDragView() -> some View {
    Color.clear
      .frame(width: 1, height: 1)
  }
}

struct DropViewDelegate<T: Hashable>: DropDelegate {
  
  let destinationItem: T
  @Binding var items: [T]
  @Binding var draggedItem: T?
  
  func dropUpdated(info: DropInfo) -> DropProposal? {
    .init(operation: .move)
  }
  
  func performDrop(info: DropInfo) -> Bool {
    draggedItem = nil
    return true
  }
  
  func dropEntered(info: DropInfo) {
    guard let draggedItem,
          let fromIndex = items.firstIndex(of: draggedItem),
          let toIndex = items.firstIndex(of: destinationItem),
          fromIndex != toIndex else {
      return
    }
    withAnimation {
      items.move(
        fromOffsets: .init(integer: fromIndex),
        toOffset: toIndex > fromIndex ? toIndex+1 : toIndex)
    }
  }
}

struct CustomMoveItemView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      CustomMoveItemView()
    }
  }
}
