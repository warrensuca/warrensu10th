//
//  NewHabit.swift
//  iHabit
//
//  Created by warren su on 7/14/25.
//

import SwiftUI

struct NewHabit: View {
    var activities: Activities
    @State private var name = "Activity Name"
    @State private var importance = "Important"
    @State private var description = ""
    @State private var status = "No"
    @State private var importanceScales = ["Not Important", "Important", "Very Important"]
    
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationStack {
            Form{

                
                Picker("Importance", selection: $importance) {
                    ForEach(importanceScales, id: \.self) {
                        Text($0)
                    }
                }
                
                
                TextField("short description", text: $description)
                
            }
            .navigationTitle($name)
                .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem{
                    Button("Save") {
                        activities.items.append(Activity(idx: activities.items.count, name: name, importance: importance, description: description, completedAmount: 0, status: status))
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    NewHabit(activities: Activities())
}
