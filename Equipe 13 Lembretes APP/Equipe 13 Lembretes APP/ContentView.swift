import SwiftUI

struct ContentView: View {
    @State private var lembretes: [Lembrete] = []
    @State private var isPresenting = false
    @State private var selectedLembrete: Lembrete?

    var body: some View {
        NavigationView {
            List {
                ForEach(lembretes.sorted(by: { $0.data < $1.data })) { lembrete in
                    Button(action: {
                        selectedLembrete = lembrete
                    }) {
                        VStack(alignment: .leading) {
                            Text(lembrete.titulo)
                                .font(.headline)
                            Text(lembrete.data, style: .date) // Exibe a data
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    .sheet(item: $selectedLembrete) { lembrete in
                        VStack(spacing: 20) {
                            Text(lembrete.titulo)
                                .font(.largeTitle)
                            Text(lembrete.descricao)
                                .font(.body)
                                .multilineTextAlignment(.leading)
                            Text("Data: \(lembrete.data, style: .date)") // Exibe a data
                            Button("Fechar") {
                                selectedLembrete = nil
                            }
                        }
                        .padding()
                    }
                }
                .onDelete(perform: deleteLembrete)
            }
            .navigationTitle("Meus Lembretes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isPresenting = true
                    }) {
                        Label("Adicionar Lembrete", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $isPresenting) {
                AdicionarEditarLembreteView { titulo, descricao, data in
                    let novoLembrete = Lembrete(titulo: titulo, descricao: descricao, data: data)
                    lembretes.append(novoLembrete)
                    isPresenting = false
                }
            }
        }
    }

    private func deleteLembrete(at offsets: IndexSet) {
        lembretes.remove(atOffsets: offsets)
    }
}
