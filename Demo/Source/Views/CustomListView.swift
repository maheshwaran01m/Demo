//
//  CustomListView.swift
//  Demo
//
//  Created by MAHESHWARAN on 02/06/24.
//

import SwiftUI

struct CustomListView: View {
  
  @State private var records: [Player]
  
  @State private var selectedPlayer: Player?
  
  @State private var alertMessage: String?
  
  init() {
    _records = .init(initialValue: Player.preview)
  }
  
  var body: some View {
    mainView
      .navigationBarTitleDisplayMode(.inline)
  }
}

// MARK: - List

extension CustomListView {
  
  @ViewBuilder
  private var mainView: some View {
    if !records.isEmpty {
      listView
    } else {
      placeholderView
    }
  }
  
  private var listView: some View {
    List($records, id: \.self) { record in
      detailView(record)
    }
    .listStyle(.plain)
    .navigationDestination(isPresented: bindingPlayer, destination: playerDetailView)
    .alert("Alert", isPresented: bindingAlert, actions: {}, message: alertMessageView)
  }
  
  private func detailView(_ record: Binding<Player>) -> some View {
    HStack(alignment: .top, spacing: 8) {
      checkMarkView(record)
      
      VStack(alignment: .leading, spacing: 8) {
        Text(record.wrappedValue.title)
          .font(.headline)
        
        Text(record.wrappedValue.team.rawValue)
          .font(.subheadline)
      }
      .padding(.bottom, 4)
    }
    .onTapGesture { addNew(record) }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding([.top, .horizontal], 8)
    .contentShape(.rect)
    .listRowSeparator(.hidden)
    .listRowInsets(.init(top: 6, leading: 8, bottom: 6, trailing: 8))
    .background(record.wrappedValue.backgroundColor, in: .rect(cornerRadius: 16))
    .border(.rect(cornerRadius: 16), color: record.wrappedValue.borderColor)
    .onTapGesture { selectedPlayer = record.wrappedValue }
  }
  
  private func checkMarkView(_ player: Binding<Player>) -> some View {
    Image(systemName: player.wrappedValue.imageName)
      .font(.headline)
  }
  
  // MARK: - Placeholder
  
  private var placeholderView: some View {
    Text("No Records")
      .font(.subheadline)
      .foregroundStyle(.secondary)
  }
}

// MARK: - Detail

extension CustomListView {
  
  private var bindingPlayer: Binding<Bool> {
    .init(get: { selectedPlayer != nil }, set: { if !$0 { selectedPlayer = nil }})
  }
  
  @ViewBuilder
  private func playerDetailView() -> some View {
    if let selectedPlayer {
      VStack(alignment: .leading, spacing: 8) {
        Text(selectedPlayer.title)
          .font(.headline)
        
        Text(selectedPlayer.team.rawValue)
          .font(.subheadline)
      }
    }
  }
}

// MARK: - Add Player

extension CustomListView {
  
  private func addNew(_ player: Binding<Player>) {
    if !player.wrappedValue.isSelected {
      
      let teamA = filteredRecords(for: .teamA)
      let teamB = filteredRecords(for: .teamB)
      
      switch player.wrappedValue.team {
      case .teamA:
        if !teamA.isEmpty {
          
          let maxPlayer = teamB.count < 6 ? teamA.count < 6 : teamA.count < 5
          if maxPlayer {
            updateSelection(for: player)
          } else {
            alertMessage = "Maximum player reached for teamA"
          }
          
        } else {
          updateSelection(for: player)
        }
        
      case .teamB:
        if !teamB.isEmpty {
          
          let maxPlayer = teamA.count < 6 ? teamB.count < 6 : teamB.count < 5
          if maxPlayer {
            updateSelection(for: player)
          } else {
            alertMessage = "Maximum player reached for teamB"
          }
          
        } else {
          updateSelection(for: player)
        }
      }
      
    } else {
      updateSelection(for: player)
    }
  }
  
  private func filteredRecords(for team: Player.Team) -> [Player] {
    records.filter { $0.team == team && $0.isSelected }
  }
  
  private func updateSelection(for player: Binding<Player>) {
    player.wrappedValue.isSelected.toggle()
  }
  
  // MARK: - Alert
  
  private var bindingAlert: Binding<Bool> {
    .init(get: { alertMessage != nil }, set: { if !$0 { alertMessage = nil }})
  }
  
  @ViewBuilder
  private func alertMessageView() -> some View {
    if let alertMessage {
      Text(alertMessage)
    }
  }
}

// MARK: - Player

extension CustomListView {
  
  struct Player: Hashable {
    var name: String
    var team: Team
    var isSelected = false
    var isCaptain = false
    
    enum Team: String {
      case teamA, teamB
    }
    
    var imageName: String {
      isSelected ? "checkmark.circle.fill" : "checkmark.circle"
    }
    
    var backgroundColor: Color {
      isSelected ? Color.blue.opacity(0.3) : .clear
    }
    
    var borderColor: Color {
      isSelected ? backgroundColor : .secondary
    }
    
    static var preview: [Player] {
      let teamA = (0...11).map {
        Player(name: "Name \($0)", team: .teamA,
               isSelected: false, isCaptain: $0 == 0)
      }
      
      let teamB = (0...11).map {
        Player(name: "Name \($0)", team: .teamB,
               isSelected: false, isCaptain: $0 == 0)
      }
      return teamA + teamB
    }
    
    var title: String {
      isCaptain ? "\(name) (C)" : name
    }
  }
}

// MARK: - Preview

#Preview {
  CustomListView()
}
