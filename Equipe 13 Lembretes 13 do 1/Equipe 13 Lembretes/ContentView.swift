import SwiftUI

struct ConteudoView: View {
    @State private var lembretes: [Lembrete] = []
    @State private var adicionandoLembrete = false
    @State private var editandoLembrete: Lembrete?

    var body: some View {
        VStack {
            ScrollView { // Lista rolável
                ForEach(lembretesPorMes, id: \.self) { lembretesDoMes in
                    VStack(alignment: .leading) {
                        let dataInicio = lembretesDoMes.first?.data ?? Date()
                        let dataMesAno = DateFormatter.mesAno.string(from: dataInicio)
                        
                        Text(dataMesAno)
                            .font(.headline)
                            .padding(.top)

                        HStack(spacing: 20) { // Coloca os lembretes lado a lado
                            ForEach(lembretesDoMes) { lembrete in
                                VStack(alignment: .leading) {
                                    Text(lembrete.titulo)
                                        .font(.headline)
                                    if let descricao = lembrete.descricao, !descricao.isEmpty {
                                        Text(descricao)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                            .lineLimit(2)
                                    }
                                    Text("\(lembrete.data, formatter: DateFormatter.dataHoraCurta)")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                .padding()
                                .background(Color.blue.opacity(0.1))
                                .cornerRadius(10)
                            }
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    HStack {
                        Button(action: { adicionandoLembrete = true }) {
                            Image(systemName: "plus")
                                .font(.system(size: 30))
                                .padding(10)
                                .background(Circle().fill(Color.blue))
                                .foregroundColor(.white)
                        }
                        Text("Criar lembrete")
                            .font(.headline)
                            .foregroundColor(.blue)
                    }
                }
            }
            .sheet(isPresented: $adicionandoLembrete) {
                AdicionarLembreteView(lembretes: $lembretes)
            }
            .sheet(item: $editandoLembrete) { lembrete in
                EditarLembreteView(lembretes: $lembretes, lembrete: lembrete)
            }
        }
    }

    private var lembretesPorMes: [[Lembrete]] {
        let grouped = Dictionary(grouping: lembretes) { (lembrete) -> String in
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/yyyy"
            return formatter.string(from: lembrete.data)
        }
        
        let sortedGrouped = grouped.mapValues { $0.sorted { $0.data < $1.data } }
        return sortedGrouped.values.sorted {
            guard let firstDate = $0.first?.data, let secondDate = $1.first?.data else { return false }
            return firstDate < secondDate
        }
    }
}

struct AdicionarLembreteView: View {
    @Binding var lembretes: [Lembrete]
    @Environment(\.dismiss) var dismiss
    @State private var titulo = ""
    @State private var descricao = ""
    @State private var data = Date()

    var body: some View {
        Form {
            TextField("Título", text: $titulo)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            TextField("Descrição (opcional)", text: $descricao)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            DatePicker("Data e Hora", selection: $data, displayedComponents: [.date, .hourAndMinute]) // Impede datas passadas
                .padding()
        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancelar") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Salvar") {
                    guard !titulo.isEmpty else {
                        // Exibe um alerta se o título não estiver preenchido
                        return
                    }
                    let novoLembrete = Lembrete(titulo: titulo, descricao: descricao.isEmpty ? nil : descricao, data: data)
                    lembretes.append(novoLembrete)
                    dismiss()
                }
            }
        }
    }
}

struct EditarLembreteView: View {
    @Binding var lembretes: [Lembrete]
    var lembrete: Lembrete
    @Environment(\.dismiss) var dismiss
    @State private var titulo: String
    @State private var descricao: String
    @State private var data: Date

    init(lembretes: Binding<[Lembrete]>, lembrete: Lembrete) {
        _lembretes = lembretes
        self.lembrete = lembrete
        _titulo = State(initialValue: lembrete.titulo)
        _descricao = State(initialValue: lembrete.descricao ?? "")
        _data = State(initialValue: lembrete.data)
    }

    var body: some View {
        Form {
            TextField("Título", text: $titulo)
            TextField("Descrição (opcional)", text: $descricao)
            DatePicker("Data e Hora", selection: $data, displayedComponents: [.date, .hourAndMinute]) // Impede datas passadas
        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancelar") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Salvar") {
                    if let indice = lembretes.firstIndex(where: { $0.id == lembrete.id }) {
                        lembretes[indice].titulo = titulo
                        lembretes[indice].descricao = descricao.isEmpty ? nil : descricao
                        lembretes[indice].data = data
                    }
                    dismiss()
                }
            }
        }
    }
}

struct Lembrete: Identifiable {
    let id = UUID()
    var titulo: String
    var descricao: String?
    var data: Date
}

extension DateFormatter {
    static let dataHoraCurta: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
    static let mesAno: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/yyyy"
        return formatter
    }()
}
