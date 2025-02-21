import SwiftUI

struct LembreteModel: Identifiable {
    var id: UUID = UUID()
    var titulo: String
    var descricao: String
    var data: Date
    var color: Color = .white
    var isComplete: Bool = false
}
