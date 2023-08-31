//
//  ContentView.swift
//  Palace
//
//  Created by Kuba Milcarz on 8/1/23.
//

import SwiftUI
//import SwiftData

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @State private var activeNav: NavigationTabBar = .pi
    @State private var isShowingSettings = false
    
    var body: some View {
        #if os(visionOS) || os(macOS)
        NavigationSplitView {
            content
            #if os(macOS)
                .frame(minWidth: 200)
            #endif
        } detail: {
            switch activeNav {
            case .pi:
                PiPalaceView()
            case .cards:
                Text("Cards")
            case .scoreboard:
                ScoreboardView()
            case .achievements:
                Text("Achievements")
            case .settings:
                SettingsView()
            }
        }
        #else
        NavigationStack {
           content
        }
        #endif
    }
    
    var content: some View {
        ScrollView {
            VStack(spacing: 30) {
                ZStack(alignment: .bottom) {
                    #if os(iOS)
                    Image(.castle)
                        .resizable()
                        .scaledToFill()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .clipped()
                        .ignoresSafeArea()
                    LinearGradient(colors: [.black.opacity(0.5), .black.opacity(0.1)], startPoint: .top, endPoint: .bottom)
                    
                    LinearGradient(colors: [.clear, colorScheme == .dark ? .black : .white], startPoint: .top, endPoint: .bottom)
                        .frame(height: 30)
                    #endif
                    
                    VStack(spacing: 60) {
                        Text("Palace")
                            .font(.system(size: 44))
                            .fontWeight(.black)
                            #if os(iOS)
                            .shadow(color: .black.opacity(0.3), radius: 6, y: 6)
                            #endif

                        NavigationLink {
                            PiPalaceView()
                        } label: {
                            Label("Play", systemImage: "play")
                                .frame(maxWidth: .infinity)
                                .font(.headline)
                                .padding()
                                #if os(visionOS)
                                .background(.accent.gradient, in: Capsule())
                                .hoverEffect()
                                #else
                            
                                    #if os(iOS)
                                    .background(.accent.gradient.shadow(.drop(color: .black.opacity(0.3), radius: 6)), in: RoundedRectangle(cornerRadius: 12))
                                    #else
                                    .background(.accent.gradient, in: RoundedRectangle(cornerRadius: 12))
                                    #endif
                                #endif
                        }
                        .buttonStyle(.plain)
                        .frame(maxWidth: 400)
                        #if os(visionOS)
                        .padding(.horizontal, 30)
                        #else
                        .padding(.horizontal)
                        #endif
                    }
                    #if os(iOS)
                    .padding(.top, 100)
                    #endif
                    #if os(visionOS) || os(macOS)
                    .padding(.vertical, 0)
                    #else
                    .padding(.top, 50)
                    .padding(.bottom, 80)
                    #endif
                }
                
                VStack(spacing: 15) {
                    NavigationLink {
                        ScoreboardView()
                    } label: {
                        Label("Scoreboard", systemImage: "trophy")
                            .frame(maxWidth: .infinity)
                            .padding()
                            #if os(visionOS)
                            .background(.ultraThinMaterial, in: Capsule())
                            #else
                            #if os(macOS)
                            .background(.secondary.opacity(0.3), in: RoundedRectangle(cornerRadius: 12))
                            #else
                                #if os(iOS)
                            .background(.ultraThinMaterial.shadow(.drop(color: .black.opacity(0.1), radius: 6, y: 6)), in: RoundedRectangle(cornerRadius: 12))
                                #else
                                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
                                #endif
                            #endif
                        #endif
                            #if !os(macOS)
                            .hoverEffect()
                            #endif
                    }
                    .buttonStyle(.plain)
                    
                    NavigationLink {
                        VStack { }.navigationTitle("Achievements")
#if !os(macOS)
                            .navigationBarTitleDisplayMode(.inline)
#endif
                    } label: {
                        Label("Achievements", systemImage: "medal")
                            .frame(maxWidth: .infinity)
                            .padding()
                            #if os(visionOS)
                            .background(.ultraThinMaterial, in: Capsule())
                            #else
                            #if os(macOS)
                            .background(.secondary.opacity(0.3), in: RoundedRectangle(cornerRadius: 12))
                            #else
                                #if os(iOS)
                            .background(.ultraThinMaterial.shadow(.drop(color: .black.opacity(0.1), radius: 6, y: 6)), in: RoundedRectangle(cornerRadius: 12))
                                #else
                                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
                                #endif
                            #endif
                        #endif
#if !os(macOS)
                            .hoverEffect()
#endif
                    }
                    .buttonStyle(.plain)
                    
                    #if os(macOS)
                    NavigationLink {
                        SettingsView()
                    } label: {
                        Label("Settings", systemImage: "gear")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.secondary.opacity(0.3), in: RoundedRectangle(cornerRadius: 12))
                    }
                    .buttonStyle(.plain)
                    #endif
                }
                #if os(visionOS)
                .padding(.horizontal, 30)
                .padding(.bottom, 30)
                #elseif os(macOS)
                .padding(.bottom)
                .padding(.horizontal)
                #else
                .padding(.horizontal)
                #endif
                .frame(maxWidth: 400)
            }
        }
        #if os(iOS)
        .ignoresSafeArea(edges: .top)
        #endif
        .toolbar {
            #if !os(macOS)
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    isShowingSettings = true
                } label: {
                    Image(systemName: "gear")
                }
            }
            #endif
        }
        .sheet(isPresented: $isShowingSettings) {
            SettingsView()
        }
    }
}

#Preview {
    ContentView()
}
