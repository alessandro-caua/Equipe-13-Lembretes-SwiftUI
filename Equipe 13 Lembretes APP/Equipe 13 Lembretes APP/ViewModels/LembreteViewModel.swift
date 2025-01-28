import SwiftUI

class LembreteViewModel: ObservableObject {
    @Published var lembretes: [LembreteModel]

    init(lembretes: [LembreteModel] = []) {
        self.lembretes = lembretes
    }

    func addLembrete(titulo: String, descricao: String, data: Date) {
        let novoLembrete = LembreteModel(titulo: titulo, descricao: descricao, data: data)
        lembretes.append(novoLembrete)
        ordenarLembretes()
    }

    func editarLembrete(id: UUID, novoTitulo: String, novaDescricao: String, novaData: Date) {
        if let index = lembretes.firstIndex(where: { $0.id == id }) {
            lembretes[index].titulo = novoTitulo
            lembretes[index].descricao = novaDescricao
            lembretes[index].data = novaData
            ordenarLembretes()
        }
    }

    func deletarLembrete(id: UUID) {
        lembretes.removeAll { $0.id == id }
    }

    func lembretesFuturos() -> [LembreteModel] {
        lembretes.filter { $0.data >= Date() }
    }

    func lembretesPassados() -> [LembreteModel] {
        lembretes.filter { $0.data < Date() }
    }

    private func ordenarLembretes() {
        lembretes.sort { $0.data < $1.data }
    }
}
