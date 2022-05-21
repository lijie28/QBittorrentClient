//
//  ErrorMesBarView.swift
//  NOADance
//
//  Created by Jack on 2022/05/10.
//

import SwiftUI

enum MesType {
    case error, success
}

struct MessageBarView: View {
    let mes: String?
    let type: MesType
    var bottomPadding: CGFloat? = 15.0
    var textHeight: CGFloat? = 30.0
    var body: some View {
        Group {
            if let mes = mes, type == .error {
                HStack {
                    Text(mes)
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: textHeight)
                }.background(Color.pink)
                    .padding(.bottom, bottomPadding)
            }
            else if let mes = mes, type == .success {
                HStack {
                    Text(mes)
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: textHeight)
                }.background(Color.green)
                    .frame(height: textHeight)
                    .padding(.bottom, bottomPadding)
            }
        }
    }
}
