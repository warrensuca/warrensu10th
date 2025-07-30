//
//  ProspectEditView.swift
//  HotProspects
//
//  Created by Warren Su on 7/29/25.
//

import SwiftUI

struct ProspectEditView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    var prospect: Prospect
    
    @State var name: String
    @State var emailAddress: String
    @State var isContacted: Bool
    var body: some View {
        NavigationStack{
            VStack{
                TextField("Enter the name!", text: $name)
                
                TextField("Enter the email address!", text: $emailAddress)
                
                Toggle(isOn: $isContacted) {
                        Text("Contacted? ")
                    }
            }
            
            
        }.toolbar {
            Button("Save") {
                let newProspect = Prospect(name: name, emailAddress: emailAddress, isContacted: isContacted)
                
                modelContext.delete(prospect)
                modelContext.insert(newProspect)
                
                dismiss()
            }
        }
    }

    init(prospect: Prospect) {
        
        self.prospect = prospect
        
        _name = State(initialValue: self.prospect.name)
        _emailAddress = State(initialValue: self.prospect.emailAddress)
        _isContacted = State(initialValue: self.prospect.isContacted)
    }
    
}

#Preview {

    
    return ProspectEditView(prospect: Prospect(name: "Warren", emailAddress: "warrensuca@gmail.com", isContacted: false))
        .modelContainer(for: Prospect.self)
}
