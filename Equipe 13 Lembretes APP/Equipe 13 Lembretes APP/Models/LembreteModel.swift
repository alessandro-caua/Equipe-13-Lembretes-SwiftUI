import Foundation

struct LembreteModel: Identifiable {
    var id: UUID = UUID()
    var titulo: String
    var descricao: String
    var data: Date
}
