//
//  ContentView.swift
//  iHabit
//
//  Created by warren su on 7/14/25.
//

import SwiftUI


struct Activity: Identifiable, Codable, Equatable {
    var id = UUID()
    var idx: Int
    var name: String
    var importance: String
    var description: String
    var completedAmount: Int
    var status: String
    //var dueDate: Date
    
    
}

@Observable
class Activities {
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items"){
            if let decodedItems = try? JSONDecoder().decode([Activity].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
    }
    var items =  [Activity]() {
        didSet{
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
}

struct ContentView: View {
    private var matchStatus = ["No": "❌", "Yes": "✅"]
    @State private var activities = Activities()
    @State private var showingSheet = false
    var body: some View {
        NavigationStack {
            List {
                ForEach(activities.items) { activity in
                    NavigationLink() {
                        ActivityView(activities: activities, activity: activity)
                    } label: {
                        HStack{
                            importanceToSize(text: activity.name, importance: activity.importance)
                            
                        }
                    }
                }.onDelete(perform: removeitems)
            }
            
            .navigationTitle("iHabit")
            .padding()
            .toolbar {
                Button("Add activity", systemImage: "plus") {
                    showingSheet = true
                }
            }
            .sheet(isPresented: $showingSheet) {
                NewHabit(activities: activities)
            }
        }
    }
    func removeitems(offsets: IndexSet) {
        activities.items.remove(atOffsets: offsets)
    }
}

struct importanceToSize: View {
    var text: String
    var importance: String
    var body: some View {
        if importance == "Not Important" {
            Text(text)
                .font(.caption)
        }
        else if importance == "Important" {
            Text(text)
                .font(.title3)
        }
        else {

            Text(text)
                .bold()
                .font(.title)
                .frame(height:60)

        }
    }
}

struct importanceToColor: View {
    var text: String
    var importance: String
    var body: some View {
        if importance == "Not Important" {
            Text(text)
                .foregroundStyle(.gray)
        }
        else if importance == "Important" {
            Text(text)
                .foregroundStyle(.black)
        }
        else {

            Text(text)
                .foregroundStyle(.yellow)

        }
    }
}

#Preview {
    ContentView()
}
