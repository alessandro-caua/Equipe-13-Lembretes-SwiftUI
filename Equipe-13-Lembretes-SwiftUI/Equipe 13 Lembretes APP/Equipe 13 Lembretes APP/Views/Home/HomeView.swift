import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = LembreteViewModel()
    @State private var dataHoraAtual = Date()
    
    var body: some View {
        NavigationStack {
            VStack {
                // Saudação e Data/Hora
                HStack {
                    VStack(alignment: .leading) {
                        Text("Olá!")
                            .font(.largeTitle)
                            .bold()
                        Text(dataFormatada())
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
                .padding()
                
                // Lista de Lembretes
                List {
                    ForEach(viewModel.lembretes) { lembrete in
                        VStack(alignment: .leading) {
                            Text(lembrete.titulo)
                                .font(.headline)
                            Text(lembrete.descricao)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .contextMenu {
                            Button(action: {
                                // Editar lembrete
                            }) {
                                Label("Editar", systemImage: "pencil")
                            }
                            Button(role: .destructive, action: {
                                viewModel.deletarLembrete(id: lembrete.id)
                            }) {
                                Label("Deletar", systemImage: "trash")
                            }
                        }
                    }
                }
                
                Spacer()
                
                // Barra de Navegação Inferior
                HStack {
                    @Environment(\.dismiss) var dismiss

                    Button(action: {
                        dismiss() // Volta corretamente para a HomeView existente
                    }) {
                        VStack {
                            Image(systemName: "house.fill")
                            Text("Início")
                        }
                        .padding()
                    }

                    Spacer()
                    NavigationLink(destination: AdicionarEditarLembreteView(onSave: { titulo, descricao, data in
                        viewModel.addLembrete(titulo: titulo, descricao: descricao, data: data)
                    })) {
                        VStack {
                            Image(systemName: "plus.circle.fill")
                            Text("Criar")
                        }
                        .padding()
                    }
                    Spacer()
                    NavigationLink(destination: LembretesPassados(viewModel: viewModel)) {
                        VStack {
                            Image(systemName: "clock.fill")
                            Text("Passados")
                        }
                        .padding()
                    }
                    Spacer()
                    NavigationLink(destination: CalendarioView(viewModel: viewModel)) {
                        VStack {
                            Image(systemName: "calendar")
                            Text("Calendário")
                        }
                        .padding()
                    }
                }
                .padding()
                .background(Color(UIColor.systemGray6))
            }
        }
    }
    
    private func dataFormatada() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, dd 'de' MMMM yyyy - HH:mm"
        return formatter.string(from: dataHoraAtual)
    }
}

struct CalendarioView: View {
    @ObservedObject var viewModel: LembreteViewModel
    @State private var selectedDate = Date()
    
    var body: some View {
        VStack {
            DatePicker("Selecione uma data", selection: $selectedDate, displayedComponents: .date)
                .datePickerStyle(.graphical)
                .padding()
            
            List(viewModel.lembretes.filter { Calendar.current.isDate($0.data, inSameDayAs: selectedDate) }) { lembrete in
                VStack(alignment: .leading) {
                    Text(lembrete.titulo)
                        .font(.headline)
                    Text(lembrete.descricao)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
        }
        .navigationTitle("Calendário")
    }
}
