//
//  BaseIconView.swift
//  NOADance
//
//  Created by Jack on 2022/05/10.
//

import SwiftUI

struct BaseIconView: View {
    var imageName: String? = nil
    var imageSystemName: String? = nil
    var size: CGFloat? = AppConfig.iconSize
    var color: Color? = Color(R.color.iconColor.name)
    var paddingEdges: Edge.Set = .all
    var paddingLength: CGFloat? = nil
    
    var body: some View {
        Group {
            if imageName != nil {
                Image(imageName!)
                    .resizable()
                    .scaledToFit()
                    .frame(width: size, height: size)
                    .padding(paddingEdges, paddingLength)
                    .foregroundColor(color)
            }
            
            if imageSystemName != nil {
                Image(systemName: imageSystemName!)
                    .resizable()
                    .scaledToFit()
                    .frame(width: size, height: size)
                    .padding(paddingEdges, paddingLength)
                    .foregroundColor(color)
            }
        }
    }
}
