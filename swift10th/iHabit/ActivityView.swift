//
//  ActivityView.swift
//  iHabit
//
//  Created by warren su on 7/14/25.
//

import SwiftUI

struct ActivityView: View {
    var activities: Activities
    var activity: Activity

    //private var formattedTitle =
    @State private var completedTimesAdded = 0
    var body: some View {
        
        NavigationStack {
            importanceToColor(text: "\(activity.name) : \(activity.importance)", importance:  activity.importance)
                .font(.title)

            
            Form {
                HStack{
                    Text("# Times Completed: ")
                    Stepper("\(activities.items[activity.idx].completedAmount)", onIncrement: {
                        completedTimesAdded += 1
                        var newActivity = Activity(idx: activity.idx, name: activity.name, importance: activity.importance, description: activity.description, completedAmount: activity.completedAmount+1, status: activity.status)
                        
                        activities.items[activity.idx] = newActivity
                            
                    },
                            onDecrement: {
                        completedTimesAdded -= 1
                        var newActivity = Activity(idx: activity.idx, name: activity.name, importance: activity.importance, description: activity.description, completedAmount: activity.completedAmount-1, status: activity.status)
                        activities.items[activity.idx] = newActivity
                    })
                    
                }
                Text("Description \(activity.description)")
                    .font(.subheadline)
            }
        }

        
    }
}

#Preview {
   // ActivityView()
}
