//
//  LembreteCard.swift
//  TesteEquipe13
//
//  Created by Ian Pacini on 13/01/25.
//

import SwiftUI

struct LembreteCard: View {
    var lembrete: LembreteModel
    
    var body: some View {
        HStack {
            VStack {
                Text(lembrete.nome)
                Text(lembrete.data.description)
            }
            .padding(.horizontal)
            Spacer()
        }
        .frame(height: 80)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(.appBlue)
        }
    }
}

#Preview {
    LembreteCard(lembrete: LembreteModel(nome: "Teste", data: .now))
}
