import SwiftUI

struct LembreteDetalhes: View {
    var lembrete: LembreteModel

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(lembrete.titulo)
                .font(.largeTitle)
                .bold()

            Text(lembrete.descricao)
                .font(.body)

            Text("Data e Hora")
                .font(.headline)

            Text(lembrete.data, style: .date)
                .font(.subheadline)

            Spacer()
        }
        .padding()
        .navigationTitle("Detalhes")
    }
}
