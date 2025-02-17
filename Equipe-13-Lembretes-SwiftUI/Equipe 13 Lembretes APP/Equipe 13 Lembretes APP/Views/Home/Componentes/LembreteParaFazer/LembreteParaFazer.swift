//
//  LembreteParaFazer.swift
//  Equipe 13 Lembretes APP
//
//  Created by Ian Pacini on 17/02/25.
//

import SwiftUI

struct LembreteParaFazer: View {
    @State var lembrete: LembreteModel
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        return formatter
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Circle()
                    .frame(width: 40, height: 40)
                    .foregroundStyle(isLembreteCompletoColor())
                    .onTapGesture {
                        lembrete.isComplete.toggle()
                    }
            }
            .padding(.trailing, 8)
            .padding(.top, 8)
            
            VStack(alignment: .leading) {
                Text(lembrete.titulo)
                    .font(.system(size: 20))
                    .padding(.bottom, 32)
                    .foregroundStyle(.appDarkBlue)
                    .padding(.leading, 10)
                
                Text(dateFormatter.string(from: lembrete.data))
                    .font(.system(size: 22))
                    .foregroundStyle(.blue)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(.appLightGray)
                    }
                    .padding(.bottom, 18)
            }
            
        }
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    private func isLembreteCompletoColor() -> Color {
        if lembrete.isComplete {
            return .appLightPink
        } else {
            return .appLightPurple
        }
    }
}

#Preview {
    ZStack {
        Color.red
        
        VStack {
            LembreteParaFazer(
                lembrete:
                    LembreteModel(titulo: "Fazer compras",
                                  descricao: "Ir fazer compras no mercado",
                                  data: .now))
            .frame(width: 130)
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(0..<10) { _ in
                        LembreteParaFazer(
                            lembrete:
                                LembreteModel(titulo: "Fazer compras",
                                              descricao: "Ir fazer compras no mercado",
                                              data: .now))
                        .frame(width: 130)

                    }
                }
            }
        }
    }
}
