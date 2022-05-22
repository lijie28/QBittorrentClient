//
//  BarItem.swift
//  NOADance
//
//  Created by Jack on 2022/05/10.
//

import SwiftUI

struct BaseButtonView: View {
    var imageName: String?
    var imageSystemName: String?
    var size: CGFloat? = AppConfig.iconSize
    var color: Color? = Color(R.color.iconColor.name)
    var paddingEdges: Edge.Set = .all
    var paddingLength: CGFloat? = nil
    var onClicked: () -> Void
    
    var body: some View {
        Group {
            if imageName != nil {
                Button(action: onClicked, label: {
                    Image(imageName!)
                        .resizable()
                        .scaledToFit()
                        .frame(width: size, height: size)
                        .padding(paddingEdges, paddingLength)
                        .foregroundColor(color)
                })
            }
            if imageSystemName != nil {
                Button(action: onClicked, label: {
                    Image(systemName: imageSystemName!)
                        .resizable()
                        .scaledToFit()
                        .frame(width: size, height: size)
                        .padding(paddingEdges, paddingLength)
                        .foregroundColor(color)
                })
            }
        }
    }
}

