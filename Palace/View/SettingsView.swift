//
//  SettingsView.swift
//  Palace
//
//  Created by Kuba Milcarz on 8/28/23.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            List {
                Section("Reminders") {
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
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Version 1.0")
                            .font(.headline)
                        
                        Link("Privacy Policy", destination: URL(string: "https://www.craft.me/s/OrrbBgoJ8oulQM")!)
                        
                        Text("© Kuba Milcarz 2023")
                    }
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Resources")
                            .font(.headline)
                        
                        Link("Freepik", destination: URL(string: "https://www.freepik.com/free-vector/ballroom-palace-reception-hall-illustration-luxury-museum-chamber-room_3090607.htm")!)
                    }
                }
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
}

#Preview {
    SettingsView()
}
