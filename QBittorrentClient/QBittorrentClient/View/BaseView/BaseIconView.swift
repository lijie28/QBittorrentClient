//
//  BaseIconView.swift
//  NOADance
//
//  Created by Jack on 2022/05/10.
//

import SwiftUI

struct BaseIconView: View {
    var name: String? = nil
    var systemName: String? = nil
    var size: CGFloat? = AppConfig.iconSize
    var color: Color? = Color(R.color.iconColor.name)
    var paddingEdges: Edge.Set = .all
    var paddingLength: CGFloat? = nil
    
    var body: some View {
        Group {
            if name != nil {
                Image(name!)
                    .resizable()
                    .scaledToFit()
                    .frame(width: size, height: size)
                    .padding(paddingEdges, paddingLength)
                    .foregroundColor(color)
            }
            
            if systemName != nil {
                Image(systemName: systemName!)
                    .resizable()
                    .scaledToFit()
                    .frame(width: size, height: size)
                    .padding(paddingEdges, paddingLength)
                    .foregroundColor(color)
            }
        }
    }
}
