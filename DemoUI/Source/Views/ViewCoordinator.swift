//
//  ViewCoordinator.swift
//  Demo
//
//  Created by MAHESHWARAN on 02/06/24.
//

import SwiftUI

enum ViewCoordinator: String, CaseIterable, View {
  case list, listBackground, mask, tab, sheet, transition, geometryChange, scrollPosition, scrollTransition, meshGradient,
       visualEffect, buttonStyle, imageSymbolEffect, matchedGeometryEffect, listMove, layoutView, phaseAnimator
  
  var title: String {
    switch self {
    case .list: return "List"
    case .listBackground: return "List Background"
    case .mask: return "Mask"
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
    case .matchedGeometryEffect: return "Matced Geometry Effect"
    case .listMove: return "List Move"
    case .layoutView: return "AnyLayout"
    case .phaseAnimator: return "Phase Animator"
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
    case .mask: CustomMaskView()
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
    case .matchedGeometryEffect: CustomMatchedGeometryEffectView()
    case .listMove: CustomMoveItemView()
    case .layoutView: CustomLayoutView()
    case .phaseAnimator: CustomPhaseAnimatorView()
    }
  }
}
