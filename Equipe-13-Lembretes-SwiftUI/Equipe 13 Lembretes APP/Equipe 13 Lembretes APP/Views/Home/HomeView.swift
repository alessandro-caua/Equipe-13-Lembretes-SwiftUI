import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Bem-vindo ao seu aplicativo de lembretes!")
                    .font(.title)
                    .padding()
                
                NavigationLink(destination: LembretesView()) {
                    Text("Ver Lembretes")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                NavigationLink(destination: PerfilUsuarioView()) {
                    Text("Perfil do Usuário")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .navigationTitle("Home")
        }
    }
}

#Preview {
    HomeView()
}
