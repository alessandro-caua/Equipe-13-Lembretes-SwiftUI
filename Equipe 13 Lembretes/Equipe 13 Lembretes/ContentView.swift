import SwiftUI

struct Reminder: Identifiable {
    let id = UUID()
    var title: String
    var date: Date
}

struct ContentView: View {
    @State private var reminders: [Reminder] = []
    @State private var isAddingReminder = false

    var body: some View {
        List(reminders) { reminder in
            VStack(alignment: .leading) {
                Text(reminder.title)
                    .font(.headline)
                Text("\(reminder.date, formatter: DateFormatter.shortDateTime)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(action: { isAddingReminder = true }) {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $isAddingReminder) {
            AddReminderView(reminders: $reminders)
        }
    }
}

struct AddReminderView: View {
    @Binding var reminders: [Reminder]
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var date = Date()

    var body: some View {
        Form {
            TextField("Título", text: $title)
            DatePicker("Data e Hora", selection: $date, displayedComponents: [.date, .hourAndMinute])
        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancelar") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Salvar") {
                    let newReminder = Reminder(title: title, date: date)
                    reminders.append(newReminder)
                    dismiss()
                }
            }
        }
    }
}

extension DateFormatter {
    static let shortDateTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
}

@main
struct BasicReminderApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
