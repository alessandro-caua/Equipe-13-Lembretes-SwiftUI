import SwiftUI

struct LembretesView: View {
    var body: some View {
        VStack {
            Text("Seus Lembretes")
                .font(.title)
                .padding()
            
            List {
                Text("Fazer Compras - 12/01 13:41")
                Text("Entregar Atividade - 14/01 20:00")
                Text("Academia - 15/01 17:25")
            }
        }
        .navigationTitle("Lembretes")
    }
}

#Preview {
    LembretesView()
}
