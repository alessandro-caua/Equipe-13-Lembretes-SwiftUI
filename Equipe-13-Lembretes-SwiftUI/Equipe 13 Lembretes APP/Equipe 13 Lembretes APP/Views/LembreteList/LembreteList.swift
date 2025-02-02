import SwiftUI

struct LembreteList: View {
    @StateObject var viewModel = LembreteViewModel()

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.lembretesFuturos()) { lembrete in
                    NavigationLink(destination: LembreteDetalhes(lembrete: lembrete)) {
                        VStack(alignment: .leading) {
                            Text(lembrete.titulo).font(.headline)
                            Text(lembrete.data, style: .date)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .onDelete { indices in
                    indices.forEach { index in
                        let lembrete = viewModel.lembretesFuturos()[index]
                        viewModel.deletarLembrete(id: lembrete.id)
                    }
                }
            }
            .navigationTitle("Lembretes Atuais")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink("Novo", destination: AdicionarEditarLembreteView { titulo, descricao, data in
                        viewModel.addLembrete(titulo: titulo, descricao: descricao, data: data)
                    })
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink("Passados", destination: LembretesPassados(viewModel: viewModel))
                }
            }
        }
    }
}
