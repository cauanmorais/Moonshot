//
//  ContentView.swift
//  Moonshot
//
//  Created by Cauan de Jesus Nascimento de Morais on 27/10/26.

import SwiftUI

struct ContentView: View {
    private let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    private let missions: [Mission] = Bundle.main.decode("missions.json")
    @State private var isOnListMode = true
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                if isOnListMode {
                    MissionListView(missions: missions, astronauts: astronauts)
                        .id("listView")
                } else {
                    MissionGridView(columns: columns, missions: missions, astronauts: astronauts)
                        .id("gridView")
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isOnListMode.toggle()
                    } label: {
                        Image(systemName: isOnListMode ? "square.grid.2x2" : "list.bullet")
                    }
                }
            }
        }
    }
}


struct MissionGridView: View {
    let columns: [GridItem]
    let missions: [Mission]
    let astronauts: [String : Astronaut]
    
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(missions) { mission in
                NavigationLink {
                    MissionView(mission: mission, astronauts: astronauts)
                } label: {
                    VStack {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .padding()
                        
                        VStack {
                            Text(mission.displayName)
                                .font(.headline)
                                .foregroundStyle(.white)
                            Text(mission.formattedDateLaunch)
                                .font(.caption)
                                .foregroundStyle(.white.opacity(0.5))
                        }
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(.lightBackground)
                    }
                    .clipShape(.rect(cornerRadius: 10))
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.lightBackground)
                    }
                }
                .buttonStyle(.plain) // Add this!
            }
        }
        .padding([.horizontal, .bottom])
    }
}


struct MissionListView: View {
    let missions: [Mission]
    let astronauts: [String : Astronaut]
    
    var body: some View {
        LazyVStack(spacing: 10) {
            ForEach(missions) { mission in
                NavigationLink {
                    MissionView(mission: mission, astronauts: astronauts)
                } label: {
                    HStack {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .padding()
                        
                        VStack {
                            Text(mission.displayName)
                                .font(.headline)
                                .foregroundStyle(.white)
                            Text(mission.formattedDateLaunch)
                                .font(.caption)
                                .foregroundStyle(.white.opacity(0.5))
                        }
                        .padding(.vertical)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(.lightBackground)
                    }
                    .clipShape(.rect(cornerRadius: 10))
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.lightBackground)
                    }
                }
                .padding(.horizontal)
                .buttonStyle(.plain) // Add this!
            }
        }
    }
}


#Preview {
    ContentView()
}
