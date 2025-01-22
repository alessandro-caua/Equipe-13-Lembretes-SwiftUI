import SwiftUI

struct LembreteCard: View {
    var lembrete: LembreteModel

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(lembrete.titulo)
                    .font(.headline)

                Text(lembrete.data, style: .date)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.blue.opacity(0.2))
        }
        .cornerRadius(12)
    }
}

#Preview {
    LembreteCard(
        lembrete: LembreteModel(
            titulo: "Teste",
            descricao: "Descrição de teste",
            data: Date()
        )
    )
}
