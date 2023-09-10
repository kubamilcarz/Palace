//
//  SettingsView.swift
//  Palace
//
//  Created by Kuba Milcarz on 8/28/23.
//

import SwiftUI
import StoreKit

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Toggle(isOn: .constant(false), label: {
                        Label("Reminders", systemImage: "bell")
                    })
                    DatePicker(selection: .constant(.now), displayedComponents: .hourAndMinute) {
                        Label("Remind at", systemImage: "clock")
                    }
                }
                .disabled(true)
                
                
                Section("Data") {
                    Button {
                        
                    } label: {
                        Label("Export Data", systemImage: "square.and.arrow.up")
                    }
                    Button {
                        
                    } label: {
                        Label("Import Data", systemImage: "square.and.arrow.down")
                    }
                }
                .disabled(true)
                
                Section("About") {
                    VStack(alignment: .center, spacing: 10) {
                        AppIcon(named: "AppIcon-Preview")
                        
                        Text("Palace")
                            .font(.subheadline.weight(.medium))
                        
                        Text("Version: \(Constant.AppVersion)")
                            .padding(.bottom)
                        
                        Text("© Kuba Milcarz 2023\nAll rights reserved.")
                        
                        Link("Privacy Policy", destination: Constant.PrivacyPolicy)
                            .underline()
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                .listRowBackground(
                    ZStack {
                        RadialGradient(colors: [.accentColor.opacity(0.7), .accentColor], center: .bottomTrailing, startRadius: 100, endRadius: 300)
                            .contrast(0.6)
                    }
                )
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                
                Section {
                    HStack {
                        Text("Apps")
                            .font(.subheadline.weight(.medium))
                        Spacer()
                        
                        Link(destination: URL(string: "https://kubamilcarz.github.io")!) {
                            HStack {
                                Text("Learn more")
                                Image(systemName: "chevron.right")
                            }
                        }
                        
                    }
                    .listRowBackground(
                        ZStack {
                            RadialGradient(colors: [.blue, .orange], center: .bottomLeading, startRadius: 0, endRadius: 300)
                            
                            Rectangle().fill(.thickMaterial)
                        }
                    )
                    
                    HStack(spacing: 25) {
                        Spacer(minLength: 0)
                        
                        AppPreview("Memorize", image: "AppIcon-Memorize", link: URL(string: "https://apps.apple.com/us/app/memorize-flashcards/id1631928972?platform=iphone")!)
                        AppPreview("Bookie", image: "AppIcon-Bookie", link: URL(string: "https://apps.apple.com/us/app/bookie-reading-tracker/id6443825869")!)
                        AppPreview("Coffee Note", image: "AppIcon-CoffeeNote", link: URL(string: "https://apps.apple.com/us/app/coffee-note-taste-coffee/id6447321924")!)
                        
                        Spacer(minLength: 0)
                    }
                    .padding(7)
                    .listRowBackground(
                        ZStack {
                            RadialGradient(colors: [.blue, .orange], center: .bottomLeading, startRadius: 0, endRadius: 300)
                            
                            Rectangle().fill(.regularMaterial)
                        }
                    )
                }
                .font(.caption)
                .foregroundStyle(.secondary)
                
                Section {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 5) {
                            Text("Links: ")
                                .font(.subheadline.weight(.medium))
                            
                            Link("Images from Freepik", destination: URL(string: "https://www.freepik.com/free-vector/ballroom-palace-reception-hall-illustration-luxury-museum-chamber-room_3090607.htm")!)
                                .underline()
                            Divider().frame(height: 10)
                            
                            Link("Available on Github", destination: URL(string: "https://github.com/kubamilcarz/Palace")!)
                                .underline()
                            
                            #if !os(macOS)
                            Divider().frame(height: 10)
                            
                            Button("Rate on App Store") {
                                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) {
                                    if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                                        SKStoreReviewController.requestReview(in: scene)
                                    }
                                }
                            }
                            #endif
                        }
                        .padding(.vertical, 7)
                    }
                }
                .font(.caption)
                .foregroundStyle(.secondary)
            }
            .navigationTitle("Settings")
            #if !os(macOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .toolbar {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .symbolRenderingMode(.hierarchical)
                }
            }
        }
    }
    
    private func AppPreview(_ title: String, image: String, link: URL) -> some View {
        Link(destination: link) {
            VStack(spacing: 7) {
                AppIcon(named: image, size: 70)
                
                Text(title)
            }
        }
        .buttonStyle(.plain)
    }
    
    private func AppIcon(named image: String, size: CGFloat = 90) -> some View {
        Image(image)
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
            .clipShape(RoundedRectangle(cornerRadius: size > 80 ? 18 : 15))
            .shadow(radius: size > 80 ? 4 : 2, y: size > 80 ? 4 : 2)
    }
}

#Preview {
    SettingsView()
}
