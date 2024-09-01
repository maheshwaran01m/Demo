//
//  ContentView.swift
//  Demo
//
//  Created by MAHESHWARAN on 02/06/24.
//

import SwiftUI

struct ContentView: View {
  
  @State private var viewCoordinator = ViewCoordinator.allCases
  
  @State private var searchText = ""
  
  private var filterViews: [ViewCoordinator] {
    guard !searchText.isEmpty else { return viewCoordinator }
    let searchText = searchText.trimmingCharacters(in: .whitespaces)
    return viewCoordinator.filter { $0.title.lowercased().localizedCaseInsensitiveContains(searchText)
    }
  }
  
  var body: some View {
    NavigationStack {
      mainView
        .navigationTitle("Home")
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
    }
  }
  
  @ViewBuilder
  private var mainView: some View {
    if !filterViews.isEmpty {
      listView
    } else {
      ContentUnavailableView.search(text: searchText)
    }
  }
  
  private var listView: some View {
    List(filterViews, id: \.self) {
      listRowView(for: $0)
    }
    .listStyle(.plain)
  }
  
  private func listRowView(for item: ViewCoordinator) -> some View {
    NavigationLink(item.title, destination: item)
      .listRowSeparator(.hidden)
      .padding(.horizontal, 8)
      .listRowBackground(
        Color.secondary.opacity(0.1)
          .clipShape(.rect(cornerRadius: 16))
          .padding(4)
      )
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
