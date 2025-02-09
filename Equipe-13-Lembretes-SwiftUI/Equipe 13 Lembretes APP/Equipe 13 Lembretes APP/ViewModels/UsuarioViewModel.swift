import SwiftUI

class UsuarioViewModel: ObservableObject {
    @Published var nomeUsuario: String = "Nome do Usuário"
    @Published var imagemPerfil: Image = Image(systemName: "person.crop.circle.fill")
}
