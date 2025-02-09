import SwiftUI

struct PerfilUsuarioView: View {
    @State private var nomeUsuario: String = "Nome do Usuário"
    @State private var imagemPerfil: Image = Image(systemName: "person.crop.circle.fill")
    
    var body: some View {
        VStack {
            imagemPerfil
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                .padding()
            
            Text(nomeUsuario)
                .font(.title)
                .bold()
                .padding(.bottom, 10)
            
            Button(action: {
                // Ação para editar perfil
            }) {
                Text("Editar Perfil")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            
            List {
                Section(header: Text("Pastas Personalizadas")) {
                    NavigationLink("Trabalho", destination: Text("Lembretes de Trabalho"))
                    NavigationLink("Estudos", destination: Text("Lembretes de Estudos"))
                    NavigationLink("Pessoal", destination: Text("Lembretes Pessoais"))
                }
            }
            
            Spacer()
            
            // Barra de Navegação Inferior
            HStack {
                NavigationLink(destination: HomeView()) {
                    VStack {
                        Image(systemName: "house.fill")
                        Text("Início")
                    }
                    .padding()
                }
                Spacer()
                NavigationLink(destination: AdicionarEditarLembreteView(onSave: { _, _, _ in })) {
                    VStack {
                        Image(systemName: "plus.circle.fill")
                        Text("Criar")
                    }
                    .padding()
                }
                Spacer()
                NavigationLink(destination: LembretesPassados(viewModel: LembreteViewModel())) {
                    VStack {
                        Image(systemName: "clock.fill")
                        Text("Passados")
                    }
                    .padding()
                }
            }
            .padding()
            .background(Color(UIColor.systemGray6))
        }
        .navigationTitle("Perfil")
    }
}

#Preview {
    PerfilUsuarioView()
}
