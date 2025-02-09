import SwiftUI

struct EditarPerfilView: View {
    @ObservedObject var usuarioViewModel: UsuarioViewModel
    @State private var novoNome: String = ""

    var body: some View {
        VStack {
            Text("Editar Perfil")
                .font(.title)
                .padding()

            TextField("Nome do Usuário", text: $novoNome)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Salvar") {
                usuarioViewModel.nomeUsuario = novoNome
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)

            Spacer()
        }
        .padding()
    }
}

#Preview {
    EditarPerfilView(usuarioViewModel: UsuarioViewModel())
}
