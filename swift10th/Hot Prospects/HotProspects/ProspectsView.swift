//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Warren Su on 7/28/25.
//

import CodeScanner
import SwiftData
import SwiftUI
import UserNotifications

struct ProspectsView: View {
    enum FilterType {
        case none, contacted, uncontacted
    }
    
    
    
    @Query(sort: \Prospect.name) var prospects: [Prospect]
    @Environment(\.modelContext) var modelContext
    @State private var selectedProspects = Set<Prospect>()
    @State private var isShowingScanner = false
    
    let filter: FilterType
    @State private var sortOrder: [SortDescriptor<Prospect>]
    var title: String {
        switch filter {
        case .none:
            "Everyone"
        case .contacted:
            "Contacted people"
        case .uncontacted:
            "Uncontacted people"
        }
    }

    var body: some View {
        NavigationStack {
                    
            List(prospects, selection: $selectedProspects) { prospect in
                    NavigationLink {
                        ProspectEditView(prospect: prospect)
                    } label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(prospect.name)
                                    .font(.headline)

                                Text(prospect.emailAddress)
                                    .foregroundStyle(.secondary)
                            }

                            if filter == .none, prospect.isContacted {
                                Spacer()
                                Image(systemName: "checkmark.circle")
                            }
                        }
                    }
                    .swipeActions {
                        Button("Delete", systemImage: "trash", role: .destructive) {
                            modelContext.delete(prospect)
                        }

                        if prospect.isContacted {
                            Button("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark") {
                                prospect.isContacted.toggle()
                            }
                            .tint(.blue)
                        } else {
                            Button("Mark Contacted", systemImage: "person.crop.circle.fill.badge.checkmark") {
                                prospect.isContacted.toggle()
                            }
                            .tint(.green)

                            Button("Remind Me", systemImage: "bell") {
                                addNotification(for: prospect)
                            }
                            .tint(.orange)
                        }
                    }

                    .tag(prospect)
                }
                
               
            .navigationTitle(title)
            .toolbar {
                
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Scan", systemImage: "qrcode.viewfinder") {
                        isShowingScanner = true
                    }
                }

                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                
                if selectedProspects.isEmpty == false {
                    ToolbarItem(placement: .bottomBar) {
                        Button("Delete Selected", action: delete)
                    }
                }
            }
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Hudson\npaul@hackingwithswift.com", completion: handleScan)
            }
        }
    }

    init(filter: FilterType, sortOrder: [SortDescriptor<Prospect>]) {
        self.filter = filter
        self.sortOrder = sortOrder
        if filter != .none {
            let showContactedOnly = filter == .contacted

            _prospects = Query(filter: #Predicate {
                $0.isContacted == showContactedOnly
            }, sort: sortOrder)
        }
        else {
            _prospects = Query(sort: sortOrder)
        }
    }

    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false

        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            print(prospects.count)
            let person = Prospect(name: details[0], emailAddress: details[1], isContacted: false)
            
            modelContext.insert(person)
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }

    func delete() {
        for prospect in selectedProspects {
            modelContext.delete(prospect)
        }
    }

    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()

        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default

//            var dateComponents = DateComponents()
//            dateComponents.hour = 9
//            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }

        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else if let error {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}

