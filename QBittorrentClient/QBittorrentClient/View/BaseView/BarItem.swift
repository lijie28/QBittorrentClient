//
//  BarItem.swift
//  NOADance
//
//  Created by Jack on 2022/05/10.
//

import SwiftUI

struct BarButtonItem: View {
    var imageName: String?
    var imageSystemName: String?
    var size: CGFloat? = 20
    var onClicked: () -> Void
    
    var body: some View {
        Group {
            if imageName != nil {
                Button(action: onClicked, label: {
                    Image(imageName!)
                        .resizable()
                        .scaledToFit()
                        .frame(width: size, height: size)
                        .foregroundColor(Color(R.color.iconColor.name))
                })
            }
            if imageSystemName != nil {
                Button(action: onClicked, label: {
                    Image(systemName: imageSystemName!)
                        .resizable()
                        .scaledToFit()
                        .frame(width: size, height: size)
                        .foregroundColor(Color(R.color.iconColor.name))
                })
            }
        }
    }
}

struct BarImageItem: View {
    var imageName: String?
    var imageSystemName: String?
    var size: CGFloat? = 20
    var body: some View {
        Group {
            if imageName != nil {
                Image(imageName!)
                    .resizable()
                    .scaledToFit()
                    .frame(width: size, height: size)
            }
            if imageSystemName != nil {
                Image(systemName: imageSystemName!)
                    .resizable()
                    .scaledToFit()
                    .frame(width: size, height: size)
            }
        }
    }
}
