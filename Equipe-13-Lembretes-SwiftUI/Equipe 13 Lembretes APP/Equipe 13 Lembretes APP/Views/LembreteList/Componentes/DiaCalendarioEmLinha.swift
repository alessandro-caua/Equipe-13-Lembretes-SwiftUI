//
//  DiaCalendarioEmLinha.swift
//  Equipe 13 Lembretes APP
//
//  Created by Ian Pacini on 21/02/25.
//

import SwiftUI

struct DiaCalendarioEmLinha: View {
    var data: Date
    var isSelected: Bool
    
    var body: some View {
        VStack {
            Text("dia")
            Text("numero")
        }
        .background()
    }
}

struct DiaCalendarioEmLinhaModel: Identifiable {
    let id: UUID = UUID()
    let data: Date
    
}

#Preview {
    @Previewable @State var diaSelecionado: DiaCalendarioEmLinhaModel = .init(data: .now)
    
    DiaCalendarioEmLinha(data: diaSelecionado.data, isSelected: true)
}
