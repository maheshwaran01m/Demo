//
//  ViewCoordinator.swift
//  Demo
//
//  Created by MAHESHWARAN on 02/06/24.
//

import SwiftUI

enum ViewCoordinator: String, CaseIterable, View {
  case list, listBackground, tab, sheet, transition, geometryChange, scrollPosition, scrollTransition, meshGradient,
       visualEffect, buttonStyle, imageSymbolEffect
  
  var title: String {
    switch self {
    case .list: return "List"
    case .listBackground: return "List Background"
    case .tab: return "Tab"
    case .sheet: return "Sheet"
    case .transition: return "Transition"
    case .geometryChange: return "Geometry Change"
    case .scrollPosition: return "Scroll Position"
    case .scrollTransition: return "Scroll Transition"
    case .meshGradient: return "Mesh Gradient"
    case .visualEffect: return "Visual Effect"
    case .buttonStyle: return "Button Style"
    case .imageSymbolEffect: return "Image Symbol Effect"
    }
  }
  
  var body: some View {
    destinationView
  }
  
  @ViewBuilder
  private var destinationView: some View {
    switch self {
    case .list: CustomListView()
    case .listBackground: CustomListBackgroundView()
    case .tab: CustomTabBarView()
    case .sheet: CustomSheetView()
    case .transition: CustomTransitionView()
    case .geometryChange: CustomGeometryChangeView()
    case .scrollPosition: CustomScrollPositionView()
    case .scrollTransition: CustomScrollTransitionView()
    case .meshGradient: CustomMeshGradientView()
    case .visualEffect: CustomVisualEffectView()
    case .buttonStyle: CustomButtonStyleView()
    case .imageSymbolEffect: CustomImageEffectView()
    }
  }
}
