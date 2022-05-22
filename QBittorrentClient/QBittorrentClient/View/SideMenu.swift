//
//  SideMenu.swift
//  QBittorrentClient
//
//  Created by Jack on 2022/05/22.
//

import SwiftUI

//extension View {
//    func eraseToAnyView() -> AnyView {
//        AnyView(self)
//    }
//}

struct SideMenu: View {
//    var selectedIndexs: [Int]
    let width: CGFloat
    let menuOpened: Bool
    let toggleMenu: () -> Void
    let selectButtonIndex: (Int) -> Void
    
    var body: some View {
        ZStack {
            GeometryReader { _ in
                EmptyView()
            }
            .background(Color.black.opacity(0.7))
            .opacity(self.menuOpened ? 1 : 0)
            .animation(Animation.default.delay(0.25), value: menuOpened)
            .edgesIgnoringSafeArea(.all)
            .onTapGesture {
                self.toggleMenu()
            }
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    MenuContent(width: width, selectButtonIndex: selectButtonIndex)
                    Spacer().edgesIgnoringSafeArea(.all)
                }
                Spacer().edgesIgnoringSafeArea(.all)
            }
            .animation(.default, value: menuOpened)
            .offset(x: menuOpened ? 0 : -width)
        }
    }
}


struct MenuContent: View {
    
    var width: CGFloat
    let selectButtonIndex: (Int) -> Void
    
    var body: some View
    {
        VStack(alignment: .leading, spacing: 0) {
            Button("all") {
                selectButtonIndex(0)
            }
            .padding( 20)
            .padding(.top, 50)
            Button("downloading") {
                selectButtonIndex(1)
            }
            .padding( 20)
//            .padding(.top, 20)
            Button("completed") {
                selectButtonIndex(2)
            }
            .padding( 20)
//            .padding(.top, 20)
            Button("paused") {
                selectButtonIndex(3)
            }
            .padding( 20)
//            .padding(.top, 20)
            Button("active") {
                selectButtonIndex(4)
            }
            .padding( 20)
//            .padding(.top, 20)
            Button("inactive") {
                selectButtonIndex(5)
            }
            .padding( 20)
            Button("pauseAll") {
                selectButtonIndex(6)
            }
            .padding( 20)
            Button("resumeAll") {
                selectButtonIndex(7)
            }
            .padding( 20)
//            .padding(.top, 20)
        }
    }
}
