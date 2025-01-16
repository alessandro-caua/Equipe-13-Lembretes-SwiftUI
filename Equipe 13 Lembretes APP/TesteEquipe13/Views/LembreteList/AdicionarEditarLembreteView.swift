import SwiftUI

struct AdicionarEditarLembreteView: View {
    @Environment(\.dismiss) var dismiss
    @State private var titulo = ""
    @State private var descricao = ""
    @State private var data = Date()
    var onSave: (String, String, Date) -> Void

    var body: some View {
        Form {
            TextField("Título", text: $titulo)

            TextField("Descrição", text: $descricao)

            DatePicker("Data", selection: $data, displayedComponents: [.date, .hourAndMinute])
        }
        .navigationTitle("Novo Lembrete")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancelar") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Salvar") {
                    onSave(titulo, descricao, data)
                    dismiss()
                }
                .disabled(titulo.isEmpty || descricao.isEmpty)
            }
        }
    }
}
