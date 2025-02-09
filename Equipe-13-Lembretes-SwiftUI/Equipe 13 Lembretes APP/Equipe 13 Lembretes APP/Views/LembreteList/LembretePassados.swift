import SwiftUI

struct LembretesPassados: View {
    @ObservedObject var viewModel: LembreteViewModel

    var body: some View {
        List(viewModel.lembretesPassados()) { lembrete in
            NavigationLink(destination: LembreteDetalhes(lembrete: lembrete)) {
                VStack(alignment: .leading) {
                    Text(lembrete.titulo)
                        .font(.headline)
                    Text(lembrete.data, style: .date)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
        }
        .navigationTitle("Lembretes Passados")
    }
}
