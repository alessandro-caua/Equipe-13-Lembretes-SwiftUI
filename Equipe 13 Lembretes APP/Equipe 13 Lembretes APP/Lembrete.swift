import Foundation

struct Lembrete: Identifiable {
    let id = UUID()
    var titulo: String
    var descricao: String
    var data: Date
}
