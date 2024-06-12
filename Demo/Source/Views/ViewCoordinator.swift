//
//  ViewCoordinator.swift
//  Demo
//
//  Created by MAHESHWARAN on 02/06/24.
//

import SwiftUI

enum ViewCoordinator: String, CaseIterable, View {
  case list, tab, sheet
  
  var title: String {
    switch self {
    case .list: return "List"
    case .tab: return "Tab"
    case .sheet: return "Sheet"
    }
  }
  
  var body: some View {
    destinationView
  }
  
  @ViewBuilder
  private var destinationView: some View {
    switch self {
    case .list: CustomListView()
    case .tab: CustomTabBarView()
    case .sheet: CustomSheetView()
    }
  }
}
