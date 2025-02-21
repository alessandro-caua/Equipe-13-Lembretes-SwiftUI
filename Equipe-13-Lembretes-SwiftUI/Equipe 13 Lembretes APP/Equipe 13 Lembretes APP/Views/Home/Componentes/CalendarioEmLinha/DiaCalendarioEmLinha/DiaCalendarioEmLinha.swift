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
    var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        return dateFormatter
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Text(data.formatted(Date.FormatStyle().weekday(.narrow)))
            Text(dateFormatter.string(from: data))
        }
        .font(.system(size: 24))
        .foregroundStyle(isSelected ? .white : .gray)
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(isSelected ? .appDarkBlue : .white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct DiaCalendarioEmLinhaModel: Identifiable, Equatable {
    let id: UUID = UUID()
    var data: Date
    
}

private struct telaPreview: View {
    @State var diaSelecionado: DiaCalendarioEmLinhaModel
    
    var listaDia: [DiaCalendarioEmLinhaModel]
    
    init() {
        let diaDeHoje: DiaCalendarioEmLinhaModel = .init(data: .now)
        
        self.diaSelecionado = diaDeHoje
        
        self.listaDia = [
            .init(data: .now.addingTimeInterval(TimeInterval((-86400 * 5)))),
            .init(data: .now.addingTimeInterval(TimeInterval((-86400 * 4)))),
            .init(data: .now.addingTimeInterval(TimeInterval((-86400 * 3)))),
            .init(data: .now.addingTimeInterval(TimeInterval((-86400 * 2)))),
            .init(data: .now.addingTimeInterval(-86400)),
            diaDeHoje,
            .init(data: .now.addingTimeInterval(86400))
        ]
    }
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(listaDia) { dia in
                DiaCalendarioEmLinha(data: dia.data, isSelected: diaSelecionado == dia)
                    .frame(width: 64)
                    .onTapGesture {
                        diaSelecionado = dia
                    }
            }
        }
    }
}

#Preview {
    telaPreview()
}
