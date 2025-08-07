//
//  SortedProspectsView.swift
//  HotProspects
//
//  Created by warren su on 7/29/25.
//

import SwiftUI

struct SortableProspectsView: View {
    let filter: ProspectsView.FilterType
    @State private var sortOrder = [SortDescriptor(\Prospect.name)]

    var body: some View {
        NavigationStack {
            ProspectsView(filter: filter, sortOrder: sortOrder)
                .toolbar {
                    ToolbarItem{
                        Menu("Sort", systemImage: "arrow.up.arrow.down") {
                            Picker("Sort", selection: $sortOrder) {
                                Text("Sort by Name")
                                    .tag([SortDescriptor(\Prospect.name)])
                                Text("Sort by Most Recent")
                                    .tag(
                                        [SortDescriptor(\Prospect.dateAdded, order: .reverse)]
                                    )
                            }
                        }
                    }
                }
        }
    }
}

#Preview {
    SortableProspectsView(filter: .none)
}
