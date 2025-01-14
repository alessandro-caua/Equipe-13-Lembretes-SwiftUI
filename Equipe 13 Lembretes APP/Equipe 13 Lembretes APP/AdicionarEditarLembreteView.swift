import SwiftUI

struct AdicionarEditarLembreteView: View {
    @Environment(\.dismiss) var dismiss
    @State private var titulo = ""
    @State private var descricao = ""
    @State private var data = Date()
    var onSave: (String, String, Date) -> Void

    var body: some View {
        NavigationView {
            Form {
                TextField("Título", text: $titulo)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(false)
                    .textInputAutocapitalization(.sentences) // Apenas para iOS 15+

                TextField("Descrição", text: $descricao)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(false)
                    .textInputAutocapitalization(.sentences) // Apenas para iOS 15+

                DatePicker("Data", selection: $data, displayedComponents: .date)
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
}
