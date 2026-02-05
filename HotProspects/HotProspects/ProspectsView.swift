//
//  ProspectsView.swift
//  HotProspects
//
//  Created by niccho on 25/11/2025.
//

import AVFoundation
import CodeScanner
import SwiftData
import SwiftUI
import UserNotifications

struct ProspectsView: View {
    @Environment(\.modelContext) var modelContext

    @Query(sort: \Prospect.name) var prospects: [Prospect]

    @State private var showingScanner = false
    @State private var selection: Set<Prospect> = .init()

    enum FilterType {
        case none, contacted, uncontacted
    }

    let filter: FilterType

    var title: String {
        switch filter {
        case .none:
            "Everyone"
        case .contacted:
            "Contacted"
        case .uncontacted:
            "Uncontacted"
        }
    }

    init(filter: FilterType) {
        self.filter = filter

        if filter != .none {
            let showContactedOnly = filter == .contacted
            let predicate = #Predicate<Prospect> { prospect in
                prospect.isContacted == showContactedOnly
            }
            let sort = [SortDescriptor(\Prospect.name)]
            _prospects = Query(filter: predicate, sort: sort)
        }
    }

    var body: some View {
        NavigationStack {
            List(prospects, selection: $selection) { prospect in
                VStack(alignment: .leading) {
                    Text(prospect.name)
                        .font(.headline)

                    Text(prospect.emailAddress)
                        .foregroundStyle(.secondary)
                }
                .swipeActions(content: {
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
                        }.tint(.orange)
                    }

                })
                .tag(prospect)
            }
            .navigationTitle(title)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }

                if selection.isEmpty == false {
                    ToolbarItem(placement: .bottomBar) {
                        Button("Delete Selected", action: deleteSelectedProspects)
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button("Scan", systemImage: "qrcode.viewfinder") {
                        showingScanner = true
                    }
                }
            }
            .sheet(isPresented: $showingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Hudson\npaul@hackingwithswift.com") { res in
                    handleScan(result: res)
                }
            }
        }
    }

    func deleteSelectedProspects() {
        for prospect in selection {
            modelContext.delete(prospect)
        }
    }

    func handleScan(result: Result<ScanResult, ScanError>) {
        showingScanner = false

        switch result {
        case let .success(result):
            let details = result.string.components(separatedBy: "\n")
            guard details.count == 2 else {
                return
            }

            let person = Prospect(name: details[0], emailAddress: details[1], isContacted: false)

            modelContext.insert(person)
        case let .failure(error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }

    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default

            var dateComponents = DateComponents()
            dateComponents.hour = 9
//            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

            let request = UNNotificationRequest(
                identifier: UUID().uuidString,
                content: content,
                trigger: trigger
            )
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

#Preview("Everyone") {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Prospect.self, configurations: config)

        for example in Prospect.examples {
            container.mainContext.insert(example)
        }

        return NavigationStack {
            ProspectsView(filter: .none)
        }.modelContainer(container)
    } catch {
        return Text("Failed to create preview")
    }
}
