//
//  ScoreboardView.swift
//  Palace
//
//  Created by Kuba Milcarz on 8/28/23.
//

import SwiftUI
import SwiftData

struct ScoreboardView: View {
    @FetchRequest<PiRecord>(sortDescriptors: [SortDescriptor(\.attemptDate, order: .reverse)]) var attempts: FetchedResults<PiRecord>
    
    var topAttempts: [PiRecord] {
        if attempts.count > 10 {
            return Array(attempts.sorted { $0.wrapped_score > $1.wrapped_score }.prefix(3))
        } else { return [] }
    }
    
    var body: some View {
        List {
            if attempts.isEmpty {
                ContentUnavailableView("No history", systemImage: "clock", description: Text("Play at least one game to see scoreboard"))
                    .frame(maxWidth: .infinity)
            } else {
                if attempts.count > 10 {
                    Section("Top 3") {
                        ForEach(topAttempts.indices) { index in
                            HStack(spacing: 10) {
                                Image(systemName: "trophy")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundStyle(index == 0 ? .yellow : index == 1 ? .gray : .brown)
                                    .frame(width: 40)
                                
                                Cell(for: topAttempts[index])
                            }
                        }
                    }
                }
                
                Section("Recent") {
                    ForEach(attempts.prefix(30)) { attempt in
                        Cell(for: attempt)
                    }
                }
            }
        }
        .navigationTitle("Scoreboard")
    }
    
    private func Cell(for attempt: PiRecord) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(attempt.wrapped_score.formatted(.number))
                    .font(.headline)
                Text(attempt.wrapped_attemptDate.formatted(date: .abbreviated, time: .shortened))
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    ScoreboardView()
}
